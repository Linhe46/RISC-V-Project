
`include "defines.sv"
module data_memory(
    input       logic                       clk,
    input       logic                       rd_en,
    input       logic                       wr_en,
    input       logic[`MASK_WIDTH-1:0]      mask,
    input       logic[`MEM_ADDR_WIDTH-1:0]  addr,
    input       logic[`REG_DATA_WIDTH-1:0]  wr_data,
    output      logic[`REG_DATA_WIDTH-1:0]  rd_data
);
    // we implment the memory with 4 bytes aligned
    logic[`DATA_MEM_DATA_WIDTH-1:0] mem [0:`DATA_MEM_SIZE-1]; 
    initial begin
        $readmemh("data_memory.txt", mem);
    end

    // write logic
    localparam ADDR_MSB = `DATA_MEM_SIZE_WIDTH + 2; // 2 for negelecting lower 2bits
    always_ff @(posedge clk) begin
        if(wr_en) begin
            case(mask)   // TODO: Uniform mem size, here we slice the addr to debug
                `MASK_W: begin
                    mem[addr[ADDR_MSB-1:2]][31:0] <= wr_data[31:0];
                end
                `MASK_H: begin
                    case(addr[1])
                        1'b1: 
                            mem[addr[ADDR_MSB-1:2]][31:16] <= wr_data[15:0];
                        1'b0:
                            mem[addr[ADDR_MSB-1:2]][15:0] <= wr_data[15:0];
                        default begin end
                    endcase
                end 
                `MASK_B: begin
                    case(addr[1:0])
                        2'b00: begin
                            mem[addr[ADDR_MSB-1:2]][7:0]  <= wr_data[7:0];
                        end
                        2'b01: begin
                            mem[addr[ADDR_MSB-1:2]][15:8]  <= wr_data[7:0];
                        end
                        2'b10: begin
                            mem[addr[ADDR_MSB-1:2]][23:16]  <= wr_data[7:0];
                        end
                        2'b11: begin
                            mem[addr[ADDR_MSB-1:2]][31:24]  <= wr_data[7:0];
                        end
                        default begin end
                    endcase
                end
                default begin end
            endcase
        end
    end
    // read logic
    always_comb begin
        rd_data = `REG_DATA_ZERO;
        if(~rd_en) begin
            rd_data = 0;
        end
        else begin
            case(mask)
                `MASK_W: begin
                    rd_data = mem[addr[ADDR_MSB-1:2]][31:0];
                end
                `MASK_H: begin
                    case(addr[1])
                        1'b0: begin
                            rd_data = {16'b0, mem[addr[ADDR_MSB-1:2]][15:0]};
                        end
                        1'b1: begin
                            rd_data = {16'b0, mem[addr[ADDR_MSB-1:2]][31:16]};
                        end
                        default begin end
                    endcase
                end
                `MASK_B: begin
                    case(addr[1:0])
                        2'b00: begin
                            rd_data = {24'b0, mem[addr[ADDR_MSB-1:2]][7:0]};
                        end
                        2'b01: begin
                            rd_data = {24'b0, mem[addr[ADDR_MSB-1:2]][15:8]};
                        end
                        2'b10: begin
                            rd_data = {24'b0, mem[addr[ADDR_MSB-1:2]][23:16]};
                        end
                        2'b11: begin
                            rd_data = {24'b0, mem[addr[ADDR_MSB-1:2]][31:24]};
                        end
                        default begin end
                    endcase
                end
                default begin end
            endcase
        end
    end
endmodule
