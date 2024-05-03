# Makefile for automating matrix multiplication testbench generation and simulation

# Define variables
N ?= 4# Default matrix size
PYTHON_SCRIPT = test_bench_gen.py
TB_FILE = matrix_multiplication_tb_$(N)x$(N).v
VERILOG_FILES = SystolicArray.sv PE.sv $(TB_FILE)
OUTPUT = output

# Default target
all: simulate

# Target to generate the testbench using the Python script
$(TB_FILE): $(PYTHON_SCRIPT)
	python3 $(PYTHON_SCRIPT) $(N)

# Target to compile the Verilog files
compile: $(VERILOG_FILES)
	iverilog -g2012 -o $(OUTPUT) $(VERILOG_FILES)

# Target to run the simulation
simulate: compile
	vvp $(OUTPUT)

# Clean target to remove generated files
clean:
	rm -f $(OUTPUT) $(TB_FILE)

# Specify that the targets are not files
.PHONY: all compile simulate clean
