# Verilog src dir
SRC_DIR = .

# Sim wrapper src dir
SIM_DIR = ./sim_wrappers

# CORE VERILOG SRCS
V_SRCS_IF = if.sv pc.sv inst_memory.sv if_id_reg.sv
V_SRCS_ID = id.sv registers.sv id_ex_reg.sv
V_SRCS_EX = ex.sv ex_mem_reg.sv
V_SRCS_MEM = mem.sv data_memory.sv mem_wb_reg.sv
V_SRCS_WB = wb.sv
V_SRCS_CTRL = stall_unit.sv forward_unit.sv
V_SRCS_CORE = core.sv $(V_SRCS_IF) $(V_SRCS_ID) $(V_SRCS_EX) $(V_SRCS_MEM) $(V_SRCS_WB) $(V_SRCS_CTRL)

# Simulation src files
SIM_SRCS_CORE = $(SIM_DIR)/sim_main_core.cpp

REG_TXT = registers.txt
MEM_TXT = inst_memory.txt data_memory.txt

# Object file dir
OBJ_DIR = obj_dir

# Executable file dir
EXE_CORE = obj_dir/Vcore

# GTKwave 
GTKWAVE = gtkwave

# add wave automatically
CORE_TCL = core.tcl

# Wave file
WAVE_CORE = wave_dir/core.vcd
WAVE = $(WAVE_CORE)

# Verilator Compiler
VERILATOR = verilator

# Compiling Options
VERILATOR_FLAGS = -cc --exe --build --trace -I/.

IMEM_GEN_ENABLE ?= true
DATA_GEN_ENABLE ?= false

core: $(V_SRCS_CORE) $(SIM_SRCS_CORE) $(MEM_TXT)
ifeq ($(IMEM_GEN_ENABLE), true)
	$(MAKE) imem_gen --no-print-directory -C ./data_gen -f Makefile
	@echo "\033[1;32mIMEM_GEN_ENABLE is true, write new instructions to inst_mem and run..\033[0m"
else
	@echo "\033[1;32mIMEM_GEN_ENABLE is false, run instructions in the inst_mem..\033[0m"
endif
ifeq ($(DATA_GEN_ENABLE), true)
	$(MAKE) dmem_gen --no-print-directory -C ./data_gen -f Makefile
	@echo "\033[1;32mDMEM_GEN_ENABLE is true, write new data to data_mem and run..\033[0m"
else
	@echo "\033[1;32mDMEM_GEN_ENABLE is false, use data in the data_mem..\033[0m"
endif
	$(VERILATOR) $(VERILATOR_FLAGS) $(V_SRCS_CORE) $(SIM_SRCS_CORE)
	@$(EXE_CORE)

#$(GTKWAVE) -T $(TCL_FILE...) $(WAVE_FILE...)
wave_core: $(WAVE_CORE)
	$(GTKWAVE) -T $(CORE_TCL) $(WAVE_CORE)

clean:
	rm -rf $(OBJ_DIR) $(WAVE)

.PHONY: all run clean wave
