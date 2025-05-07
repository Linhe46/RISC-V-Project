# coe_to_bin.py
import sys

def coe_to_bin(input_file, output_file):
    with open(input_file, 'r') as coe, open(output_file, 'wb') as bin_file:
        for line in coe:
            line = line.strip()
            if line.startswith("memory_initialization_vector="):
                continue
            if line.startswith("memory_initialization_radix="):
                continue
            if line.endswith(";"):
                line = line[:-1]
            if line:
                for word in line.split(","):
                    if word.strip():
                        bin_file.write(int(word.strip(), 16).to_bytes(4, byteorder='little'))

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python coe_to_bin.py <input.coe> <output.bin>")
        sys.exit(1)
    coe_to_bin(sys.argv[1], sys.argv[2])