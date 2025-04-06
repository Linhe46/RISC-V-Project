OBJ_DIR = obj_dir
# Register file generator using cpp
GEN_SRCS_REG = ./registers_gen.cpp
GEN_EXE_REG = ./obj_dir/registers_gen

# Data Memory generator using cpp
GEN_SRCS_DATA = ./data_memory_gen.cpp
GEN_EXE_DATA = ./obj_dir/data_memory_gen

# Inst Memory generator using cpp
GEN_SRCS_INST = ./inst_memory_gen.cpp
GEN_EXE_INST = ./obj_dir/inst_memory_gen

all: dmem_gen reg_gen imem_gen

# generate random data in data_memory
dmem_gen: $(GEN_SRCS_DATA) | $(OBJ_DIR)
	@g++ -o $(GEN_EXE_DATA) $(GEN_SRCS_DATA)
	@$(GEN_EXE_DATA)

# generate random data in register file
reg_gen: $(GEN_SRCS_REG) | $(OBJ_DIR)
	@g++ -o $(GEN_EXE_REG) $(GEN_SRCS_REG)
	@$(GEN_EXE_REG)

# dump instructions into inst_memory
imem_gen: $(GEN_SRCS_INST) | $(OBJ_DIR)
	@g++ -o $(GEN_EXE_INST) $(GEN_SRCS_INST)
	@$(GEN_EXE_INST)

# Ensure obj_dir exists
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

clean:
	rm -rf $(OBJ_DIR)

.PHONY: all clean