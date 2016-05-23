/* PURPOSE: This module simulates a three port register file (2 output and 1 input port).
*  INPUTS :Clock, write Enable, write address, write data, read address(port A), read address(port B)
*  OUTPUTS:Read data(port A), Read data(port B)
*  Conor O'Connell & Saroj Bardewa
*  ECE 486
*/

//http://courses.cs.washington.edu/courses/cse370/10sp/pdfs/lectures/regfile.txt


module regfile ( clk,  writeEnable, wrAddr, wrData, rdAddrA, rdDataA, rdAddrB, rdDataB, rdAddrC, rdDataC);
   parameter NUM_ADDR_BITS = 6;
   parameter REG_WIDTH = 32;
   parameter NUM_REGS = 2**NUM_ADDR_BITS;
   
   input clk;
   input writeEnable;
   input [NUM_ADDR_BITS - 1:0] wrAddr;
   input [REG_WIDTH - 1:0]     wrData;
   input [NUM_ADDR_BITS - 1:0] rdAddrA;
   output wire [REG_WIDTH - 1:0]    rdDataA;
   input [NUM_ADDR_BITS - 1:0] rdAddrB;
   output wire [REG_WIDTH - 1:0]    rdDataB;
   input [NUM_ADDR_BITS - 1:0] rdAddrC;
   output wire [REG_WIDTH - 1:0]    rdDataC;

   reg [REG_WIDTH - 1:0] 	 regfile [0:NUM_REGS - 1];

	
	// As soon as you supply address, read them! But, the value might not be written
	// yet! Hence we will have to have clock
   assign rdDataA = rdAddrA ? regfile[rdAddrA] : 32'h00000000;
   assign rdDataB = rdAddrB ? regfile[rdAddrB] : 32'h00000000;
   assign rdDataC = rdAddrC ? regfile[rdAddrC] : 32'h00000000; 
   
 /*  always @(posedge clk)
	assign
		begin
			 rdDataA <= rdAddrA ? regfile[rdAddrA] : 32'h00000000;
			 rdDataB <= rdAddrB ? regfile[rdAddrB] : 32'h00000000;
			 rdDataC <= rdAddrC ? regfile[rdAddrC] : 32'h00000000;
		end
*/
   always @(negedge clk)
   begin   					// Always write on the negative edge
      if (writeEnable) regfile[wrAddr] <= wrData;
   end
endmodule