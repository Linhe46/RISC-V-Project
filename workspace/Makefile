# Verilog src dir
SRC_DIR = ./vsrcs

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
V_SRCS_TOP_ORIG = top.sv $(V_SRCS_CORE)
V_SRCS_TOP = $(addprefix $(SRC_DIR)/, $(V_SRCS_TOP_ORIG))

# Simulation src files
SIM_SRCS_TOP = $(SIM_DIR)/sim_main_top.cpp

REG_TXT = registers.txt
MEM_TXT = inst_memory.txt data_memory.txt

# Object file dir
OBJ_DIR = obj_dir

# Executable file dir
EXE_TOP = obj_dir/Vtop

# GTKwave 
GTKWAVE = gtkwave

# add wave automatically
TOP_TCL = top.tcl

# Wave file
WAVE_DIR = wave_dir
WAVE_TOP = $(WAVE_DIR)/top.vcd
WAVE = $(WAVE_TOP)

# Verilator Compiler
VERILATOR = verilator

# Compiling Options
VERILATOR_FLAGS = -cc --exe --build --trace -I/. -I./vsrcs

IMEM_GEN_ENABLE ?= false
DMEM_GEN_ENABLE ?= false

top: $(V_SRCS_TOP) $(SIM_SRCS_TOP) $(MEM_TXT)
ifeq ($(IMEM_GEN_ENABLE), true)
	$(MAKE) imem_gen --no-print-directory -C ./data_gen -f Makefile
	@echo "\033[1;32mIMEM_GEN_ENABLE is true, write new instructions to inst_mem and run..\033[0m"
else
	@echo "\033[1;32mIMEM_GEN_ENABLE is false, run instructions in the inst_mem..\033[0m"
endif
ifeq ($(DMEM_GEN_ENABLE), true)
	$(MAKE) dmem_gen --no-print-directory -C ./data_gen -f Makefile
	@echo "\033[1;32mDMEM_GEN_ENABLE is true, write new data to data_mem and run..\033[0m"
else
	@echo "\033[1;32mDMEM_GEN_ENABLE is false, use data in the data_mem..\033[0m"
endif
	mkdir -p $(WAVE_DIR)
	$(VERILATOR) $(VERILATOR_FLAGS) $(V_SRCS_TOP) $(SIM_SRCS_TOP)
	@$(EXE_TOP)

#$(GTKWAVE) -T $(TCL_FILE...) $(WAVE_FILE...)
wave: $(WAVE_TOP)
	$(GTKWAVE) -T $(TOP_TCL) $(WAVE_TOP)

clean:
	rm -rf $(OBJ_DIR) $(WAVE)

.PHONY: all run clean wave
