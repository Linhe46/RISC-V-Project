#include <memory>
#include <verilated.h>
#include "Vif.h"   // modified as "V<file_name>.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv)
{
    if (false && argc && argv){}
    const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
    contextp->debug(0);     // turn off the debug output
    //contextp->randReset(2);     // randomlize all signals
    contextp->traceEverOn(true);    // turn on wave tracing
    //contextp->commandArgs(argc, argv);    // pass command args
    const std::unique_ptr<Vif> top{new Vif{contextp.get(), "TOP"}}; // modify the type as V<file_name>
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 0);
    tfp->open("wave_dir/if_wave.vcd"); // set the output wave file name
    // set the module inputs' initial value
    top->clk = 0;
    top->rst = 0;
    top->PC_write_en = 0;
    top->is_uncon_branch = 0;
    top->stall = 0;
    top->branch_taken =0;
    top->branch_addr = 0;
    // start simulation until reaching finish time
    while (!contextp->gotFinish())
    {
        for(int i = 0; i < 50; i++){
            contextp->timeInc(1);   // increase the simulator's time stamp
            top->clk = !top->clk;   // toggle clock
            // assign new value at negative cycle
            if(!top->clk){
                // initial reset
                if(contextp->time() < 6)
                    top->rst = 1;
                else top->rst = 0;
                // write enable
                if(contextp->time() > 10)
                    top->PC_write_en = 1;
            }
            top->eval();    // eval the value of the module
            tfp->dump(contextp->time()); // dump wave
            // print needed values for debugging
            //VL_PRINTF("[%" PRId64 "] clk=%x rst_n=%x a=%x rise=%x down=%x \n", contextp->time(), top->clk, top->rst_n, top->a, top->rise, top->down);
        }
        break;
    }
    top->final();   // end the simulation
    tfp->close();   // end the wave file writing
    return 0;
}