`ifndef DEFINS_SV
`define DEFINS_SV

//%
// Useful Macro in the CPU design for reuse
// Please modify as you need

// Definitions For Stall Types
`define StallBranch     5'b00001
`define StallLoad       5'b00011

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
`define FUNC3_AND       3'b111
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


`endif
