# CPU core source code
> Please explain the code simply which you're responsible for.

## Sim_main wrapper srcs
*All files are named like ```sim_main_<verilog_file>.cpp```*  
Input cpp-style simulation testbench, used in Verilator verification.
## Verilog srcs
### defines.sv
Define some macros for reuse in verilog files, like **decode bits**, **signal width**, **stall types**, etc.  
Add as needed.

### if.sv
The Program counter(PC) used for fetching instructions and update PC.

### InstMem.sv
Receive PC address and send out the instruction.  
The memory is implemented as an Array. The index is aligned by lowe 2bits(4 Bytes).  
The test value in memory is in ```inst_memory.txt```, loaded by **$readmemb** verilog function.

### if_id_reg.sv
Pipeline register file for IF/ID.  
Pass down **Instruction** and **PC** each cycle.
