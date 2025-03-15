## tutorial for verilator testbench
### Preq
Verilator 5.032 2025-01-01 rev v5.032  
Gtkwave  

### Example
There is an easy edge trigger detector design in **top.sv**
```
.
├── Makefile
├── readme.md
├── sim_main.cpp // simulation wrapper file
└── top.sv // your design file
```

In the simulation wrapper file, you set the simulation testbench in a cpp way, including setting initial values, changing values, get the result, see **sim_main_template.cpp** for details

#### command line input
```
verilator -cc -exe --build --trace top.sv sim_main.cpp
```
Then you'll get an **obj_dir** dir, there is an executable file named **Vtop**
```
./obj_dir/Vtop
```
The result will be printed, and the wave.vcd is outputed.  
Use GTKwave to see the wave trace:
```
gtkwave wave.vcd
```
#### Makefile
See the Makefile for reference