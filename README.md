# Systolic-Array-2D-matrix-multiplication

This is a repo to implement the 2D matrix multiplication using systolic array architecture.

## Systolic Matrix Multiplication
Need to add the desciption of the systolic array architecture and how it is used to multiply two matrices.


## How to run the code

To generate the test benches you can run the following command:
```bash
$ python3 test_bench_gen.py
```
This will generate the test benches for 4x4 and 8x8 matrix multiplication.

To validate the 4x4 matrix multiplication you can run the following command:
```bash
$ iverilog -g2012 -o output matrix_multiplication_tb_4x4.v SystolicArray.sv PE.sv
$ vvp output
```

To validate the 8x8 matrix multiplication you can run the following command:
```bash
$ iverilog -g2012 -o output matrix_multiplication_tb_8x8.v SystolicArray.sv PE.sv
$ vvp output
```
The folder "only 4 bits result" contains the code for 4x4 and 8x8 matrix multiplication assuming the arithmatic operation results in only 4 bits.


## To Do
- [ ] Add the description of the systolic array architecture.
- [ ] Add the description of the code.
- [ ] Add a makefile to run the code.
