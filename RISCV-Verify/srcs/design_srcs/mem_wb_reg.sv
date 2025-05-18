
`include "defines.sv"
module mem_wb_reg(
    input       logic                       clk,
    input       logic                       rst,
    // mem stage outputs
    input       logic[`REG_DATA_WIDTH-1:0]  mem_data_mem,
    input       logic[`REG_DATA_WIDTH-1:0]  alu_data_mem, // from bypass_alu_res at mem stage
    // rd address for WB stage and forwarding
    input       logic[`REG_ADDR_WIDTH-1:0]  rd_addr_mem,
    // wb control signals from ex/mem reg
    input       logic                       reg_write_mem,
    input       logic                       mem_to_reg_mem,

    // if has inst ?
    input       logic                       has_inst_mem,
    // if has inst, what's the pc ?
    input       logic[`REG_DATA_WIDTH-1:0]  inst_pc_mem,
    // if has inst ?
    output      logic                       has_inst_wb,
    // if has inst, what's the pc ?
    output      logic[`REG_DATA_WIDTH-1:0]  inst_pc_wb,

    output      logic[`REG_DATA_WIDTH-1:0]  mem_data_wb,
    output      logic[`REG_DATA_WIDTH-1:0]  alu_data_wb,
    // rd address for WB stage and forwarding
    output      logic[`REG_ADDR_WIDTH-1:0]  rd_addr_wb,
    // wb control signals from ex/mem reg
    output      logic                       reg_write_wb,
    output      logic                       mem_to_reg_wb
);
    always_ff @(posedge clk) begin
        if(rst) begin
            mem_data_wb     <=      `REG_DATA_ZERO;
            alu_data_wb     <=      `REG_DATA_ZERO;
            rd_addr_wb      <=      `REG_ADDR_ZERO;
            reg_write_wb    <=      0;
            mem_to_reg_wb   <=      0;
            
            has_inst_wb     <=      0;
            inst_pc_wb      <=      `REG_DATA_ZERO;
        end
        else begin
            mem_data_wb     <=      mem_data_mem;
            alu_data_wb     <=      alu_data_mem;
            rd_addr_wb      <=      rd_addr_mem;
            reg_write_wb    <=      reg_write_mem;
            mem_to_reg_wb   <=      mem_to_reg_mem;

            has_inst_wb     <=      has_inst_mem;
            inst_pc_wb      <=      inst_pc_mem;
        end
    end
endmodule
