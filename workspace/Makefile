# Verilog src dir
SRC_DIR = .

# Sim wrapper src dir
SIM_DIR = ./sim_wrappers

# Verilog src files
VERILOG_SRCS = id_tb.sv id.sv registers.sv id_ex_reg.sv

# Simulation src files
SIM_SRCS = $(SIM_DIR)/sim_main_id_tb.cpp

# Register file generator using cpp
GEN_SRCS = ./registers_gen.cpp
GEN_EXE = ./registers_gen

# Object file dir
OBJ_DIR = obj_dir

# Executable file dir
EXE = obj_dir/Vid_tb

# GTKwave 
GTKWAVE = gtkwave
# add wave automatically
TCL_FILE = id_tb.tcl

# Wave file
WAVE = wave_dir/id_tb.vcd

# Verilator Compiler
VERILATOR = verilator

# Compiling Options
VERILATOR_FLAGS = -cc --exe --build --trace

id_tb: $(VERILOG_SRCS) $(SIM_SRCS) $(GEN_SRCS)
	g++ -o $(GEN_EXE) $(GEN_SRCS)
	$(GEN_EXE)
	$(VERILATOR) $(VERILATOR_FLAGS) $(VERILOG_SRCS) $(SIM_SRCS)

run: $(EXE)
	$(EXE)

wave: $(WAVE) $(TCL_FILE)
	$(GTKWAVE) -T $(TCL_FILE) $(WAVE)

clean:
	rm -rf $(OBJ_DIR) $(WAVE)

.PHONY: all run clean wave
