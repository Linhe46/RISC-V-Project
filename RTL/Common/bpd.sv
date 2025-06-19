`include "defines.sv"

module branchPredictor(
    input   logic           clk,
    input   logic           rst,
    input   logic[31:0]     pc_BPD, // current pc to predict
    // traced info. to update predictor if miss (id stage)
    input   logic           bp_i,   // traced prediction output
    input   logic[31:0]     BTB_target_i, // traced branch target address
    input   logic[31:0]     pc,     // traced pc
    input   logic           is_branch, // is branch/jump instruction signal
    input   logic           branch_taken,
    input   logic[31:0]     branch_addr,
    input   logic[`STALL_WIDTH-1:0] stall,
    /*
    input   logic           BTB_we, // write enable for BTB
    input   logic[31:0]     BTB_wr_addr, // address to write
    input   logic[31:0]     BTB_wr_data, // data to write
    */

    output  logic           bp_o,// branch prediction output
    output  logic[31:0]     BTB_target_o,// target address from BTB
    output  logic           flush,
    output  logic[31:0]     PC_correct
);
    logic no_stall;
    assign no_stall = ~ (stall == `STALL_LOAD | stall == `STALL_BRANCH); // if stalled, no update/correction
    
    //========================================
    // ===== Local Branch Predictor Logic ====
    //========================================
    logic[`BHT_ENTRY_WIDTH-1:0] BHT[`BHT_DEPTH-1:0]; // Local Branch History Table
    logic[1:0] LPHT[`LPHT_DEPTH-1:0]; // Local Predictor History Table (2bit saturating counters)

    logic[`BHT_DEPTH_WIDTH-1:0] Lhash = pc_BPD[`BHT_DEPTH_WIDTH-1+2:2]; // Index for BHT
    // 2-level mapping using concatenation of BHT index and pc bits
    `define PC_CONCATNATE_WIDTH `LPHT_DEPTH_WIDTH - `BHT_ENTRY_WIDTH
    logic [`LPHT_DEPTH_WIDTH-1:0] idxLPHT = {BHT[Lhash], pc_BPD[`PC_CONCATNATE_WIDTH-1+2:2]}; // Local Predictor History Table Index
    logic [1:0] Lvalue = LPHT[idxLPHT]; // Local Predictor History Table Value

    // update BHT and LPHT based on branch outcome(sequntial logic)
    logic [`LPHT_DEPTH_WIDTH-1:0] idxLPHTBack; 
    logic [`BHT_DEPTH_WIDTH-1:0] LhashBack = pc[`BHT_DEPTH_WIDTH-1+2:2]; // Index for BHT
    logic en, real_sig;
    assign idxLPHTBack = {BHT[LhashBack], pc[`PC_CONCATNATE_WIDTH-1+2:2]};
    assign en = is_branch & (pc != 0) & no_stall;   // update history for every bra/jmp
    assign real_sig = is_branch ? branch_taken : 1'b0;
    /*
    always_comb begin
        if(en) begin
            idxLPHTBack = {BHT[LhashBack], pc[`PC_CONCATNATE_WIDTH-1+2:2]};
            // update LPHT 2bit counters
            if(real_sig && LPHT[idxLPHTBack] != 2'b11) begin
                LPHT[idxLPHTBack] = LPHT[idxLPHTBack] + 1; // Increment if taken
            end else if(!real_sig && LPHT[idxLPHTBack] != 2'b00) begin
                LPHT[idxLPHTBack] = LPHT[idxLPHTBack] - 1; // Decrement if not taken
            end
            // update BHT entry
            BHT[LhashBack] = {BHT[LhashBack], real_sig};
        end
    end
    */
    logic[1:0] update_val;
    always_comb begin
        if(real_sig) begin
            if(LPHT[idxLPHTBack] != 2'b11) begin
                update_val = LPHT[idxLPHTBack] + 1; // Increment if taken
            end else begin
                update_val = LPHT[idxLPHTBack]; // No change if already strongly taken
            end
        end else begin
            if(LPHT[idxLPHTBack] != 2'b00) begin
                update_val = LPHT[idxLPHTBack] - 1; // Decrement if not taken
            end else begin
                update_val = LPHT[idxLPHTBack]; // No change if already strongly not taken
            end
        end
    end
    // update BHT
    always_ff @(posedge clk) begin            
        if(rst) begin
            for(int i = 0; i < `BHT_DEPTH; i++) begin
                BHT[i] <= 0; // Reset BHT entries
            end
        end else if(en) begin
            // update BHT entry
            BHT[LhashBack] <= {BHT[LhashBack][`BHT_ENTRY_WIDTH-2:0], real_sig};
        end
    end
    // update LPHT 2bit saturating counters
    always_ff @(posedge clk) begin
        if(rst) begin
            for(int i = 0; i < `LPHT_DEPTH; i++) begin
                LPHT[i] <= 2'b01; // Reset LPHT entries
            end
        end
        else if(en) begin
            // update LPHT 2bit counters
            LPHT[idxLPHTBack] <= update_val;
        end
    end
    // predict result (combinational logic)
    logic p_local;
    /*
    always_comb begin
        // Local Predictor Logic
        // 2-bit saturating counter for prediction
        case (Lvalue)
            2'b00: p_local = 0; // Strongly Not Taken
            2'b01: p_local = 0; // Weakly Not Taken
            2'b10: p_local = 1; // Weakly Taken
            2'b11: p_local = 1; // Strongly Taken
            default: p_local = 0; // Default to Not Taken
        endcase
    end
    */
    assign p_local = Lvalue[1];

    // =========================================
    // ===== Branch Target Buffer Logic =====
    // =========================================

    logic[31:0] BTB_keys [`BTB_DEPTH-1:0];
    logic[31:0] BTB_values [`BTB_DEPTH-1:0];
    logic[`BTB_DEPTH-1:0] BTB_valid; // Valid bits for BTB entries (do not differ jump and branch)
    integer j;
    logic BTB_we; // Write enable for BTB
    logic[31:0] BTB_wr_addr; // Address to write in BTB
    logic[31:0] BTB_wr_data; // Data to write in BTB
    assign BTB_we = is_branch & branch_taken & (pc != 0) & no_stall; // update BTB only if taken
    assign BTB_wr_addr = pc; // Address to write in BTB is the current pc
    assign BTB_wr_data = branch_addr; // Data to write in BTB is
    always_ff @(posedge clk) begin
        if(rst) begin
            for(int i = 0; i < `BTB_DEPTH; i++) begin
                BTB_keys[i] <= 0;
                BTB_values[i] <= 0;
                BTB_valid[i] <= 0;
            end
        end
        else if(BTB_we) begin
            j = 0;
            for(int i = 0; i < `BTB_DEPTH; i++) begin
                if(BTB_keys[i] == BTB_wr_addr) begin
                    j = 1; // Find the index of the entry to update
                end
            end

            // if not found, push the new entry to head and pop the tail
            if (j == 0) begin
                for(int i = 0; i < `BTB_DEPTH - 1; i++) begin
                    BTB_keys[i + 1] <= BTB_keys[i];
                    BTB_values[i + 1] <= BTB_values[i];
                    BTB_valid[i + 1] <= BTB_valid[i];
                end
                BTB_keys[0] <= BTB_wr_addr;
                BTB_values[0] <= BTB_wr_data;
                BTB_valid[0] <= 1;
            end
        end
    end

    integer k;
    logic BTB_hit; // Hit signal for BTB
    always_comb begin
        k = 0;
        BTB_target_o = 32'b0;
        BTB_hit = 1'b0;
        for(int i = 0; i < `BTB_DEPTH; i++) begin
            if (BTB_keys[i] == pc_BPD && BTB_valid[i]) begin
                BTB_target_o = BTB_values[i]; // If found, set the target address
                BTB_hit = 1;
                k = 1; // Find the index of the entry to read
            end
            else if(k == 0) begin
                BTB_target_o = 0; // If not found, set target to 0
                BTB_hit = 0; // No hit
            end
        end
    end
    assign bp_o = p_local & BTB_hit; // Branch prediction Output
    // flush correction for misprediction (false direction or target)
    assign flush = ((bp_i != branch_taken) | (bp_i == branch_taken && BTB_target_i != branch_addr)) & pc != 0 & no_stall;
    assign PC_correct = branch_taken ? branch_addr : pc + 4; // Corrected PC for flush

endmodule
