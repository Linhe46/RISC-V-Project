//%
// Pipeline register file between Fetch and Decode stages
// Functions:
// - Pass PC and corresponding instruction
// - If data hazzard stall occurs, stall the stage
// - If control hazzard occurs, flush the instruction field

`include "defines.sv"
module if_id_reg(
    input   logic           clk,
    input   logic           rst,
    input   logic[5:0]      stall,
    input   logic[31:0]     PC_if,
    input   logic[31:0]     inst_if,
    output  logic[31:0]     PC_id,
    output  logic[31:0]     inst_id
);
    // pass PC and inst
    always_ff @(posedge clk) begin
        if(rst) begin
            PC_id   <= 0;
            inst_id <= 0;
        end
        else begin
            PC_id   <= PC_if;
            inst_id <= stall == `STALL_BRANCH ? 32'b0 : inst_if;
        end
    end

endmodule