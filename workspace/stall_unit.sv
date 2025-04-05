
`include "defines.sv"
module stall_unit(
    input   logic                       rst,
    input   logic                       is_branch,
    input   logic                       rs1_rd_en_id,
    input   logic                       rs2_rd_en_id,
    input   logic[`REG_ADDR_WIDTH-1:0]  rs1_addr_id,
    input   logic[`REG_ADDR_WIDTH-1:0]  rs2_addr_id,
    input   logic                       mem_read_ex,
    input   logic                       mem_read_mem,
    input   logic                       reg_write_ex,
    input   logic[`REG_ADDR_WIDTH-1:0]  rd_addr_ex,
    input   logic[`REG_ADDR_WIDTH-1:0]  rd_addr_mem,

    output  logic[`STALL_WIDTH-1:0]     stall
);
    logic load_use_hazzard;
    assign load_use_hazzard =  mem_read_ex & rd_addr_ex != `REG_ADDR_ZERO & 
        ((rs1_rd_en_id & rd_addr_ex == rs1_addr_id) || (rs2_rd_en_id & rd_addr_ex == rs2_addr_id));     // if read from data memory, reg_write is implicit

    logic bra_forward_wb_hazzard;
    logic bra_forward_mem_hazzard;
    // if occurs both, wait for mem data forwarding in fact
    assign bra_forward_wb_hazzard = is_branch & mem_read_mem & rd_addr_mem != `REG_ADDR_ZERO &             // reg_write is implicit
        ((rs1_rd_en_id & rd_addr_mem == rs1_addr_id) || (rs2_rd_en_id & rd_addr_mem == rs2_addr_id));   // for load-branch hazzard stall
    assign bra_forward_mem_hazzard = is_branch & reg_write_ex & rd_addr_ex != `REG_ADDR_ZERO &             // need to judge if reg_write
        ((rs1_rd_en_id & rd_addr_ex == rs1_addr_id)  || (rs2_rd_en_id & rd_addr_ex == rs2_addr_id));    // for r_type-branch hazzard stall

    always_comb begin
        if(rst)
            stall = `STALL_NOP;
        else begin
            // stall if-id stages for load-use hazzard
            if(load_use_hazzard)
                stall = `STALL_LOAD;
            // stall if-id stages for branch data hazzard
            else if(bra_forward_mem_hazzard || bra_forward_wb_hazzard)
                stall = `STALL_BRANCH;
            else
                stall = `STALL_NOP;
        end
    end
endmodule