#!/bin/bash
root_dir="$HOME/RISCV-Project"
RTL_COMMON_DIR="$root_dir/RTL/Common"
RTL_UNIQUE_DIR="$root_dir/RTL/Unique/RISCV-Trace"
ln -s $RTL_COMMON_DIR/*.sv ./mySoC
ln -sf $RTL_UNIQUE_DIR/*.sv ./mySoC