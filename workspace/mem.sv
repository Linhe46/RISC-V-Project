
`include "defines.sv"
module mem(
    input   logic                       rst,
    // get from pipeline reg
    // memory address & data
    input   logic[`REG_DATA_WIDTH-1:0]  alu_res,
    input   logic[`REG_DATA_WIDTH-1:0]  bypass_op2,
    // control signals
    input   logic                       mem_read,
    input   logic                       mem_write,
    input   logic[`MASK_WIDTH-1:0]      mask,
    input   logic                       unsigned_load,
    // read data from data memory
    input   logic[`REG_DATA_WIDTH-1:0]  dmem_rd_data,

    // memory input signals
    output  logic[`MEM_ADDR_WIDTH-1:0]  dmem_addr,
    output  logic[`REG_DATA_WIDTH-1:0]  dmem_wr_data,
    output  logic                       dmem_wr_en,
    output  logic                       dmem_rd_en,
    output  logic[`MASK_WIDTH-1:0]      dmem_mask,
    // write back stage data
    output  logic[`REG_DATA_WIDTH-1:0]  mem_data,
    output  logic[`REG_DATA_WIDTH-1:0]  alu_data,
    // forward data to ex stage
    output  logic[`REG_DATA_WIDTH-1:0]  forward_data
);
    // data memory control logic
    always_comb begin
        if(rst) begin
            dmem_addr    =   `MEM_ADDR_ZERO;
            dmem_wr_data =   `REG_DATA_ZERO;
            dmem_wr_en   =   0;
            dmem_rd_en   =   0;
            dmem_mask    =   `MASK_W;
        end
        else begin
            dmem_addr    =   alu_res;
            dmem_wr_data =   bypass_op2;
            dmem_wr_en   =   mem_write;
            dmem_rd_en   =   mem_read;
            dmem_mask    =   mask;
        end
    end

    /* ex stage logic */
    // formulate memory read output
    always_comb begin
        if(~mem_read)
            mem_data = `REG_DATA_ZERO;
        else begin
            case(mask)
                `MASK_W: begin
                    mem_data = dmem_rd_data;
                end
                `MASK_H: begin
                    mem_data = {{16{unsigned_load ? 1'b0 : dmem_rd_data[15]}}, dmem_rd_data[15:0]}; 
                end
                `MASK_B: begin
                    mem_data = {{24{unsigned_load ? 1'b0 : dmem_rd_data[7]}}, dmem_rd_data[7:0]}; 
                end
                default begin end
            endcase
        end
    end
    assign alu_data   =   alu_res;        // alu res to write regfile 
    
    // forward alu result to prior stages
    assign forward_data     =   alu_res;

endmodule