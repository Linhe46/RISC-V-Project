# RISC-V CPU Design Project
## Brief Intro.
This Project is a 5-stage pipelined RV32I CPU implemented in SystemVerilog HDL.

The project is targeted at The 9th China College IC Competition-The JYD Trophy(第九届集创赛-竞业达杯)'s preliminary contest.

Out team ID is CICC0901516.

## Overview
## Platform
WSL2 Linux Ubuntu 22.04 LTS
## Dependencies
[Verilator 5.032](https://github.com/verilator/verilator)  
[GTKWave Analyzer v3.3.104](https://gtkwave.sourceforge.net/)  
[GNU Make 4.3](https://www.gnu.org/software/make/)  
[Vivado v2023.2 (64-bit)](https://china.xilinx.com/support/download/index.html/content/xilinx/zh/downloadNav/vivado-design-tools.html)  
[Python3](https://www.python.org/downloads/)

## Structrue
The project's structrue is as below:
```
.
├── README.md
├── RISCV-Trace/
├── RISCV-Verify/
└── workspace/
```
- workspace: Include all design srcs and **self-defined testcases**.  
- RISCV-Trace: Include **cdp-tests testcases** and modified srcs for ```miniRV_SoC.sv```.
- RISCV-Verify: Include **on-board vivado project** and **testcase provided by preliminary contest**(test.asm).

## Simulation
### RISCV-Trace
#### Structure
```
./
├── Makefile
├── asm/
├── bin/
├── csrc/
├── golden_model/
├── meminit.bin -> bin/add.bin
├── mySoC/          # all design srcs are added here
├── obj_dir/
├── run_all_tests.py
├── start.dump
├── vsrc/
└── waveform/
```
Except modification for ```mySoC/``` to implement our CPU deisgn, other content is the same as [cdp-tests](https://gitee.com/hitsz-cslab/cdp-tests).
#### Usage
1.Enter the directory
```bash
cd RISCV-Trace
```
2.Test Single case  
You can run single test choosing from **{add, addi, and, andi, ...}**. See testcase names in ```bin/``` for details.  
For example, the below command will test ```add.bin```:
```bash
make run TEST=add
```

3.Test all cases
Run the commands below to start all 39 testcases simulation.
```bash
make build    # make sure build once before run all tests
python3 run_all_tests
```

(Optional) After running any case, watch wave using gtkwave, e.g. ```gtkwave waveform/add.vcd```


### workspace
#### Structure
```
./
├── Makefile
├── data_gen/       # IMEM/DMEM data gen scripts
├── readme.md
├── sim_results/
├── sim_wrappers/   # verilator wrappers
├── top.tcl         # trace tcl used for monitoring
├── vsrcs/          # CPU design .sv codes
└── wave_dir/
```

#### Usage
1.Enter the directory  
```bash
cd workspace
```

2.Create dump files
```bash
touch inst_memory.txt
touch data_memory.txt
```

(Optional) Add self-defined instructions stored in IMEM as needed(see ```data_gen/inst_memory_gen.cpp```), you may need modify the memory config in ```vsrcs/defines.sv``` for instruction set larger than default(16x32bit)

(Optinal) Add self-defined data stored in DMEM as needed(see ```data_gen/data_memory_gen.cpp```), you may need modify the memory config in ```vsrcs/defines.sv``` for data size larger than default(32x32bit)

3.Generate inst_memory/data_memory data and Run CPU simulation.  
The make options set 'true' will write insts in ```data_gen_inst_memory.cpp``` and data in ```data_gen_data_memory.cpp``` into dump files before simulation.
```bash
make top IMEM_GEN_ENABLE=true DMEM_GEN_ENABLE=true
```

If you have written inst_memory/data_memory once and don't want to write again, just run 
```bash
make top
```
to start CPU simulation only.

4.If no error occurs, you can watch waveform by
```bash
make wave
```
This will open simulation wave using gtkwave and display waves set by ```top.tcl```.  
(Optional) Modify ```top.tcl``` to watch waves as needed.
