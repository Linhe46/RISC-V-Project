#include <iostream>
#include <random>
#include <vector>
#include <fstream>
#include <iomanip>
#include <bitset>

int main(int argc, char** argv) {
    // 创建一个随机数生成器
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<uint32_t> dis(0, UINT32_MAX);
    if(argc != 2){
        std::cout<<" Wrong arguments number" << std::endl;
        return 1;
    }

    int DATA_MEM_SIZE = std::stoi(argv[1]);
    //#define DATA_MEM_SIZE 4096
    std::vector<uint32_t> dmem(DATA_MEM_SIZE);

    for (int i = 0; i < DATA_MEM_SIZE; ++i) {
        dmem[i] = dis(gen);
    }

    // 打开文件进行写入
    std::ofstream outfile("../data_memory.txt");
    if (!outfile) {
        std::cerr << "无法打开文件进行写入" << std::endl;
        return 1;
    }

    // 输出寄存器值到文件
    for (int i = 0; i < DATA_MEM_SIZE; ++i) {
        //std::bitset<32> binary(dmem[i]);
        outfile << std::left <<  std::hex << std::uppercase << std::setw(8) << std::setfill('0') << dmem[i];
        outfile << std::dec  << " // MEM["  << 4*i + 3<< ":" << 4*i << "] = " << dmem[i] << std::endl;
    }

    // 关闭文件
    outfile.close();

    std::cout << "Random data has benn written to data_memory.txt" << std::endl;

    return 0;
}