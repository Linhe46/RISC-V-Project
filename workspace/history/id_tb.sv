//%
// Testbench for id stage, including ID stage, ID/EX regfile and Registers
// Simply connect them and debugging

/* verilator lint_off WIDTHEXPAND */
`include "defines.sv"
module id_tb(
    input   logic       clk,
    input   logic       rst,
    input   logic[5:0]  stall,
    input   logic[31:0] pc,
    input   logic[31:0] inst,

    output    logic     rs1_rd_en,
    output    logic     rs2_rd_en,
    //output    logic        rd_wr_en,    // replaced by reg_write signal

    output    logic[4:0]  rs1_addr,
    output    logic[4:0]  rs2_addr,
    output    logic[4:0]  rd_addr,
    //output    logic[31:0]    rs1_data,        send to ID/EX from registers
    //output    logic[31:0]    rs2_data,
    output    logic[31:0] imm,
    /* branch judge output */
    output    logic        branch_taken,
    output    logic[31:0]  branch_addr,
    //output    logic[31:0]    link_addr,
    /* pipeline regfile control bits */
    // EX stage
    output    logic[3:0]   alu_op,
    output    logic        alu_src,
    // MEM stage
    output    logic         mem_read,            // load
    output    logic         mem_write,            // store
    output    logic[1:0]    mask,                // load/store mask
    output    logic         unsigned_load,        // if unsigned-load or not
    // WB stage
    output    logic       reg_write,
    output    logic       mem_to_reg    
);
    logic[31:0] rs1_data_reg;
    logic[31:0] rs2_data_reg;
    registers regfile_u(
        clk, rst, 1'b0, rs2_rd_en, rs1_rd_en, rs2_addr, rs1_addr, rd_addr, `REG_ADDR_ZERO,
        rs2_data_reg, rs1_data_reg
    );
    id id_u(
        rst, stall, pc, inst, rs1_data_reg, rs2_data_reg,   // inputs
        rs1_rd_en, rs2_rd_en, rs1_addr, rs2_addr, rd_addr, imm,
        branch_taken, branch_addr, /*link_addr,*/ 
        alu_op, alu_src,
        mem_read, mem_write, mask, unsigned_load,
        reg_write, mem_to_reg
    );
    /* From register file begin */
    logic[`REG_DATA_WIDTH-1:0]  rs1_data;
    logic[`REG_DATA_WIDTH-1:0]  rs2_data;
    /* From register file end */
    logic[`REG_DATA_WIDTH-1:0]  imm_ex;
    logic                       rs1_rd_en_ex;
    logic                       rs2_rd_en_ex;
    logic[`REG_ADDR_WIDTH-1:0]  rs1_addr_ex;
    logic[`REG_ADDR_WIDTH-1:0]  rs2_addr_ex;
    logic[`REG_ADDR_WIDTH-1:0]  rd_addr_ex;
    /* pipeline regfile control bits */
    // EX stage
    logic[`ALU_OP_WIDTH-1:0]    alu_op_ex;
    logic                       alu_src_ex;
    // MEM stage
    logic                   mem_read_ex;
    logic                   mem_write_ex;
    logic[`MASK_WIDTH-1:0]  mask_ex;
    logic                   unsigned_load_ex;
    // WB stage
    logic       reg_write_ex;
    logic       mem_to_reg_ex;

    id_ex_reg id_ex_reg_u(
        clk, rst, stall,
        // register signals(in)
        rs1_data_reg, rs2_data_reg,
        // id signals(in)
        imm, rs1_rd_en, rs2_rd_en, rs1_addr, rs2_addr, rd_addr,
        alu_op, alu_src,
        mem_read, mem_write, mask, unsigned_load,
        reg_write, mem_to_reg,
        // ex signals(out)
        rs1_data, rs2_data,
        imm_ex, rs1_rd_en_ex, rs2_rd_en_ex, rs1_addr_ex, rs2_addr_ex, rd_addr_ex,
        alu_op_ex, alu_src_ex,
        mem_read_ex, mem_write_ex, mask_ex, unsigned_load_ex,
        reg_write_ex, mem_to_reg_ex
    );

endmodule
