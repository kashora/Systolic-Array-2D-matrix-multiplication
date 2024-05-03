module SystolicArray_TB;

  // Inputs
  reg clk_i;
  reg rst_i;
  reg [4:0] counter;
  reg [3:0] MatA_i [4][4];
  reg [3:0] MatB_i [4][4];

  // Outputs
  wire [10:0] resultMatrix_o [4][4];
  wire done_o;

  // Instantiate the module under test
  SystolicArray #(4) dut (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .MatA_i(MatA_i),
    .MatB_i(MatB_i),
    .resultMatrix_o(resultMatrix_o),
    .done_o(done_o),
    .counter(counter)
  );

  // Clock generation
  initial begin
    clk_i = 0;
    forever begin
      #5 clk_i = ~clk_i;
    end

  end


  

  // Test stimulus
  initial begin

    $display("Starting test...");

    rst_i = 1;
    // Initialize input matrices
    // ...
    MatA_i[0][0] <= 0; MatA_i[0][1] <= 2; MatA_i[0][2] <= 3; MatA_i[0][3] <= 4;
    MatA_i[1][0] <= 5; MatA_i[1][1] <= 6; MatA_i[1][2] <= 7; MatA_i[1][3] <= 8;
    MatA_i[2][0] <= 9; MatA_i[2][1] <= 10; MatA_i[2][2] <= 11; MatA_i[2][3] <= 12;
    MatA_i[3][0] <= 13; MatA_i[3][1] <= 14; MatA_i[3][2] <= 15; MatA_i[3][3] <= 15;

    MatB_i[0][0] = 1; MatB_i[0][1] = 2; MatB_i[0][2] = 3; MatB_i[0][3] = 4;
    MatB_i[1][0] = 5; MatB_i[1][1] = 6; MatB_i[1][2] = 7; MatB_i[1][3] = 8;
    MatB_i[2][0] = 9; MatB_i[2][1] = 10; MatB_i[2][2] = 11; MatB_i[2][3] = 12;
    MatB_i[3][0] = 13; MatB_i[3][1] = 14; MatB_i[3][2] = 15; MatB_i[3][3] = 15;
    #10;
    rst_i = 0;

    // Wait for the systolic array to finish
    while (!done_o) begin
      #5;
    end

    // Print the result matrix
    $display("Result Matrix:");
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 4; j++) begin
        $write(resultMatrix_o[i][j], " ");
      end
      $display("");
    end
    $display("");

    // Check if done_o is asserted
    if (done_o) begin
      $display("Computation completed successfully.");
    end else begin
      $display("Computation failed.");
    end



    // End simulation
    $finish;
  end

endmodule
