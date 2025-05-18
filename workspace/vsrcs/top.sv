
`include "defines.sv"
module top(
    input   logic   clk,
    input   logic   rst
);
    // Instruction memory interface
    logic[`REG_DATA_WIDTH-1:0]  irom_data;
    logic[`MEM_ADDR_WIDTH-1:0]  irom_addr;
    logic                       irom_rd_en;
    // Data memory interface
    logic[`REG_DATA_WIDTH-1:0]  dram_rd_data;
    logic[`MEM_ADDR_WIDTH-1:0]  dram_addr;
    logic[`REG_DATA_WIDTH-1:0]  dram_wr_data;
    logic                       dram_wr_en;
    logic                       dram_rd_en;
    logic[`MASK_WIDTH-1:0]      dram_mask;

    core core_u(
        .clk(clk),
        .rst(rst),
        // IMEM
        .irom_data(irom_data),
        .irom_addr(irom_addr),
        .irom_rd_en(irom_rd_en),
        // DMEM
        .dram_rd_data(dram_rd_data),
        .dram_addr(dram_addr),
        .dram_wr_data(dram_wr_data),
        .dram_wr_en(dram_wr_en),
        .dram_rd_en(dram_rd_en),
        .dram_mask(dram_mask)
    );

    // handicraft memory instances
    inst_memory imem(
        .rd_en(irom_rd_en),
        .addr(irom_addr),
        .inst(irom_data)
    );

    data_memory dmem(
        .clk(clk),
        .rd_en(dram_rd_en),
        .wr_en(dram_wr_en),
        .mask(dram_mask),
        .addr(dram_addr),
        .wr_data(dram_wr_data),
        .rd_data(dram_rd_data)
    );

endmodule