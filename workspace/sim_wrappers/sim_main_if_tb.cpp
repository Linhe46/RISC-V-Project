#include <memory>
#include <verilated.h>
#include "Vif_tb.h"   // modified as "V<file_name>.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv)
{
    if (false && argc && argv){}
    const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
    contextp->debug(0);     // turn off the debug output
    //contextp->randReset(2);     // randomlize all signals
    contextp->traceEverOn(true);    // turn on wave tracing
    //contextp->commandArgs(argc, argv);    // pass command args
    const std::unique_ptr<Vif_tb> top{new Vif_tb{contextp.get(), "TOP"}}; // modify the type as V<file_name>
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 0);
    tfp->open("wave_dir/if_tb.vcd"); // set the output wave file name
    // set the module inputs' initial value
    top->clk = 0;
    top->rst = 0;
    top->stall = 0;
    top->branch_taken =0;
    top->branch_addr = 0;
    // start simulation until reaching finish time
    for(int i = 0; i < 50; i++){
        contextp->timeInc(1);   // increase the simulator's time stamp
        top->clk = !top->clk;   // toggle clock
        if(!top->clk){
            // initial reset
            if(contextp->time() < 5)
                top->rst = 1;
            else
                top->rst = 0;
            // test branch
            if(contextp->time() == 20){
                top->branch_taken = 1;
                top->branch_addr = 8;   // jump to third inst
            }
            else {
                top->branch_taken = 0;
                top->branch_addr = 0;
            }
        }
        top->eval();    // eval the value of the module
        tfp->dump(contextp->time()); // dump wave
        // print needed values for debugging
        //VL_PRINTF("[%" PRId64 "] clk=%x rst_n=%x a=%x rise=%x down=%x \n", contextp->time(), top->clk, top->rst_n, top->a, top->rise, top->down);
    }
    top->final();   // end the simulation
    tfp->close();   // end the wave file writing
    return 0;
}