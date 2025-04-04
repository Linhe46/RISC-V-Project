
`include "defines.sv"
module if_tb(
    input   logic                       clk,
    input   logic                       rst,
    input   logic[`STALL_WIDTH-1:0]     stall,
    input   logic                       branch_taken,
    input   logic[`MEM_ADDR_WIDTH-1:0]  branch_addr,
    output  logic[`MEM_ADDR_WIDTH-1:0]  pc_if,
    output  logic[`REG_DATA_WIDTH-1:0]  inst_if
);
    // PC reg <-> IF stage signals
    logic[`MEM_ADDR_WIDTH-1:0]  pc;
    logic   pc_wr_en;

    // inst mem <-> IF stage signals
    logic[`REG_DATA_WIDTH-1:0] inst_imem;
    logic   imem_rd_en;

    if_ if_stage(
        .rst(rst),
        .stall(stall),
        .pc_in(pc),
        .inst_imem(inst_imem),
        .pc_wr_en(pc_wr_en),
        .imem_rd_en(imem_rd_en),
        .pc_out(pc_if),
        .inst(inst_if)
    );

    PC pc_reg(
        .clk(clk),
        .rst(rst),
        .wr_en(pc_wr_en),
        .branch_taken(branch_taken),
        .branch_addr(branch_addr),
        .PC_out(pc)
    );

    inst_memory imem(
        .rd_en(imem_rd_en),
        .addr(pc_if),
        .inst(inst_imem)
    );

endmodule