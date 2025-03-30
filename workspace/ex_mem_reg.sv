
`include "defines.sv"
module ex_mem_reg(
    input   logic                       clk,
    input   logic                       rst,
    input   logic[`REG_DATA_WIDTH-1:0]  alu_res_ex,
    input   logic[`REG_DATA_WIDTH-1:0]  bypass_op2_ex,
    // rd address for WB and forwarding
    input   logic[`REG_ADDR_WIDTH-1:0]  rd_addr_ex,
    // control bits
    input   logic                       mem_read_ex,
    input   logic                       mem_write_ex,
    input   logic[`MASK_WIDTH-1:0]      mask_ex, 
    input   logic                       unsigned_load_ex,
    input   logic                       reg_write_ex,
    input   logic                       mem_to_reg_ex,

    // memory address & data
    output  logic[`REG_DATA_WIDTH-1:0]  alu_res_mem,    // address
    output  logic[`REG_DATA_WIDTH-1:0]  bypass_op2_mem, // data
    // rd address for WB and forwarding
    output  logic[`REG_ADDR_WIDTH-1:0]  rd_addr_mem,
    // control bits
    output  logic                       mem_read_mem,
    output  logic                       mem_write_mem,
    output  logic[`MASK_WIDTH-1:0]      mask_mem,
    output  logic                       unsigned_load_mem,
    output  logic                       reg_write_mem,
    output  logic                       mem_to_reg_mem
);
    always_ff @(posedge clk) begin
        if(rst) begin
            alu_res_mem         <=      `MEM_ADDR_ZERO;
            bypass_op2_mem      <=      `REG_DATA_ZERO;
            rd_addr_mem         <=      `REG_ADDR_ZERO;
            mem_read_mem        <=      0;
            mem_write_mem       <=      0;
            mask_mem            <=      `MASK_W;
            unsigned_load_mem   <=      0;
            reg_write_mem       <=      0;
            mem_to_reg_mem      <=      0;
        end
        else begin
            alu_res_mem         <=      alu_res_ex;
            bypass_op2_mem      <=      bypass_op2_ex;
            rd_addr_mem         <=      rd_addr_ex;
            mem_read_mem        <=      mem_read_ex;
            mem_write_mem       <=      mem_write_ex;
            mask_mem            <=      mask_ex;
            unsigned_load_mem   <=      unsigned_load_ex;
            reg_write_mem       <=      reg_write_ex;
            mem_to_reg_mem      <=      mem_to_reg_ex;
        end
    end
endmodule