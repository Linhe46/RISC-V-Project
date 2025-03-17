# Verilog src dir
SRC_DIR = .

# Sim wrapper src dir
SIM_DIR = ./sim_wrappers

# Verilog src files
VERILOG_SRCS = test_id.sv id.sv registers.sv

# Simulation src files
SIM_SRCS = $(SIM_DIR)/sim_main_test_id.cpp

# Register file generator using cpp
GEN_SRCS = ./registers_gen.cpp
GEN_EXE = ./registers_gen

# Object file dir
OBJ_DIR = obj_dir

# Executable file dir
EXE = obj_dir/Vtest_id

# GTKwave 
GTKWAVE = gtkwave

# Wave file
WAVE = wave_dir/test_id.vcd

# Verilator Compiler
VERILATOR = verilator

# Compiling Options
VERILATOR_FLAGS = -cc --exe --build --trace

test_id: $(VERILOG_SRCS) $(SIM_SRCS) $(GEN_SRCS)
	g++ -o $(GEN_EXE) $(GEN_SRCS)
	$(GEN_EXE)
	$(VERILATOR) $(VERILATOR_FLAGS) $(VERILOG_SRCS) $(SIM_SRCS)

run: $(EXE)
	$(EXE)

wave: $(WAVE)
	$(GTKWAVE) $(WAVE)

clean:
	rm -rf $(OBJ_DIR) wave.vcd

.PHONY: all run clean wave
