
`include "defines.sv"
module mem #(parameter SUPPORT_MASK = 1)(
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
            //dmem_wr_data =   `REG_DATA_ZERO;
            dmem_wr_en   =   0;
            dmem_rd_en   =   0;
            dmem_mask    =   `MASK_W;
        end
        else begin
            dmem_addr    =   alu_res;
            //dmem_wr_data =   bypass_op2;
            dmem_wr_en   =   mem_write;
            dmem_rd_en   =   mem_read;
            dmem_mask    =   mask;
        end
    end
    
    generate
        // support mask settings
        if(SUPPORT_MASK) begin
            // considering dram_driver in the template, the returned dram_rd_data is already masked
            always_comb begin
                dmem_wr_data = bypass_op2;   // complete by driver
            end
            // considering dram_driver in the template, the returned dram_rd_data is already masked
            // only need sign extension
            always_comb begin
                if(~mem_read) begin
                    mem_data = `REG_DATA_ZERO;
                end
                else begin
                    case(mask)
                        `MASK_B: begin // lb/lbu
                            mem_data = {{24{unsigned_load ? 1'b0 : dmem_rd_data[7]}}, dmem_rd_data[7:0]}; 
                        end
                        `MASK_H: begin // lh/lhu
                            mem_data = {{16{unsigned_load ? 1'b0 : dmem_rd_data[15]}}, dmem_rd_data[15:0]}; 
                        end
                        `MASK_W: begin // lw
                            mem_data = dmem_rd_data;
                        end
                        default: begin end
                    endcase
                end
            end   
        end 
        // no support for mask settings
        else begin
            // masked data output for STORE
            // since IP cores don't have mask input
            // read-write operation to store in Byte unit in a 32bit memory block
            always_comb begin
                case(mask)
                    `MASK_W: begin
                        dmem_wr_data = bypass_op2;
                    end
                    `MASK_H: begin
                        case(dmem_addr[1])
                            1'b1:
                                dmem_wr_data = {{bypass_op2[15:8]}, {bypass_op2[7:0]}, {dmem_rd_data[15:8]}, {dmem_rd_data[7:0]}};
                            1'b0:
                                dmem_wr_data = {{dmem_rd_data[31:24]}, {dmem_rd_data[23:16]}, {bypass_op2[15:8]}, {bypass_op2[7:0]}};
                            default: begin end
                        endcase
                    end
                    `MASK_B: begin
                        case(dmem_addr[1:0])
                            2'b00:
                                dmem_wr_data = {{dmem_rd_data[31:24]}, {dmem_rd_data[23:16]}, {dmem_rd_data[15:8]}, {bypass_op2[7:0]}};
                            2'b01:
                                dmem_wr_data = {{dmem_rd_data[31:24]}, {dmem_rd_data[23:16]}, {bypass_op2[7:0]}, {dmem_rd_data[7:0]}};
                            2'b10:
                                dmem_wr_data = {{dmem_rd_data[31:24]}, {bypass_op2[7:0]}, {dmem_rd_data[15:8]}, {dmem_rd_data[7:0]}};
                            2'b11:
                                dmem_wr_data = {{bypass_op2[7:0]}, {dmem_rd_data[23:16]}, {dmem_rd_data[15:8]}, {dmem_rd_data[7:0]}};
                            default begin end
                        endcase
                    end
                    default begin end
                endcase
            end
            // memory read out considering load mask
            logic[31:0] masked_dmem_rd_data;
            always_comb begin
                if(~mem_read)
                    mem_data = `REG_DATA_ZERO;
                else begin
                    masked_dmem_rd_data = 32'b0;
                    case(mask)
                        `MASK_W: begin
                            mem_data = dmem_rd_data;
                        end
                        `MASK_H: begin
                            // mem_data = {{16{unsigned_load ? 1'b0 : dmem_rd_data[15]}}, dmem_rd_data[15:0]}; 
                            case(dmem_addr[1])
                                1'b1:
                                    masked_dmem_rd_data[15:0] = dmem_rd_data[31:16];
                                1'b0:
                                    masked_dmem_rd_data[15:0] = dmem_rd_data[15:0];
                                default: begin end
                            endcase
                            mem_data = {{16{unsigned_load ? 1'b0 : masked_dmem_rd_data[15]}}, masked_dmem_rd_data[15:0]}; 
                        end
                        `MASK_B: begin
                            //mem_data = {{24{unsigned_load ? 1'b0 : dmem_rd_data[7]}}, dmem_rd_data[7:0]}; 
                            case(dmem_addr[1:0])
                                2'b00:
                                    masked_dmem_rd_data[7:0] = dmem_rd_data[7:0];
                                2'b01:
                                    masked_dmem_rd_data[7:0] = dmem_rd_data[15:8];
                                2'b10:
                                    masked_dmem_rd_data[7:0] = dmem_rd_data[23:16];
                                2'b11:
                                    masked_dmem_rd_data[7:0] = dmem_rd_data[31:24];
                                default begin end
                            endcase
                            mem_data = {{24{unsigned_load ? 1'b0 : masked_dmem_rd_data[7]}}, masked_dmem_rd_data[7:0]}; 
                        end
                        default begin end
                    endcase
                end
            end
        end
    endgenerate
    
    assign alu_data   =   alu_res;        // alu res to write regfile 
    
    // forward alu result to prior stages
    assign forward_data     =   alu_res;

endmodule