#include <memory>
#include <verilated.h>
#include "Vcore_no_if.h"   // modified as "V<file_name>.h"
#include "verilated_vcd_c.h"
#include <bitset>
#include <vector>
#include <iostream>

// pack the instruction into a 32bit decimal for cpp assignment
u_int32_t pack(const std::string& inst){
    std::string filter_separate = "";
    for(auto x: inst){
        if(x == '0' || x == '1')
            filter_separate.push_back(x);
    }
    if (filter_separate.length() > 32) {
        filter_separate = filter_separate.substr(filter_separate.length() - 32);
    }
    std::bitset<32> binarySet(std::move(filter_separate));
    return binarySet.to_ulong();
}
std::vector<std::string> insts{
// comment format: <ASM_NAME> <rd> <rs1> <rs2>(<imm>) unless specially declared
//    funct7  rs2   rs1 funct3 rd   opcode
    "0000000_00011_00000_000_00001_0010011", // ADDI    x1, x0, 1   // x1 = 3
    "0000000_00001_00000_000_00010_0010011", // ADDI    x2, x0, 1   // x2 = 1
    "0000000_00001_00001_000_00001_0110011", // ADD     x1, x1, x1  // x1 = 6
    "0100000_00010_00001_000_00101_0110011", // SUB     x5, x1, x2  // x5 = 5
    "0000000_10001_00011_001_00100_0010011", // SLLI x4, x3, 17
    "0100000_10011_00001_101_00100_0010011", // SRAI x4, x1, 19
    "1111111_00010_00100_000_11111_1100011", // BEQ x4 x2, offset = -1 << 1   
    "0000000_01000_00000_000_00011_1101111", // JAL x3 offset = 8
    "0000000_11000_00000_000_00011_1100111", // JALR x3 offset = 24
    "0000001_00001_00100_010_10000_0000011", // LW x16 = MEM[x4 + 33] & MASK_W
    "0000000_00011_00011_000_00011_0100011", // SB MEM[x3 + 3] = x3 & MASK_B
    "0000000_00000_00000_111_11111_0110111", // LUI x31 = 7 << 12
    "0000000_00000_01000_101_00001_0000011"  // LHU x1 = MEM[x8 + 0]
};

int main(int argc, char **argv)
{
    if (false && argc && argv){}
    const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
    contextp->debug(0);     // turn off the debug output
    //contextp->randReset(2);     // randomlize all signals
    contextp->traceEverOn(true);    // turn on wave tracing
    //contextp->commandArgs(argc, argv);    // pass command args
    const std::unique_ptr<Vcore_no_if> top{new Vcore_no_if{contextp.get(), "TOP"}}; // modify the type as V<file_name>
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 0);
    tfp->open("wave_dir/core_no_if.vcd"); // set the output wave file name
    /* set the module inputs' initial value */
    // top->clk = ...
    // top->rst = ...
    // top->... = ...
    top->clk = 0;
    top->rst = 0;
    top->pc = 0;
    top->inst = 0;

    /* start simulation until reaching finish time */
    /* you can also write a for-loop to run certain times */
    int num_insts = insts.size();
    int inst_ptr = 0;
    for(int i = 0; i < 50; i++){
        contextp->timeInc(1);   // increase the simulator's time stamp
        top->clk = !top->clk;   // toggle clock
        if (!top->clk)
        {
            if(contextp->time() < 5)
                top->rst = 1;
            else if(contextp->time() > 8){
                top->rst = 0;
                //top->pc  = 0;
                top->pc = 4 * (inst_ptr % num_insts); // simulate PC with ptr
                top->inst = pack(insts[inst_ptr]);
                //std::cout << pack(insts[inst_ptr]) << std::endl;
                inst_ptr = (inst_ptr + 1) % num_insts;
            }
            else {}
            //...
        }
        top->eval();    // eval the value of the module
        tfp->dump(contextp->time()); // dump wave
    }
    // print needed value for debugging
    //VL_PRINTF("[%" PRId64 "] clk=%x rst_n=%x a=%x rise=%x down=%x \n", contextp->time(), top->clk, top->rst_n, top->a, top->rise, top->down);

    top->final();   // end the simulation
    tfp->close();   // end the wave file writing
    return 0;
}