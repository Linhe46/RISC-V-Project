
`include "defines.sv"
module stall_unit(
    input   logic                       rst,
    input   logic                       rs1_rd_en_id,
    input   logic                       rs2_rd_en_id,
    input   logic[`REG_ADDR_WIDTH-1:0]  rs1_addr_id,
    input   logic[`REG_ADDR_WIDTH-1:0]  rs2_addr_id,
    input   logic                       mem_read_ex,
    input   logic[`REG_ADDR_WIDTH-1:0]  rd_addr_ex,

    output  logic[`STALL_WIDTH-1:0]     stall
);
    always_comb begin
        if(rst)
            stall = `STALL_NOP;
        else begin
            if(mem_read_ex & ((rs1_rd_en_id & rd_addr_ex == rs1_addr_id)
                || (rs2_rd_en_id & rd_addr_ex == rs2_addr_id)))
                stall = `STALL_LOAD;
            else
                stall = `STALL_NOP;
        end
    end
endmodule