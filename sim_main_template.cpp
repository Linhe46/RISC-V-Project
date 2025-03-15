#include <memory>
#include <verilated.h>
#include "Vtop.h"   // modified as "V<file_name>.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv)
{
    if (false && argc && argv){}
    const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
    contextp->debug(0);     // turn off the debug output
    //contextp->randReset(2);     // randomlize all signals
    contextp->traceEverOn(true);    // turn on wave tracing
    //contextp->commandArgs(argc, argv);    // pass command args
    const std::unique_ptr<Vtop> top{new Vtop{contextp.get(), "TOP"}}; // modify the type as V<file_name>
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 0);
    tfp->open("wave.vcd"); // set the output wave file name
    /* set the module inputs' initial value */
    // top->clk = ...
    // top->rst = ...
    // top->... = ...

    /* start simulation until reaching finish time */
    /* you can also write a for-loop to run certain times */
    while (!contextp->gotFinish())
    {
        contextp->timeInc(1);   // increase the simulator's time stamp
        top->clk = !top->clk;   // toggle clock
        /* assign new value at negative cycle */
        if (!top->clk)
        {
            //...
        }
        top->eval();    // eval the value of the module
        tfp->dump(contextp->time()); // dump wave
        // print needed value for debugging
        //VL_PRINTF("[%" PRId64 "] clk=%x rst_n=%x a=%x rise=%x down=%x \n", contextp->time(), top->clk, top->rst_n, top->a, top->rise, top->down);
        
        /* if you don't set a $finish time, remember break if needed */
        // if(...) break;
    }
    top->final();   // end the simulation
    tfp->close();   // end the wave file writing
    return 0;
}