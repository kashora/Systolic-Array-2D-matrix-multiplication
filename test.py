# Python script to generate a Verilog testbench for matrix multiplication

def generate_verilog_testbench(N):
    # Ensure N is either 4 or 8
    if N not in [4, 8]:
        raise ValueError("N must be either 4 or 8")

    # Generate random 4-bit unsigned matrices for testing
    import random
    matrix_a = [[random.randint(0, 15) for _ in range(N)] for _ in range(N)]
    matrix_b = [[random.randint(0, 15) for _ in range(N)] for _ in range(N)]

    # Compute the expected multiplication result
    matrix_result = [[sum(matrix_a[i][k] * matrix_b[k][j] for k in range(N)) for j in range(N)] for i in range(N)]

    # Generate the Verilog testbench code
    tb_code = f"""
`timescale 1ns/1ps
module matrix_multiplication_tb;

    reg clk, rst;
    reg [3:0] matrix_a[{N-1}:0][{N-1}:0];
    reg [3:0] matrix_b[{N-1}:0][{N-1}:0];
    wire [10:0] result_matrix[{N-1}:0][{N-1}:0];
    wire done;

    initial begin
        clk = 0;
        rst = 1;

    // Initialize matrix A
"""
    for i in range(N):
        for j in range(N):
            tb_code += f"\t\tmatrix_a[{i}][{j}] = 4'd{matrix_a[i][j]};\n"

    tb_code += "\n\t\t// Initialize matrix B\n"
    for i in range(N):
        for j in range(N):
            tb_code += f"\t\tmatrix_b[{i}][{j}] = 4'd{matrix_b[i][j]};\n"

    tb_code += """
      #10 rst = 0;
      wait(done);
"""
    
    for i in range(N):
        for j in range(N):
            expected = matrix_result[i][j]
            tb_code += f"\t\tif (result_matrix[{i}][{j}] !== {expected})\n"
            tb_code += f"\t\t\t$display(\"Error: result_matrix[{i}][{j}] = %d, expected = {expected}\", result_matrix[{i}][{j}]);\n"

    tb_code += """
        $stop;
    end

    always #5 clk = ~clk;

    // Instantiate the design under test (DUT)
    SystolicArray #(""" + str(N) + """) dut (
        .clk_i(clk),
        .rst_i(rst),
        .MatA_i(matrix_a),
        .MatB_i(matrix_b),
        .resultMatrix_o(result_matrix),
        .done_o(done)
    );

endmodule
"""
    # Save the Verilog testbench to a file
    with open(f"matrix_multiplication_tb_{N}x{N}.v", "w") as f:
        f.write(tb_code)

    print(f"Verilog testbench for {N}x{N} matrix multiplication generated successfully!")

# Example usage:
generate_verilog_testbench(4) # For 4x4 matrices
generate_verilog_testbench(8) # For 8x8 matrices
