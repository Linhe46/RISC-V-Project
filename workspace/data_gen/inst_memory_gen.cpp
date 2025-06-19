#include <iostream>
#include <random>
#include <vector>
#include <fstream>
#include <iomanip>
#include <bitset>
#include <unordered_map>
#include <algorithm>
#include <string>
//#define INST_MEM_SIZE 16

using InstSet = std::vector<std::pair<std::string, std::string>>;

std::string NOP = "0000000_00000_00000_000_00000_0000000";
std::pair<std::string, std::string> NOP_pair = {NOP, "// NOP"};

// (inst, comment) pairs for debugging
InstSet insts_ls{
    {"0000000_00000_00000_100_00011_0110111",
        "// LUI x3 = 4 << 12"},     // x3 = 4096*4=16384
    {"0000000_00011_00011_000_00001_0010011", 
        "// ADDI x1, x3, 3"},       // x1 = x3 + 3 = 16387 lui-use is R-type hazzard
    {"0000000_00001_00000_000_00010_0010011",
        "// ADDI x2, x0, 1"},       // x2 = 1
    {"0000000_00010_00010_101_01000_0000011",
        "// LHU x8 = MEM[x2 + 2] = MEM[3] // R-type hazzard"},
    {"0000000_00001_01000_000_00100_0110011",
        "// ADD x4 = x8 + x1 // load use hazzard"},
    {"0000000_00011_00010_010_00011_0100011", 
        "// SW x3 (3)x2"}                   // MEM[x2 + 3] = x3
};

InstSet insts_bra{
    {"0000000_01111_00010_000_00010_0010011", 
        "// ADDI\tx2, x0, 15"},   // x2 = x2 + 15
    {"0000000_00001_00001_000_00001_0010011", 
        "// ADDI\tx1, x1, 1"},   // x1 = x1 + 1 
    {"0000000_00001_00001_000_00001_0010011", 
        "// ADDI\tx1, x1, 1"},   // x1 = x1 + 1 
    //{"1111111_00010_00001_000_11101_1100011",
    //    "// BEQ x1 x2, offset = -2 << 1"}
    {"1111111_00010_00001_001_11101_1100011",
        "// BNE\tx1, x2, -4"}
};

std::string trans_to_hex(std::string inst){
    inst.erase(std::remove(inst.begin(), inst.end(), '_'), inst.end());
    if(inst.size() != 32)
        throw std::runtime_error("Malformed binary instruction !");
    unsigned long decimalValue = std::stoul(inst, nullptr, 2); // to decimal
    std::stringstream ss;
    ss << std::hex << std::uppercase << std::setfill('0') << std::setw(8) << decimalValue;
    // return hex format
    return ss.str();
}

int main(int argc, char** argv) {

    if(argc != 2) {
        std::cout <<"Wrong arguments num" << std::endl;
        return 1;
    }
    int INST_MEM_SIZE = std::stoi(argv[1]);

    std::ofstream outfile("../inst_memory.txt");
    if(!outfile) {
        std::cerr << "Can't write to file !" << std::endl;
        return 1;
    }

    auto& insts = insts_bra;

    auto insts_num = insts.size();
    try{
        for(int i = 0; i < INST_MEM_SIZE; i++) {
            if(i < insts_num)
                outfile << std::left << trans_to_hex(insts[i].first) << "  " <<  insts[i].second << std::endl;
            else outfile << std::left << trans_to_hex(NOP) << "  " << "// NOP" << std::endl;
        }
    }
    catch(std::runtime_error& e){
        std::cerr << e.what() << std::endl;
    }
    outfile.close();

    std::cout << "Instructions have been written to inst_memory.txt" << std::endl;

}