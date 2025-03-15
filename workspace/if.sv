//%
// PC module at IF stage
// Function:
// - Select next PC given the branch taken signal
// - Keep the PC when write signal is low
// - Fetch the inst from InstMem

`include "defines.sv"
module PC(
    input   wire            clk,
    input   wire            rst,
    input   wire            PC_write_en,
    input   wire            is_uncon_branch,
    input   wire            stall,
    input   wire            branch_taken,
    input   wire[31:0]      branch_addr,
    output  logic           rd_en,
    output  logic[31:0]     PC_out
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
        else if(PC_write_en)
            PC_out <= PC_next;
        else
            PC_out <= PC_out;
    end

    assign PC_next = branch_taken ? branch_addr : PC_out + 4;


endmodule
