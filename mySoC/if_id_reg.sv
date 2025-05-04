//%
// Pipeline register file between Fetch and Decode stages
// Functions:
// - Pass PC and corresponding instruction
// - If data hazzard stall occurs, stall the stage
// - If control hazzard occurs, flush the instruction field

`include "defines.sv"
module if_id_reg(
    input   logic                       clk,
    input   logic                       rst,
    input   logic[`STALL_WIDTH-1:0]     stall,
    input   logic                       branch_taken,   // flush for predict_untaken
    input   logic[`MEM_ADDR_WIDTH-1:0]  PC_if,
    input   logic[`REG_DATA_WIDTH-1:0]  inst_if,
    output  logic[`MEM_ADDR_WIDTH-1:0]  PC_id,
    output  logic[`REG_DATA_WIDTH-1:0]  inst_id,

    // if has inst ?
    output      logic                       has_inst_id
);
    // pass PC and inst
    always_ff @(posedge clk) begin
        if(rst) begin
            PC_id   <=  0;
            inst_id <=  0;

            has_inst_id     <=      0;
        end
        else if(stall == `STALL_LOAD || stall == `STALL_BRANCH) begin // preserve the fetched inst and pc 
            PC_id   <=  PC_id;
            inst_id <=  inst_id;

            has_inst_id <= has_inst_id;
        end
        else begin
            PC_id   <=  PC_if;
            inst_id <=  branch_taken ? 32'b0 : inst_if; // flush the fetched inst

            has_inst_id     <=      branch_taken ? 0 : 1;
        end
    end

endmodule