
`include "defines.sv"
module ex(
    input   logic                       rst,
    // get from pipeline regfile
    input   logic[`REG_DATA_WIDTH-1:0]  rs1_data,
    input   logic[`REG_DATA_WIDTH-1:0]  rs2_data,
    input   logic[`REG_DATA_WIDTH-1:0]  imm,
    
    input   logic[`FORWARD_WIDTH-1:0]   forward_op1,
    input   logic[`FORWARD_WIDTH-1:0]   forward_op2,
    input   logic[`REG_DATA_WIDTH-1:0]  forward_data_mem,
    input   logic[`REG_DATA_WIDTH-1:0]  forward_data_wb,

    // alu control signals and results
    input   logic[`ALU_OP_WIDTH-1:0]    alu_op,
    input   logic                       alu_src,
    output  logic[`REG_DATA_WIDTH-1:0]  alu_res,
    output  logic[`REG_DATA_WIDTH-1:0]  bypass_op2
);
    logic[`REG_DATA_WIDTH-1:0]  oprand1, oprand2;
    logic[`REG_DATA_WIDTH-1:0]  alu_op1, alu_op2;
    // DONE: forwarding mux for oprand1/2
    assign oprand1 = (forward_op1 == `FORWARD_MEM)    ? forward_data_mem  :
                     (forward_op1 == `FORWARD_WB)     ? forward_data_wb   :   rs1_data;
    assign oprand2 = (forward_op2 == `FORWARD_MEM)    ? forward_data_mem  :
                     (forward_op2 == `FORWARD_WB)     ? forward_data_wb   :   rs2_data;

    assign alu_op1 = oprand1;
    assign alu_op2 = (alu_src == `ALU_SRC_RS2) ? oprand2 : imm;

    // used in compare
    function signed_lt;
        input [31:0] rs1, rs2;
        logic res;
        if(rs1[31] != rs2[31]) res = rs1[31];
        else res = rs1 < rs2;
    endfunction

    always_comb begin
        if(rst) begin
            alu_res     = `REG_DATA_ZERO;
            bypass_op2  = `REG_DATA_ZERO;
        end
        else begin
            bypass_op2 = oprand2;
            case(alu_op)
                `ALU_NOP: begin alu_res = 0; end
                // Arithmetic
                `ALU_ADD: begin alu_res = alu_op1 + alu_op2; end
                `ALU_SUB: begin alu_res = alu_op1 - alu_op2; end // 2'comp minus?
                // Shifts
                `ALU_SLL: begin alu_res = alu_op1 << alu_op2[4:0]; end // I-type assert op2[5] == 0?
                `ALU_SRL: begin alu_res = alu_op1 >> alu_op2[4:0]; end
                `ALU_SRA: begin alu_res = (alu_op1 >>> alu_op2[4:0]) | 
                            (({`REG_DATA_WIDTH{alu_op1[`REG_DATA_WIDTH-1]}}) << (`REG_DATA_WIDTH - alu_op2[4:0]));
                        end     // use compensate mask to get sign bits
                // Logical
                `ALU_XOR: begin alu_res = alu_op1 ^ alu_op2; end
                `ALU_OR:  begin alu_res = alu_op1 | alu_op2; end
                `ALU_AND: begin alu_res = alu_op1 & alu_op2; end
                // Compare
                `ALU_SLT: begin alu_res = signed_lt(alu_op1, alu_op2) ? `REG_DATA_ONE : `REG_DATA_ZERO; end
                `ALU_SLTU: begin alu_res = alu_op1 < alu_op2 ? `REG_DATA_ONE : `REG_DATA_ZERO; end 
                default: begin alu_res  = 0; end
            endcase
        end
    end

endmodule