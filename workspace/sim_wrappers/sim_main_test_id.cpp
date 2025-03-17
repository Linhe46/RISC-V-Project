#include <memory>
#include <verilated.h>
#include "Vtest_id.h"   // modified as "V<file_name>.h"
#include "verilated_vcd_c.h"
#include <bitset>

int main(int argc, char **argv)
{
    if (false && argc && argv){}
    const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
    contextp->debug(0);     // turn off the debug output
    //contextp->randReset(2);     // randomlize all signals
    contextp->traceEverOn(true);    // turn on wave tracing
    //contextp->commandArgs(argc, argv);    // pass command args
    const std::unique_ptr<Vtest_id> top{new Vtest_id{contextp.get(), "TOP"}}; // modify the type as V<file_name>
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 0);
    tfp->open("wave_dir/test_id.vcd"); // set the output wave file name
    /* set the module inputs' initial value */
    // top->clk = ...
    // top->rst = ...
    // top->... = ...
    top->clk = 0;
    top->rst = 0;
    top->stall = 0;
    top->pc = 0;
    top->inst = 0;

    /* start simulation until reaching finish time */
    /* you can also write a for-loop to run certain times */
    for(int i = 0; i < 50; i++){
        contextp->timeInc(1);   // increase the simulator's time stamp
        top->clk = !top->clk;   // toggle clock
        if (!top->clk)
        {
            if(contextp->time() < 5)
                top->rst = 1;
            else if(contextp->time() > 8){
                top->rst = 0;
                top->pc  = 0;
                std::bitset<32> binarySet("00000000001100001000000010010011");  // addi x1, x1, 3
                top->inst = binarySet.to_ulong();
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