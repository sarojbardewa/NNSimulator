/* PURPOSE: This is a multiplexer. If select is 0, output is input0. If select is 1, output is input 1. 
 * INPUTS : input 0, input 1, select bit, 
 * OUTPUTS: output
 * Conor O'Connell & Saroj Bardewa
 * 5/5/2016
 */
 
module mux32x2_6bits(in0, in1, select, out);
  parameter WIDTH = 6;
  
  input [WIDTH - 1:0] in1;
  input [WIDTH - 1:0] in0;
  input select;
  output [WIDTH - 1:0] out;
  
  assign out = select ? in1 : in0;
endmodule

