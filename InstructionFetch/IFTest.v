/*

*/

module IFTester();
wire [31:0] captured_data;
reg clk;

instructionFetch IFUnit(clk, captured_data);

initial begin
  clk = 0;
  #5 clk = 1;
  #5 clk = 0;
  #5 clk = 1;
  #5 clk = 0;
  #5 clk = 1;
  #5 clk = 0;
  #5 clk = 1;
  #5 clk = 0;
  #5 clk = 1;
  #5 clk = 0;
  #5 clk = 1;
  #5 clk = 0;
  #5 clk = 1;
  #5 clk = 0;
  #5 clk = 1;
  #5 clk = 0;
  #5 clk = 1;
  #5 clk = 0;
  #5 clk = 1;
  #5 clk = 0;
  #5 clk = 1;
  #5 clk = 0;
  #5 clk = 1;
  #5 clk = 0;
  #5 clk = 1;
  #5 clk = 0;
  #5 clk = 1;
  #5 clk = 0;
  #5 clk = 1;
  #5 clk = 0;
end

endmodule