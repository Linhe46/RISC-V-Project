#include <iostream>
#include <random>
#include <vector>
#include <fstream>
#include <bitset>

int main() {
    // 创建一个随机数生成器
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<uint32_t> dis(0, UINT32_MAX);

    // 创建一个向量来存储32个寄存器的值
    std::vector<uint32_t> registers(32);

    // x0 恒为 0
    registers[0] = 0;

    // 为其他寄存器生成随机值
    for (int i = 1; i < 32; ++i) {
        registers[i] = dis(gen);
    }

    // 打开文件进行写入
    std::ofstream outfile("../registers.txt");
    if (!outfile) {
        std::cerr << "无法打开文件进行写入" << std::endl;
        return 1;
    }

    // 输出寄存器值到文件
    for (int i = 0; i < 32; ++i) {
        std::bitset<32> binary(registers[i]);
        outfile << binary << " // x["  << i << "] = " << registers[i] << std::endl;
    }

    // 关闭文件
    outfile.close();

    std::cout << "寄存器值已写入文件 registers.txt" << std::endl;

    return 0;
}