
# Verilog 源文件目录
SRC_DIR = .

# 仿真源文件目录
SIM_DIR = .

# Verilog 源文件
VERILOG_SRCS = $(SRC_DIR)/top.sv

# 仿真源文件
SIM_SRCS = $(SIM_DIR)/sim_main.cpp

# 生成的对象目录
OBJ_DIR = obj_dir

EXE = obj_dir/Vtop

# Verilator 编译器
VERILATOR = verilator

# 编译选项
VERILATOR_FLAGS = -cc --exe --build --trace

# 编译和生成可执行文件
all: $(VERILOG_SRCS) $(SIM_SRCS)
	$(VERILATOR) $(VERILATOR_FLAGS) $(VERILOG_SRCS) $(SIM_SRCS) 

# 运行仿真
run: $(EXE)
	$(EXE)

# 清理生成的文件
clean:
	rm -rf $(OBJ_DIR) wave.vcd

.PHONY: all run clean
