module SystolicArray #(parameter N = 4)(
  input wire clk_i, rst_i,

  input wire [3:0] MatA_i [N][N],
  input wire [3:0] MatB_i [N][N],

  output reg [3:0] resultMatrix_o [N][N],
  output reg done_o = 0
);


reg [4:0] counter = 0;
reg [3:0] col_start[0:N];
reg [3:0] row_start[0:N];

wire [3:0] resultMatrix_wires[0:N][0:N];

wire [3:0] col_wire[0:N][0:N];
wire [3:0] row_wire[0:N][0:N];

reg [3:0] col_reg [0:N][0:N];
reg [3:0] row_reg [0:N][0:N];

generate
  for (genvar i=0; i<N; i++) begin : edges_init
      assign col_wire[0][i] = col_start[i];
      assign row_wire[i][0] = row_start[i];
    end
endgenerate

generate
  for (genvar i=0; i<N; i++) begin : rows
    for (genvar j=0; j<N; j++) begin : cols
      PE pe(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .top_i(col_reg[i][j]),
        .left_i(row_reg[i][j]),
        .bottom_o(col_wire[i+1][j]),
        .right_o(row_wire[i][j+1]),
        .accum_i(resultMatrix_o[i][j]),
        .accum_o(resultMatrix_wires[i][j])
      );
    end
  end
endgenerate 



always@(posedge clk_i) begin
  for (int i=0; i<N; i++) begin
    for (int j=0; j<N; j++) begin
      resultMatrix_o[i][j] = (rst_i) ? 0 : resultMatrix_wires[i][j];
      col_reg[i][j] = (rst_i) ? 0 : col_wire[i][j];
      row_reg[i][j] = (rst_i) ? 0 :  row_wire[i][j];
    end
  end
end



always_comb begin

  for (int i=0; i<N; i++) begin :init
    if (i <= counter && counter < N+i) begin
      row_start[i] = MatA_i[i][counter-i];
      col_start[i] = MatB_i[counter-i][i];
    end
    else begin
      row_start[i] = 4'd0;
      col_start[i] = 4'd0;
    end
  end


end


always @(posedge clk_i or posedge rst_i) begin

  if (rst_i) begin
    counter <= 0;
    done_o <= 0;
  end else begin


`ifdef DEBUG
    
    $display("");
    $display("counter = %0d", counter);
    $display("resultMatrix:");
    for (int i=0;i<N;i++) begin
      for (int j=0;j<N;j++) begin
        $write(resultMatrix_o[i][j] , " ");
      end
      $display("");
    end

    $display("col_wire",);
    for (int i=0;i<N;i++) begin
      for (int j=0;j<N;j++) begin
        $write(col_wire[i][j] , " ");
      end
      $display("");
    end
    $display("row_wire",);
    for (int i=0;i<N;i++) begin
      for (int j=0;j<N;j++) begin
        $write(row_wire[i][j] , " ");
      end
      $display("");
    end
`endif
    
    counter = counter + 1;
    if (counter == 3*N-1) begin
      done_o = 1;
      counter = 0;		
    end
    else 
      done_o = 0;
  end
end






endmodule