`ifndef DEFINS_SV
`define DEFINS_SV

//%
// Useful Macro in the CPU design for reuse
// Please modify as you need

// Definitions For Stall Types
`define STALL_WIDTH     5
`define STALL_NOP       5'd0
//`define BRANCH_FLUSH    5'd1  // stall IF stage, flush ID stage 
`define STALL_BRANCH    5'd2  // stall ID stage and IF stage
`define STALL_LOAD      5'd3    // stall ID stage and IF stage

/* Some frequently used signals */
`define REG_DATA_ZERO       32'b0
`define REG_DATA_ONE        32'd1   // used in COMPARE
`define REG_DATA_WIDTH      32      // R32I
`define REG_ADDR_ZERO       5'b0
`define REG_ADDR_WIDTH      5       // 32 registers
`define MEM_ADDR_ZERO       32'b0
`define MEM_ADDR_WIDTH      32      // R32I

/*========================= Instruction Decode Begin ========================== */
/* Opcode Types */
`define OP_ALU          7'b011_0011     // R-type Arithmetic/Shift/Logical/Compare
`define OP_ALUI         7'b001_0011     // I-type Arithmetic/Shift/Logical/Compare
`define OP_LUI          7'b011_0111     // U-type LUI
`define OP_AUIPC        7'b001_0111     // U-type AUIPC
`define OP_BRA          7'b110_0011     // B-type Conditional Branch
`define OP_JAL          7'b110_1111     // J-type Jump and Link
`define OP_JALR         7'b110_0111     // I-type Jump and Link Register
`define OP_LOAD         7'b000_0011     // I-type Load
`define OP_STORE        7'b010_0011     // S-type Store
// Miscellaneous instructions(CSR, Environment, Synch) are not supported yet 

/* Funct3 Types */
//------------- R-type Arithmetic/Shift/Logical/Compare ---------------
`define FUNCT3_ADD      3'b000
`define FUNCT3_SUB      3'b000
`define FUNCT3_SLL      3'b001          // shifte left logical
`define FUNCT3_SLT      3'b010          // set less than (signed)
`define FUNCT3_SLTU     3'b011          // set less than unsigned
`define FUNCT3_XOR      3'b100
`define FUNCT3_SRL      3'b101          // shift right logical
`define FUNCT3_SRA      3'b101          // shift right arithmetic
`define FUNCT3_OR       3'b110
`define FUNCT3_AND       3'b111
//------------- I-type Arithmetic/Shift/Logical/Compare ---------------
`define FUNCT3_ADDI     3'b000
`define FUNCT3_SLTI     3'b010
`define FUNCT3_SLTIU    3'b011
`define FUNCT3_XORI     3'b100
`define FUNCT3_ORI      3'b110
`define FUNCT3_ANDI     3'b111
`define FUNCT3_SLLI     3'b001
`define FUNCT3_SRLI     3'b101
`define FUNCT3_SRAI     3'b101
//------------- Load --------------
`define FUNCT3_LB       3'b000          // load byte (sign extended)
`define FUNCT3_LH       3'b001          // load half word (sign extended)
`define FUNCT3_LW       3'b010          // load word
`define FUNCT3_LBU      3'b100          // load byte, unsigned
`define FUNCT3_LHU      3'b101          // load half word, unsigned
//------------- Store -------------
`define FUNCT3_SB       3'b000          // store byte (sign extended)
`define FUNCT3_SH       3'b001          // store half word (sign extended)
`define FUNCT3_SW       3'b010          // store word
//------------- Branch ------------
`define FUNCT3_BEQ      3'b000          // branch if equal
`define FUNCT3_BNE      3'b001          // branch if not equal
`define FUNCT3_BLT      3'b100          // branch if less than
`define FUNCT3_BGE      3'b101          // branch if greater than or equal
`define FUNCT3_BLTU     3'b110          // branch if less than (unsigned)
`define FUNCT3_BGEU     3'b111          // branch if greater than or equal (unsigned)
// Jump and Link Register
`define FUNCT3_JALR     3'b000
// Miscellaneous instructions(CSR, Environment, Synch) are not supported yet 

/* Funct7 Types */
//------------- R-type Arithmetic/Shift/Logical/Compare ---------------
`define FUNCT7_ADD      7'b000_0000
`define FUNCT7_SUB      7'b010_0000
`define FUNCT7_SLL      7'b000_0000
`define FUNCT7_SLT      7'b000_0000
`define FUNCT7_SLTU     7'b000_0000
`define FUNCT7_XOR      7'b000_0000
`define FUCNT7_SRL      7'b000_0000
`define FUNCT7_SRA      7'b010_0000
`define FUNCT7_OR       7'b000_0000
`define FUNCT7_AND      7'b000_0000
//------------- I-type Arithmetic/Shift/Logical/Compare ---------------
//------------- only Shift instructions use the Funct7 bits -----------
`define FUNCT7_SLLI     7'b000_0000
`define FUNCT7_SRLI     7'b000_0000
`define FUNCT7_SRAI     7'b010_0000
// Miscellaneous instructions(CSR, Environment, Synch) are not supported yet 

/*========================= Instruction Decode End ========================== */

/*========================= ALU_OP signal begin ============================= */
// Used to select ALU operating mode(add, sub, shift, etc.)
`define ALU_OP_WIDTH    4
`define ALU_NOP         4'd0
`define ALU_ADD         4'd1
`define ALU_SUB         4'd2
`define ALU_SLL         4'd3
`define ALU_SLT         4'd4
`define ALU_SLTU        4'd5
`define ALU_XOR         4'd6
`define ALU_SRL         4'd7
`define ALU_SRA         4'd8
`define ALU_OR          4'd9
`define ALU_AND         4'd10
/*========================= ALU_OP signal end =============================== */

/*========================= ALU src select begin ============================ */
`define ALU_SRC_RS2     1'd0
`define ALU_SRC_IMM     1'd1
/*========================= ALU src select begin ============================ */

/*========================= Load/Store Mask begin ============================ */
`define MASK_WIDTH      2
`define MASK_W          2'd0        // mask of lower word(default in RISCV 32 set)
`define MASK_H          2'd1        // mask of lower half-word(16bit)
`define MASK_B          2'd2        // mask of lowest byte
/*========================= Load/Store Mask end   ========================== */

/*========================= Forwarding Select Signals begin ================ */
`define FORWARD_WIDTH   2
`define FORWARD_NOP     2'd0     // no forward
`define FORWARD_MEM     2'd1
`define FORWARD_WB      2'd2
/*========================= Forwarding Select Signals end ================ */

/*========================= Memory Condfig Params =========================*/
`define DATA_MEM_DATA_WIDTH     32          // cell width  
`define DATA_MEM_SIZE           4096        // cell size
`define DATA_MEM_SIZE_WIDTH     $clog2(`DATA_MEM_SIZE)    // cell size width

`define INST_MEM_SIZE           8
`define INST_MEM_SIZE_WIDTH     $clog2(`INST_MEM_SIZE)

`endif
