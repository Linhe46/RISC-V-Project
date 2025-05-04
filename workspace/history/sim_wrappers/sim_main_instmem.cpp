#include <memory>
#include <verilated.h>
#include "VInstMem.h"
#include "verilated_vcd_c.h"
std::string toBinaryString(uint32_t value) {
    return std::bitset<32>(value).to_string();
}

int main(int argc, char **argv){
    const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
    contextp->debug(0);
    contextp->commandArgs(argc, argv);
    const std::unique_ptr<VInstMem> top{new VInstMem{contextp.get(), "TOP"}};
    top->rd_en=1;
    top->addr=0;
    while(!contextp->gotFinish()){
        for(int i = 0; i < 10; i++){
            contextp->timeInc(1);
            top->eval();
            std::string inst_bin = toBinaryString(top->inst);
            VL_PRINTF("[%02" PRId64 "] addr=%02d inst=%s \n", contextp->time(), top->addr, inst_bin.c_str());
            top->addr += 4;
        }
    break;
    }
}