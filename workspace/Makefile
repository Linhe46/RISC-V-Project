# Verilog src dir
SRC_DIR = .

# Sim wrapper src dir
SIM_DIR = ./sim_wrappers

# Verilog src files
V_SRCS_ID_TB = id_tb.sv id.sv registers.sv id_ex_reg.sv
V_SRCS_EX_TB = ex_tb.sv id.sv registers.sv id_ex_reg.sv ex.sv ex_mem_reg.sv
V_SRCS_CORE_NO_IF = core_no_if.sv id.sv id_ex_reg.sv ex.sv ex_mem_reg.sv mem.sv mem_wb_reg.sv wb.sv registers.sv data_memory.sv

# Simulation src files
SIM_SRCS_ID_TB = $(SIM_DIR)/sim_main_id_tb.cpp
SIM_SRCS_EX_TB = $(SIM_DIR)/sim_main_ex_tb.cpp
SIM_SRCS_CORE_NO_IF = $(SIM_DIR)/sim_main_core_no_if.cpp

# Register file generator using cpp
GEN_SRCS = ./registers_gen.cpp
GEN_EXE = ./registers_gen

# Object file dir
OBJ_DIR = obj_dir

# Executable file dir
EXE_ID_TB = obj_dir/Vid_tb
EXE_EX_TB = obj_dir/Vex_tb
EXE_CORE_NO_IF = obj_dir/Vcore_no_if

# GTKwave 
GTKWAVE = gtkwave
# add wave automatically
TCL_FILE_ID_TB = id_tb.tcl
TCL_FILE_EX_TB = ex_tb.tcl
TCL_FILE_CORE_NO_IF = core_no_if.tcl

# Wave file
WAVE_ID_TB = wave_dir/id_tb.vcd
WAVE_EX_TB = wave_dir/ex_tb.vcd
WAVE_CORE_NO_IF = wave_dir/core_no_if.vcd
WAVE = $(WAVE_ID_TB) $(WAVE_EX_TB) $(WAVE_CORE_NO_IF)

# Verilator Compiler
VERILATOR = verilator

# Compiling Options
VERILATOR_FLAGS = -cc --exe --build --trace

id_tb: $(V_SRCS_ID_TB) $(SIM_SRCS_ID_TB) $(GEN_SRCS)
	g++ -o $(GEN_EXE) $(GEN_SRCS)
	$(GEN_EXE)
	$(VERILATOR) $(VERILATOR_FLAGS) $(V_SRCS_ID_TB) $(SIM_SRCS_ID_TB)
	$(EXE_ID_TB)

ex_tb: $(V_SRCS_ID_TB) $(SIM_SRCS_EX_TB) $(GEN_SRCS)
	$(VERILATOR) $(VERILATOR_FLAGS) $(V_SRCS_EX_TB) $(SIM_SRCS_EX_TB)
	$(EXE_EX_TB)

core_no_if: $(V_SRCS_CORE_NO_IF) $(SIM_SRCS_CORE_NO_IF)
	$(VERILATOR) $(VERILATOR_FLAGS) $(V_SRCS_CORE_NO_IF) $(SIM_SRCS_CORE_NO_IF)
	$(EXE_CORE_NO_IF)

# run is merged into compilation
#run: $(EXE)
#	$(EXE)

wave_id_tb: $(WAVE_ID_TB) $(TCL_FILE_ID_TB)
	$(GTKWAVE) -T $(TCL_FILE_ID_TB) $(WAVE_ID_TB)

wave_ex_tb: $(WAVE_EX_TB) $(TCL_FILE_EX_TB)
	$(GTKWAVE) -T $(TCL_FILE_EX_TB) $(WAVE_EX_TB)

wave_core_no_if: $(WAVE_CORE_NO_IF) $(TCL_FILE_CORE_NO_IF)
	$(GTKWAVE) -T $(TCL_FILE_CORE_NO_IF) $(WAVE_CORE_NO_IF)

clean:
	rm -rf $(OBJ_DIR) $(WAVE)

.PHONY: all run clean wave
