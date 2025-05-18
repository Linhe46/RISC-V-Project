import re

DEFINE_FILE = '../vsrcs/defines.sv'
# 打开 SystemVerilog 文件
with open(DEFINE_FILE, "r") as file:
    content = file.read()

# 提取宏定义
match = re.search(r"`define\s+INST_MEM_SIZE\s+(\d+)", content)
if match:
    inst_mem_size = match.group(1)
    print(f"{inst_mem_size}")