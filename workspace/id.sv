//%
// ID stage
// Function:
// - Decode the instruction and generate imm, alu_ops
// - Perform branch operation
// - Get rs1/rs2 values from registers

/* verilator lint_off WIDTHEXPAND */
`include "defines.sv"
module id(
	input	logic       rst,
	input	logic[5:0]	stall,
	input	logic[31:0]	pc,
	input	logic[31:0]	inst,
	input	logic[31:0]	rs1_data_reg,
	input	logic[31:0] rs2_data_reg,
	
	output	logic		rs1_rd_en,
	output	logic		rs2_rd_en,
	//output	logic		rd_wr_en,	// replaced by reg_write signal

	output	logic[4:0]	rs1_addr,
	output	logic[4:0]  rs2_addr,
	output	logic[4:0] 	rd_addr,
	//output	logic[31:0]	rs1_data,		send to ID/EX from registers
	//output	logic[31:0]	rs2_data,
	output	logic[31:0] imm,
	/* branch judge output */
	output	logic		branch_taken,
	output	logic[31:0]	branch_addr,
	//output	logic[31:0]	link_addr,
	/* pipeline regfile control bits */
	// EX stage
	output	logic[3:0]	alu_op,
	output	logic		alu_src,
	// MEM stage
	output	logic 		mem_read,			// load
	output  logic		mem_write,			// store
	output  logic[1:0]	mask,				// load/store mask
	output	logic 		unsigned_load,		// if unsigned-load or not
	// WB stage
	output 	logic		reg_write,
	output	logic		mem_to_reg	
);

	/* instruction decoder	*/
	// function bits and opcode
	logic[6:0] opcode 	= inst[6:0];
	logic[2:0] funct3 	= inst[14:12];
	logic[6:0] funct7 	= inst[31:25];
	// src/dst regs
	logic[4:0] rs2 		= inst[24:20];
	logic[4:0] rs1		= inst[19:15];
	logic[4:0] rd		= inst[11:7];
	// immediate generation
	logic[11:0] I_imm	= inst[31:20];
	logic[11:0] S_imm	= {inst[31:25], inst[11:7]};
	logic[19:0] U_imm	= inst[31:12];
	// B/J fmt are variations of S/U fmt, shift by add a LSB 0
	//logic[12:0] B_imm	= {inst[31], inst[7], inst[30:25], inst[11:8], 1'b0}; 		// bug in sim: always zero
	//logic[20:0] J_imm	= {inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};		// bug in sim: always zero
	/*
	logic[11:0] B_imm_new 	= {inst[31], inst[7], inst[30:25], inst[11:8]}; 
	logic[19:0] J_imm_new	= {inst[31], inst[19:12], inst[20], inst[30:21]};
	logic[12:0] B_imm		= 	B_imm_new << 1;
	//logic[20:0] J_imm		= 	J_imm_new << 1;			// also bug ??
	//logic[20:0]	J_imm		= {J_imm_new, 1'b0};	// also bug ???
	*/
	logic[31:0] sext_shift_B_imm;
	assign sext_shift_B_imm		= 	{{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0}; 
	logic[31:0] sext_shift_J_imm;
	assign sext_shift_J_imm 	= 	{{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};

	/* next PC */
	logic[31:0] pc_next = pc + 4; 
	/* branch signals generation */
	/*
	logic[31:0] pc_bra	= pc + {{19{B_imm[12]}}, B_imm};
	logic[31:0] pc_jal  = pc + sext_J_imm;
	logic[31:0] pc_jalr	= rs1_data_reg + {{11{J_imm[20]}}, J_imm};
	*/
	logic[31:0] pc_bra	= pc + sext_shift_B_imm;
	logic[31:0] pc_jal  = pc + sext_shift_J_imm;
	logic[31:0] pc_jalr	= rs1_data_reg + sext_shift_J_imm;

	// branch if taken
	logic rs1_eq_rs2	= 	rs2_data_reg == rs1_data_reg;
	logic rs1_ne_rs2	= 	rs2_data_reg != rs1_data_reg;
	function signed_lt;
		input [31:0] rs1, rs2;
		logic res;
		if(rs1[31] != rs2[31]) res = rs1[31];
		else res = rs1 < rs2;
	endfunction
	logic rs1_lt_rs2	= 	signed_lt(rs1_data_reg, rs2_data_reg); 
	logic rs1_ge_rs2	=  ~signed_lt(rs1_data_reg, rs2_data_reg);
	logic rs1_ltu_rs2	=	rs1_data_reg < rs2_data_reg;
	logic rs1_geu_rs2	=  ~(rs1_data_reg < rs2_data_reg);

	/* branch unit */
	// need forwarding

	// assignment macro
	/*
	`define set_output(rs1_addr_, rs2_addr_, rd_addr_, rs1_data_, rs2_data_, alu_op_, alu_src_, mem_read_, mem_write, reg_write_, mem_to_reg_)	\
		rs1_addr 	= 	rs1_addr_; 		\
		rs2_addr 	= 	rs2_addr_; 		\
		rd_addr		=	rd_addr_; 		\
		rs1_data	=	rs1_data_;		\
		rs2_data 	= 	rs2_data_;		\
		alu_op		=	alu_op_;		\
		alu_src		=	alu_src_;		\
		mem_read	=	mem_read_;		\
		mem_write	=	mem_write_;		\
		reg_write	= 	reg_write_;		\
		mem_to_reg	=	mem_to_reg_;	
	*/
	`define set_regimm(rs1_rd_en_, rs2_rd_en_, rs1_addr_, rs2_addr_, rd_addr_, imm_) 	\
		rs1_rd_en	=	rs1_rd_en_;		\
		rs2_rd_en	=	rs2_rd_en_;		\
		rs1_addr 	= 	rs1_addr_; 		\
		rs2_addr 	= 	rs2_addr_; 		\
		rd_addr		=	rd_addr_;		\
		imm			=	imm_;
	`define set_control(/* EX */ alu_op_, alu_src_, /* MEM */ mem_read_, mem_write_, mask_, unsigned_load_, /* WB */ reg_write_, mem_to_reg_)	\
		alu_op		=	alu_op_;		\
		alu_src		=	alu_src_;		\
		mem_read	=	mem_read_;		\
		mem_write	=	mem_write_;		\
		mask		=	mask_;			\
		unsigned_load = unsigned_load_;	\
		reg_write	= 	reg_write_;		\
		mem_to_reg	=	mem_to_reg_;	
	`define set_branch(branch_taken_, branch_addr_) \
		branch_taken 	= 	branch_taken_;	\
		branch_addr 	=	branch_addr_;

	/* pipeline control bits generate */
	always_comb begin
		if(rst) begin
			`set_regimm(0, 0, `REG_ADDR_ZERO, `REG_ADDR_ZERO, `REG_ADDR_ZERO, `REG_DATA_ZERO)
			`set_control(`ALU_NOP, `ALU_SRC_RS2, 0, 0, `MASK_W, 0, 0, 0)
			`set_branch(0, `MEM_ADDR_ZERO)
		end
		else begin
			`set_regimm(0, 0, `REG_ADDR_ZERO, `REG_ADDR_ZERO, `REG_ADDR_ZERO, `REG_DATA_ZERO)
			`set_control(`ALU_NOP, 0, 0, 0, `MASK_W, 0, 0, 0)
			`set_branch(0, `MEM_ADDR_ZERO)
			case(opcode)
				`OP_ALU: begin
					`set_regimm(1, 1, rs1, rs2, rd, `REG_DATA_ZERO)
					case(funct3)
						`FUNCT3_ADD: begin		// FUNCT3_SUB is the same
							case(funct7)
								`FUNCT7_ADD: begin `set_control(`ALU_ADD, `ALU_SRC_RS2, 0, 0, `MASK_W, 0, 1, 0) end
								`FUNCT7_SUB: begin `set_control(`ALU_SUB, `ALU_SRC_RS2, 0, 0, `MASK_W, 0, 1, 0) end
								default: begin end
							endcase
						end
						`FUNCT3_SLL: begin
							case(funct7)
								`FUNCT7_SLL: begin `set_control(`ALU_SLL, `ALU_SRC_RS2, 0, 0, `MASK_W, 0, 1, 0) end
								default: begin end
							endcase
						end
						`FUNCT3_SLT: begin
							case(funct7)
								`FUNCT7_SLT: begin `set_control(`ALU_SLT, `ALU_SRC_RS2, 0, 0, `MASK_W, 0, 1, 0) end
								default: begin end
							endcase
						end
						`FUNCT3_SLTU: begin
							case(funct7)
								`FUNCT7_SLTU: begin `set_control(`ALU_SLTU, `ALU_SRC_RS2, 0, 0, `MASK_W, 0, 1, 0) end
								default: begin end
							endcase
						end
						`FUNCT3_XOR: begin
							case(funct7)
								`FUNCT7_XOR: begin `set_control(`ALU_XOR, `ALU_SRC_RS2, 0, 0, `MASK_W, 0, 1, 0) end
								default: begin end
							endcase
						end
						`FUNCT3_SRL: begin		// FUNCT3_SRA is the same
							case(funct7)
								`FUCNT7_SRL: begin `set_control(`ALU_SRL, `ALU_SRC_RS2, 0, 0, `MASK_W, 0, 1, 0) end
								`FUNCT7_SRA: begin `set_control(`ALU_SRA, `ALU_SRC_RS2, 0, 0, `MASK_W, 0, 1, 0) end
								default: begin end
							endcase
						end
						`FUNCT3_OR: begin
							case(funct7)
								`FUNCT7_OR: begin `set_control(`ALU_OR, `ALU_SRC_RS2, 0, 0, `MASK_W, 0, 1, 0) end
								default: begin end
							endcase
						end
						`FUNCT3_AND: begin
							case(funct7)
								`FUNCT7_AND: begin `set_control(`ALU_AND, `ALU_SRC_RS2, 0, 0, `MASK_W, 0, 1, 0) end
								default: begin end
							endcase
						end
						default: begin end
					endcase
				end
				`OP_ALUI: begin
					`set_regimm(1, 0, rs1, rs2, rd, {{20{I_imm[11]}}, I_imm})
					case(funct3)		
						`FUNCT3_ADDI: 	begin `set_control(`ALU_ADD, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 1, 0) end
						`FUNCT3_SLTI: 	begin `set_control(`ALU_SLT, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 1, 0) end
						`FUNCT3_SLTIU: 	begin `set_control(`ALU_SLTU, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 1, 0) end
						`FUNCT3_XORI: 	begin `set_control(`ALU_XOR, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 1, 0) end
						`FUNCT3_ORI: 	begin `set_control(`ALU_OR, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 1, 0) end
						`FUNCT3_ANDI:	begin `set_control(`ALU_AND, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 1, 0) end
						// SLLI/SRLI/SRAI use rs2 as shamt
						`FUNCT3_SLLI: begin	
							case(funct7)
							`FUNCT7_SLLI: begin
								`set_regimm(1, 0, rs1, `REG_ADDR_ZERO, rd, {27'b0, rs2})
								`set_control(`ALU_SLL, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 1, 0)
								end
							default: begin end
							endcase	
						end
						`FUNCT3_SRLI: begin		// FUNCT3_SRAI is the same
							case(funct7)
								`FUNCT7_SRLI: begin
								`set_regimm(1, 0, rs1, `REG_ADDR_ZERO, rd, {27'b0, rs2})
								`set_control(`ALU_SRL, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 1, 0)
								end
								`FUNCT7_SRAI: begin
								`set_regimm(1, 0, rs1, `REG_ADDR_ZERO, rd, {27'b0, rs2})
								`set_control(`ALU_SRA, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 1, 0)
								end
								default: begin end
							endcase
						end
						default: begin end
					endcase
				end
				`OP_LUI: begin
					`set_regimm(0, 0, `REG_ADDR_ZERO, `REG_ADDR_ZERO, rd, {U_imm, 12'b0}) 	// Load upper 20bits
					`set_control(`ALU_NOP, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 1, 0)
				end
				`OP_AUIPC: begin
					`set_regimm(0, 0, `REG_ADDR_ZERO, `REG_ADDR_ZERO, rd, pc + {U_imm, 12'b0} /* adhoc */)
					`set_control(`ALU_ADD, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 1, 0)
				end
				/* branch logic begin */
				`OP_BRA: begin
					`set_regimm(1, 1, rs1, rs2, `REG_ADDR_ZERO, `REG_DATA_ZERO)
					case(funct3)
						`FUNCT3_BEQ: begin
							`set_control(`ALU_NOP, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 0, 0)
							`set_branch(rs1_eq_rs2, pc_bra)
						end
						`FUNCT3_BNE: begin
							`set_control(`ALU_NOP, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 0, 0)
							`set_branch(rs1_ne_rs2, pc_bra)
						end
						`FUNCT3_BLT: begin
							`set_control(`ALU_NOP, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 0, 0)
							`set_branch(rs1_lt_rs2, pc_bra)
						end
						`FUNCT3_BGE: begin
							`set_control(`ALU_NOP, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 0, 0)
							`set_branch(rs1_ge_rs2, pc_bra)
						end
						`FUNCT3_BLTU: begin
							`set_control(`ALU_NOP, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 0, 0)
							`set_branch(rs1_ltu_rs2, pc_bra)
						end
						`FUNCT3_BGEU: begin
							`set_control(`ALU_NOP, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 0, 0)
							`set_branch(rs1_geu_rs2, pc_bra)
						end
						default: begin end
					endcase
				end
				// Link needs write rd with next PC
				// yet imm is bypassed to MEM and not passed to WB, let it pass ALU
				`OP_JAL: begin
					`set_regimm(0, 0, `REG_ADDR_ZERO, `REG_ADDR_ZERO, rd, pc_next)
					`set_control(`ALU_ADD, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 1, 0)
					`set_branch(1, pc_jal)
				end
				`OP_JALR: begin
					case(funct3)
						`FUNCT3_JALR: begin
							`set_regimm(0, 0, `REG_ADDR_ZERO, `REG_ADDR_ZERO, rd, pc_next)
							`set_control(`ALU_ADD, `ALU_SRC_IMM, 0, 0, `MASK_W, 0, 1, 0)
							`set_branch(1, pc_jalr)
						end
						default: begin end
					endcase
				end
				/* branch logic end */
				`OP_LOAD: begin
					`set_regimm(1, 0, rs1, `REG_ADDR_ZERO, rd, {{20{I_imm[11]}}, I_imm})
					case(funct3)
						`FUNCT3_LB: begin `set_control(`ALU_ADD, `ALU_SRC_IMM, 1, 0, `MASK_B, 0, 1, 1) end
						`FUNCT3_LH: begin `set_control(`ALU_ADD, `ALU_SRC_IMM, 1, 0, `MASK_H, 0, 1, 1) end
						`FUNCT3_LW: begin `set_control(`ALU_ADD, `ALU_SRC_IMM, 1, 0, `MASK_W, 0, 1, 1) end
						`FUNCT3_LBU: begin `set_control(`ALU_ADD, `ALU_SRC_IMM, 1, 0, `MASK_B, 1, 1, 1) end
						`FUNCT3_LHU: begin `set_control(`ALU_ADD, `ALU_SRC_IMM, 1, 0, `MASK_H, 1, 1, 1) end
						default: begin end
					endcase
				end
				`OP_STORE: begin
					`set_regimm(1, 1, rs1, rs2, `REG_ADDR_ZERO, {{20{I_imm[11]}}, I_imm})
					case(funct3)
						`FUNCT3_SB: begin `set_control(`ALU_ADD, `ALU_SRC_IMM, 0, 1, `MASK_B, 0, 0, 0) end
						`FUNCT3_SH: begin `set_control(`ALU_ADD, `ALU_SRC_IMM, 0, 1, `MASK_H, 0, 0, 0) end
						`FUNCT3_SW: begin `set_control(`ALU_ADD, `ALU_SRC_IMM, 0, 1, `MASK_W, 0, 0, 0) end
						default: begin end
					endcase
				end
				default: begin end
			endcase
		end
	end


endmodule
