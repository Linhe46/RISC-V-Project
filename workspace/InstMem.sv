//%
// Instruction Memory at Fetch stage
// Function:
// - Given the address and read enable signal, send out inst
// Connection:
// - Input: PC
// - Output: IF/ID reg

/* verilator lint_off WIDTHTRUNC */
`include "defines.sv"
module InstMem(
    input   logic       rd_en,
    input   logic[31:0] addr,   // address from PC
    output  logic[31:0] inst
);
    logic[31:0] inst_memory[0:31];    // 256x32bit memory

    // load instructions from files 
    initial begin
        $readmemb("inst_memory.txt", inst_memory);
    end

    assign inst = rd_en ? inst_memory[addr[31:2]] : 32'b0;     // align by 4 bytes

endmodule

/*
// verilog style testbench
module InstMem_tb;
    reg rd_en = 1;
    reg[31:0] addr;
    wire[31:0] inst;
    integer i;
    InstMem inst_mem_u(
        .rd_en(rd_en),
        .addr(addr),
        .inst(inst)
    );

    initial begin
        addr = 0;
        #5;
        for(i = 0; i < 10; i++) begin
            #1;
            $display("At addr %d, the inst is %b", addr, inst);        
            addr = addr + 4;
        end
    end

endmodule
*/
