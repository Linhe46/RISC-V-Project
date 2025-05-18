# RV32I CPU Design Source Codes
All RTL level design source codes are placed here separately.

```
./
├── Common/
├── Unique/
└── readme.md
```
The ```Common``` dir stores basic modules for our pipelined CPU core(5 stages, pipelined regs, pc, register file, forwarding unit, stall unit).  
The ```Unique``` dir stores unique design codes for implementation of simulation and verification.

# Common Codes
## Periphery 
### inst_memory.sv
Receive PC address and send out the instruction.  
The memory is implemented as an Array. The index is aligned by lowe 2bits(4 Bytes).  
The test value in memory is in ```inst_memory.txt```, loaded by **$readmemb** verilog function.

### data_memory.sv
Handicraft DMEM supporting mask read/write.

## PC/Register file
### pc.sv
Maintain the Program Counter and interact with IROM.

### registers.sv
32 Register file in CPU core, where x0===0.

## Pipeline stages/regfile

### if.sv
The interface to receive PC output and pass down pc and inst to later stages.

### if_id_reg.sv
Pipeline register file for IF/ID.  
Pass down **Instruction** and **PC** each cycle.

### id.sv
The stage to excute **decoding, branching, control bits gen., imm. gen., etc.

### id_ex_reg.sv
Pipeline register file for IF/EX.  
Pass down **ALU oprands** and **Ctrl. bits**.

### ex.sv
Perform computation using ALU according to ```alu_op``` and ```alu_src```

### ex_mem.sv
Pipeline register file for EX/MEM.  
Pass down **Memory read/write addr/data** and **Ctrl. bits**.

### mem.sv
Interface to interact with DMEM.

### mem_wb.sv
Pipeline register file for MEM/WB.  
Pass down **Write back addr/data** and **Ctrl. bits**.

### wb.sv
Interface to write back to register file.

## Hazzard Detect & Stall
### forward_unit.sv
Detect data dependencies and forward data to id or ex stages.

### stall_unit.sv
Stall the pipeline to solve **load-use** hazzard and **brach flush**.

## Signal Table
### defines.sv
Define the macro for essential signals through pipeline stages and some basic configs.

# Unique Codes
See ```readme``` in ```Unique```'s subdir for details.