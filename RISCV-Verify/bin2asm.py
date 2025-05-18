# bin_to_asm.py
import subprocess
import sys
import os

def change_file_extension(file_name, new_extension):
    base_name = os.path.splitext(file_name)[0]  # 获取文件名（不含后缀）
    return f"{base_name}{new_extension}"       # 添加新的后缀

def bin_to_asm(binary_file, objdump_path="riscv64-unknown-elf-objdump"):
    """
    使用 riscv64-unknown-elf-objdump 反汇编 RISC-V 二进制文件。

    :param binary_file: 二进制文件路径
    :param objdump_path: objdump 工具路径（默认是 riscv64-unknown-elf-objdump）
    """
    try:
        # 构造 objdump 命令
        command = [
            objdump_path,
            "-D",  # 反汇编整个文件
            "-b", "binary",  # 指定输入文件是二进制格式
            "-m", "riscv:rv32",  # 指定目标架构为 RISC-V 32 位
            "-M", "numeric",  # 显示指令的机器码
            binary_file,
        ]

        # 执行命令
        result = subprocess.run(command, capture_output=True, text=True)
        # 检查是否成功
        output_file = change_file_extension(binary_file, '.asm')
        if result.returncode == 0:
            # 将反汇编结果写入文件
            with open(output_file, "w") as f:
                f.write(result.stdout)
            print(f"反汇编结果已写入文件: {output_file}")
        else:
            print("反汇编失败：")
            print(result.stderr)

    except FileNotFoundError:
        print(f"错误：未找到 objdump 工具，请确保 {objdump_path} 已安装并在 PATH 中。")
    except Exception as e:
        print(f"发生错误：{e}")
    
if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python bin2asm.py <input.bin>")
        sys.exit(1)
    binary_path = sys.argv[1]
    bin_to_asm(binary_path)