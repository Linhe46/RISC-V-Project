//%
// Pipeline register file between Decode and Execute stages
// Functions:
// - Pass data signals for ALU unit to compute(rs1/rs2 data, immediate)
// - Pass control signals for EX, MEM and WB stages
// - Pass reg addresses and enable info to detect forwarding

`include "defines.sv"
module id_ex_reg(
    input   logic                       clk,
    input   logic                       rst,
    input   logic[`STALL_WIDTH-1:0]     stall,
    /* to next stage */
    /* From register file begin */
    input   logic[`REG_DATA_WIDTH-1:0]  rs1_data_reg,
    input   logic[`REG_DATA_WIDTH-1:0]  rs2_data_reg,
    /* From register file end */
    input   logic[`REG_DATA_WIDTH-1:0]  imm_id,
    input   logic                       rs1_rd_en_id,
    input   logic                       rs2_rd_en_id,
    input   logic[`REG_ADDR_WIDTH-1:0]  rs1_addr_id,
    input   logic[`REG_ADDR_WIDTH-1:0]  rs2_addr_id,
    input   logic[`REG_ADDR_WIDTH-1:0]  rd_addr_id,
    /* pipeline regfile control bits */
    // EX stage
    input   logic[`ALU_OP_WIDTH-1:0]    alu_op_id,
    input   logic                       alu_src_id,
    // MEM stage
    input   logic                   mem_read_id,
    input   logic                   mem_write_id,
    input   logic[`MASK_WIDTH-1:0]  mask_id,        
    input   logic                   unsigned_load_id,
    // WB stage
    input   logic       reg_write_id,
    input   logic       mem_to_reg_id,

    /* From register file begin */
    output   logic[`REG_DATA_WIDTH-1:0]  rs1_data,
    output   logic[`REG_DATA_WIDTH-1:0]  rs2_data,
    /* From register file end */
    output   logic[`REG_DATA_WIDTH-1:0]  imm_ex,
    output   logic                       rs1_rd_en_ex,
    output   logic                       rs2_rd_en_ex,
    output   logic[`REG_ADDR_WIDTH-1:0]  rs1_addr_ex,
    output   logic[`REG_ADDR_WIDTH-1:0]  rs2_addr_ex,
    output   logic[`REG_ADDR_WIDTH-1:0]  rd_addr_ex,
    /* pipeline regfile control bits */
    // EX stage
    output   logic[`ALU_OP_WIDTH-1:0]    alu_op_ex,
    output   logic                       alu_src_ex,
    // MEM stage
    output   logic                   mem_read_ex,
    output   logic                   mem_write_ex,
    output   logic[`MASK_WIDTH-1:0]  mask_ex,
    output   logic                   unsigned_load_ex,
    // WB stage
    output   logic       reg_write_ex,
    output   logic       mem_to_reg_ex
);
    always_ff @(posedge clk) begin
        // if stall, reset control bits
        if(rst || stall == `STALL_LOAD || stall == `STALL_BRANCH)
        begin
            rs1_data        <=  `REG_DATA_ZERO;
            rs2_data        <=  `REG_DATA_ZERO;
            imm_ex          <=  `REG_DATA_ZERO;
            rs1_rd_en_ex    <=  1'b0;
            rs2_rd_en_ex    <=  1'b0;
            rs1_addr_ex     <=  `REG_ADDR_ZERO;
            rs2_addr_ex     <=  `REG_ADDR_ZERO;
            rd_addr_ex      <=  `REG_ADDR_ZERO;
            alu_op_ex       <=  `ALU_NOP;
            alu_src_ex      <=  `ALU_SRC_RS2;
            mem_read_ex     <=  1'b0;
            mem_write_ex    <=  1'b0;
            mask_ex         <=  `MASK_W;
            unsigned_load_ex<=  1'b0;
            reg_write_ex    <=  1'b0;
            mem_to_reg_ex   <=  1'b0;
        end
        else begin
            rs1_data        <=  rs1_data_reg;
            rs2_data        <=  rs2_data_reg;
            imm_ex          <=  imm_id;
            rs1_rd_en_ex    <=  rs1_rd_en_id;
            rs2_rd_en_ex    <=  rs2_rd_en_id;
            rs1_addr_ex     <=  rs1_addr_id;
            rs2_addr_ex     <=  rs2_addr_id;
            rd_addr_ex      <=  rd_addr_id;
            alu_op_ex       <=  alu_op_id;
            alu_src_ex      <=  alu_src_id;
            mem_read_ex     <=  mem_read_id;
            mem_write_ex    <=  mem_write_id;
            mask_ex         <=  mask_id;
            unsigned_load_ex<=  unsigned_load_id;
            reg_write_ex    <=  reg_write_id;
            mem_to_reg_ex   <=  mem_to_reg_id;
        end
    end

endmodule
