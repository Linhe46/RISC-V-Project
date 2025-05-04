//%
// Instruction Memory at Fetch stage
// Function:
// - Given the address and read enable signal, send out inst
// Connection:
// - Input: PC
// - Output: IF/ID reg

/* verilator lint_off WIDTHTRUNC */
`include "defines.sv"
module inst_memory(
    input   logic       rd_en,
    input   logic[31:0] addr,   // address from PC
    output  logic[31:0] inst
);
    logic[`INST_MEM_DATA_WIDTH-1:0] inst_memory[0:`INST_MEM_SIZE-1];    // 32bit cell memory

    // load instructions from files 
    initial begin
        $readmemh("inst_memory.txt", inst_memory);
    end

    localparam ADDR_MSB = `INST_MEM_SIZE_WIDTH + 2;
    assign inst = rd_en ? inst_memory[addr[ADDR_MSB-1:2]] : 32'b0;     // align by 4 bytes

endmodule