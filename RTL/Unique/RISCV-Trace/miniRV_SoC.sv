// Add your code here, or replace this file.
`include "defines.sv"
module miniRV_SoC (
    input  logic         fpga_clk,
    input  logic         fpga_rst,

    output wire        debug_wb_have_inst,   // WB阶段是否有指令 (对单周期CPU，可在复位后恒为1)
    output wire [31:0] debug_wb_pc,          // WB阶段的PC (若wb_have_inst=0，此项可为任意值)
    output wire        debug_wb_ena,         // WB阶段的寄存器写使能 (若wb_have_inst=0，此项可为任意值)
    output wire [ 4:0] debug_wb_reg,         // WB阶段写入的寄存器号 (若wb_ena或wb_have_inst=0，此项可为任意值)
    output wire [31:0] debug_wb_value        // WB阶段写入寄存器的值 (若wb_ena或wb_have_inst=0，此项可为任意值)
);


    // Interface to IROM
    logic[`REG_DATA_WIDTH-1:0]   irom_data;
    logic[`MEM_ADDR_WIDTH-1:0]   irom_addr;
    
    // Interface to DRAM
    logic[`REG_DATA_WIDTH-1:0]   dram_rd_data;
    logic[`MEM_ADDR_WIDTH-1:0]   dram_addr;
    logic[`REG_DATA_WIDTH-1:0]   dram_wr_data;
    logic                        dram_wr_ena;

    logic cpu_clk = fpga_clk;
    logic cpu_rst = fpga_rst; 
    myCPU my_cpu(
        .clk(cpu_clk),
        .rst(cpu_rst),
        .irom_data(irom_data),
        .irom_addr(irom_addr),
        .dram_rd_data(dram_rd_data),
        .dram_addr(dram_addr),
        .dram_wr_data(dram_wr_data),
        .dram_wr_ena(dram_wr_ena),
        // debug interface
        .debug_wb_have_inst(debug_wb_have_inst),
        .debug_wb_pc(debug_wb_pc),
        .debug_wb_ena(debug_wb_ena),
        .debug_wb_reg(debug_wb_reg),
        .debug_wb_value(debug_wb_value)
    );

    logic[`MEM_ADDR_WIDTH-1:0]  masked_irom_addr = irom_addr >> 2;
    IROM irom(
        .a(masked_irom_addr),
        .spo(irom_data)
    );

    logic[`MEM_ADDR_WIDTH-1:0]  masked_dram_addr = dram_addr >> 2;
    DRAM dram(
        .clk(fpga_clk),
        .a(masked_dram_addr),
        .spo(dram_rd_data),
        .we(dram_wr_ena),
        .d(dram_wr_data)
    );

endmodule