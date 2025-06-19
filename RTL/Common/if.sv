
`include "defines.sv"
module if_(
    input   logic                       rst,
    input   logic[`STALL_WIDTH-1:0]     stall,
    input   logic[`MEM_ADDR_WIDTH-1:0]  pc_in,
    input   logic[`REG_DATA_WIDTH-1:0]  inst_imem,
    output  logic                       pc_wr_en,
    output  logic                       imem_rd_en,
    output  logic[`MEM_ADDR_WIDTH-1:0]  pc_out,
    output  logic[`REG_DATA_WIDTH-1:0]  inst
);

    always_comb begin
        if(rst) begin
            pc_out  =   `PC_ZERO;
            inst    =   0;
        end
        else begin
            pc_out  =   pc_in;
            inst    =   inst_imem;
        end
    end

    always_comb begin
        if(rst || stall == `STALL_LOAD || stall == `STALL_BRANCH)
            pc_wr_en = 0;
        else
            pc_wr_en = 1;
    end

    assign imem_rd_en = 1;  // always read inst

endmodule