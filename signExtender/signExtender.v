/*********************************
* Sign Extender unit for NNsimulator project
* ECE 486 (computer architecture) final project
*  PURPOSE: 
*          This module sign extends inputs (usually immediate values) up to the size
*          expected by the ALU (32 bits, in our case).
* May 3rd, 2016
* Conor O'Connell & Saroj Bardewa 
**********************************/

//http://stackoverflow.com/questions/4176556/how-to-sign-extend-a-number-in-verilog

module signEx( clk, valin, extended );
parameter size_in = 16;
parameter size_out = 32;

input clk;
input [size_in - 1:0] valin;
output [size_out - 1:0] extended;

wire [size_in - 1:0] valin;
reg [size_out - 1:0] extended;

always @(posedge clk) begin
  extended[size_out - 1:0] <= { {( size_out - size_in ){valin[size_in-1]}}, valin[size_in-1:0] };
end

endmodule