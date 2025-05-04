
`include "defines.sv"
module wb(
    input       logic                       rst,
    // reg data & addr to write back
    input       logic[`REG_DATA_WIDTH-1:0]  mem_data,
    input       logic[`REG_DATA_WIDTH-1:0]  alu_data,
    input       logic[`REG_ADDR_WIDTH-1:0]  rd_addr,
    // control signals
    input       logic                       reg_write,
    input       logic                       mem_to_reg,
    // register file write signals
    output      logic                       reg_wr_en,
    output      logic[`REG_ADDR_WIDTH-1:0]  reg_wr_addr,
    output      logic[`REG_DATA_WIDTH-1:0]  reg_wr_data,
    // forwarding data to ex stage
    output      logic[`REG_DATA_WIDTH-1:0]  forward_data
);
    always_comb begin
        if(rst) begin
            reg_wr_en   =   0;
            reg_wr_addr =   `REG_ADDR_ZERO;
            reg_wr_data =   `REG_DATA_ZERO;
        end
        else begin
            reg_wr_en   =   reg_write;
            reg_wr_addr =   rd_addr;
            reg_wr_data =   mem_to_reg ? mem_data : alu_data;
        end
    end

    assign forward_data = reg_wr_data;
endmodule