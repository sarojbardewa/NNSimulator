/* Test Bench for Sign extender unit
* Conor & Saroj
* May 3rd, 2016
*/

module signExtenderTest();
reg clk;
reg [9:0] valin;
wire [31:0] extended;

signEx extenderTest( clk, valin, extended);

initial
begin
      clk = 0;
      valin = 10'b1000000000;
  #10 valin = 10'b0000000001;
  #10 valin = 10'b1001100010;
  #10 valin = 10'b0111111111;
  #10 valin = 10'b1010101110;
  #10 valin = 10'b0000010000;
  #10 valin = 10'b1111111111;
  #20 $finish();
end
    
always begin
  #2  clk = ~clk;
end
endmodule