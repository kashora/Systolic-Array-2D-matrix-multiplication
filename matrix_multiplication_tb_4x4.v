
`timescale 1ns/1ps
module matrix_multiplication_tb;

    reg clk, rst;
    reg [3:0] matrix_a[3:0][3:0];
    reg [3:0] matrix_b[3:0][3:0];
    wire [10:0] result_matrix[3:0][3:0];
    wire done;

    initial begin
        clk = 0;
        rst = 1;

    // Initialize matrix A
		matrix_a[0][0] = 4'd1;
		matrix_a[0][1] = 4'd1;
		matrix_a[0][2] = 4'd10;
		matrix_a[0][3] = 4'd8;
		matrix_a[1][0] = 4'd2;
		matrix_a[1][1] = 4'd14;
		matrix_a[1][2] = 4'd0;
		matrix_a[1][3] = 4'd14;
		matrix_a[2][0] = 4'd1;
		matrix_a[2][1] = 4'd4;
		matrix_a[2][2] = 4'd11;
		matrix_a[2][3] = 4'd15;
		matrix_a[3][0] = 4'd15;
		matrix_a[3][1] = 4'd11;
		matrix_a[3][2] = 4'd0;
		matrix_a[3][3] = 4'd8;

		// Initialize matrix B
		matrix_b[0][0] = 4'd15;
		matrix_b[0][1] = 4'd4;
		matrix_b[0][2] = 4'd11;
		matrix_b[0][3] = 4'd11;
		matrix_b[1][0] = 4'd11;
		matrix_b[1][1] = 4'd5;
		matrix_b[1][2] = 4'd9;
		matrix_b[1][3] = 4'd14;
		matrix_b[2][0] = 4'd6;
		matrix_b[2][1] = 4'd0;
		matrix_b[2][2] = 4'd13;
		matrix_b[2][3] = 4'd12;
		matrix_b[3][0] = 4'd0;
		matrix_b[3][1] = 4'd4;
		matrix_b[3][2] = 4'd10;
		matrix_b[3][3] = 4'd14;

      #10 rst = 0;
      wait(done);
		if (result_matrix[0][0] !== 86)
			$display("Error: result_matrix[0][0] = %d, expected = 86", result_matrix[0][0]);
		if (result_matrix[0][1] !== 41)
			$display("Error: result_matrix[0][1] = %d, expected = 41", result_matrix[0][1]);
		if (result_matrix[0][2] !== 230)
			$display("Error: result_matrix[0][2] = %d, expected = 230", result_matrix[0][2]);
		if (result_matrix[0][3] !== 257)
			$display("Error: result_matrix[0][3] = %d, expected = 257", result_matrix[0][3]);
		if (result_matrix[1][0] !== 184)
			$display("Error: result_matrix[1][0] = %d, expected = 184", result_matrix[1][0]);
		if (result_matrix[1][1] !== 134)
			$display("Error: result_matrix[1][1] = %d, expected = 134", result_matrix[1][1]);
		if (result_matrix[1][2] !== 288)
			$display("Error: result_matrix[1][2] = %d, expected = 288", result_matrix[1][2]);
		if (result_matrix[1][3] !== 414)
			$display("Error: result_matrix[1][3] = %d, expected = 414", result_matrix[1][3]);
		if (result_matrix[2][0] !== 125)
			$display("Error: result_matrix[2][0] = %d, expected = 125", result_matrix[2][0]);
		if (result_matrix[2][1] !== 84)
			$display("Error: result_matrix[2][1] = %d, expected = 84", result_matrix[2][1]);
		if (result_matrix[2][2] !== 340)
			$display("Error: result_matrix[2][2] = %d, expected = 340", result_matrix[2][2]);
		if (result_matrix[2][3] !== 409)
			$display("Error: result_matrix[2][3] = %d, expected = 409", result_matrix[2][3]);
		if (result_matrix[3][0] !== 346)
			$display("Error: result_matrix[3][0] = %d, expected = 346", result_matrix[3][0]);
		if (result_matrix[3][1] !== 147)
			$display("Error: result_matrix[3][1] = %d, expected = 147", result_matrix[3][1]);
		if (result_matrix[3][2] !== 344)
			$display("Error: result_matrix[3][2] = %d, expected = 344", result_matrix[3][2]);
		if (result_matrix[3][3] !== 431)
			$display("Error: result_matrix[3][3] = %d, expected = 431", result_matrix[3][3]);

        $stop;
    end

    always #5 clk = ~clk;

    // Instantiate the design under test (DUT)
    SystolicArray #(4) dut (
        .clk_i(clk),
        .rst_i(rst),
        .MatA_i(matrix_a),
        .MatB_i(matrix_b),
        .resultMatrix_o(result_matrix),
        .done_o(done)
    );

endmodule
