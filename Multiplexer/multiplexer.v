/* PURPOSE: This is a multiplexer. If select is 0, output is input0. If select is 1, output is input 1. 
 * INPUTS : input 0, input 1, select bit, 
 * OUTPUTS: output
 * Conor O'Connell
 * 5/5/2016
 */
 
module mux32x2(in0, in1, select, out);
  parameter WIDTH = 32;
  
  input [WIDTH - 1:0] in1;
  input [WIDTH - 1:0] in0;
  input select;
  output [WIDTH - 1:0] out;
  
  assign out = select ? in1 : in0;
endmodule

module mux32x4(in0, in1, in2, in3, select, out);
  parameter WIDTH = 32;
  
  input [WIDTH - 1:0] in1;
  input [WIDTH - 1:0] in0;
  input [WIDTH - 1:0] in2;
  input [WIDTH - 1:0] in3;
  input [1:0] select;
  output [WIDTH - 1:0] out;
  
  wire [WIDTH - 1:0] level1Aout;
  wire [WIDTH - 1:0] level1Bout;
  
  mux32x2 level1A(in0, in1, select[0], level1Aout);
  mux32x2 level1B(in2, in3, select[0], level1Bout);
  
  
  mux32x2 level2(level1Aout, level1Bout, select[1], out);
endmodule