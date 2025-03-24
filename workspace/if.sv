//%
// PC module at IF stage
// Function:
// - Select next PC given the branch taken signal
// - Keep the PC when write signal is low
// - Fetch the inst from InstMem

`include "defines.sv"
module PC(
    input   logic                       clk,
    input   logic                       rst,
    //input   logic                       PC_write_en,
    //input   logic                       is_uncon_branch,
    input   logic[`STALL_WIDTH]         stall,
    input   logic                       branch_taken,
    input   logic[`MEM_ADDR_WIDTH-1:0]  branch_addr,
    output  logic                       rd_en,
    output  logic[31:0]                 PC_out
);

    // read enable signal for InstMem
    always_ff @(posedge clk) begin
        if(rst) begin
            rd_en <= 0;
            PC_out <= 0;
        end
        else
            rd_en <= 1;  
    end

    // PC update logic
    logic[31:0] PC_next;
    always_ff @(posedge clk) begin
        if(rst)
            PC_out <= 32'b0;
        else if(stall == `STALL_LOAD)   // re-fetch the instruction
            PC_out <= PC_out;
        else
            PC_out <= PC_next;
    end

    assign PC_next = branch_taken ? branch_addr : PC_out + 4;


endmodule
