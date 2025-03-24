
`include "defines.sv"
module forward_unit(
    input   logic                           rst,
    /* forwarding to EX stage */
    input   logic                           rs1_rd_en_ex,
    input   logic                           rs2_rd_en_ex,
    input   logic[`REG_ADDR_WIDTH-1:0]      rs1_addr_ex,
    input   logic[`REG_ADDR_WIDTH-1:0]      rs2_addr_ex,
    input   logic[`REG_ADDR_WIDTH-1:0]      rd_addr_ex,
    
    /* forwarding from EX/MEM regfile */
    input   logic[`REG_ADDR_WIDTH-1:0]      rd_addr_mem,
    input   logic                           reg_write_mem,
    /* forwarding from MEM/WB regfile */
    input   logic[`REG_ADDR_WIDTH-1:0]      rd_addr_wb,
    input   logic                           reg_write_wb,

    output  logic[`FORWARD_WIDTH-1:0]       forward_op1,
    output  logic[`FORWARD_WIDTH-1:0]       forward_op2
);
    /* R-Type hazzard: EX/MEM */
    always_comb begin
        if(rst)
            forward_op1 = `FORWARD_NOP;
        else begin
            if(rs1_rd_en_ex) begin
                if(reg_write_mem & rd_addr_mem != `REG_ADDR_ZERO 
                    & rd_addr_mem == rs1_addr_ex)
                forward_op1 = `FORWARD_MEM;
                else if(reg_write_wb & rd_addr_wb != `REG_ADDR_ZERO
                    & rd_addr_wb == rs1_addr_ex)
                    forward_op1 = `FORWARD_WB;
                else
                    forward_op1 = `FORWARD_NOP;
            end
            else
                forward_op1 = `FORWARD_NOP;
        end
    end

    /* R-Type hazzard: MEM/WB */
    always_comb begin
        if(rst)
            forward_op2 = `FORWARD_NOP;
        else begin
            if(rs2_rd_en_ex) begin
                if(reg_write_mem & rd_addr_mem != `REG_ADDR_ZERO 
                    & rd_addr_mem == rs2_addr_ex)
                forward_op2 = `FORWARD_MEM;
                else if(reg_write_wb & rd_addr_wb != `REG_ADDR_ZERO
                    & rd_addr_wb == rs2_addr_ex)
                    forward_op2 = `FORWARD_WB;
                else
                    forward_op2 = `FORWARD_NOP;
            end
            else
                forward_op2 = `FORWARD_NOP;
        end
    end

endmodule