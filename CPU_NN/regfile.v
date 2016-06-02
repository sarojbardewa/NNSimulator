/* PURPOSE: This module simulates a three port register file (2 output and 1 input port).
*  INPUTS :Clock, write Enable, write address, write data, read address(port A), read address(port B), read address(port C)
*  OUTPUTS:Read data(port A), Read data(port B), Read data(port B)
*  Conor O'Connell & Saroj Bardewa
*  ECE 486
*/

module regfile ( clk,  writeEnable, wrAddr, wrData, rdAddrA, rdDataA, rdAddrB, rdDataB, rdAddrC, rdDataC);
   parameter NUM_ADDR_BITS = 6;
   parameter REG_WIDTH = 32;
   parameter NUM_REGS = 2**NUM_ADDR_BITS;
   
   input clk;
   input writeEnable;
   input [NUM_ADDR_BITS - 1:0] 		wrAddr;      // Write Address	
   input [REG_WIDTH - 1:0]     		wrData;		 // Write Data
   input [NUM_ADDR_BITS - 1:0] 		rdAddrA;	 // Read Address 1
   output wire [REG_WIDTH - 1:0]    rdDataA;	 // Read Address 1 Data
   input [NUM_ADDR_BITS - 1:0] 		rdAddrB;     // Read Address 2
   output wire [REG_WIDTH - 1:0]    rdDataB;	 // Read Address 2 Data
   input [NUM_ADDR_BITS - 1:0] 		rdAddrC;	 // Read Address 3
   output wire [REG_WIDTH - 1:0]    rdDataC;	 // Read Address 3 Data

   //array of vectors
   reg signed [REG_WIDTH - 1:0]  	regfile [0:NUM_REGS - 1];


   initial 
      regfile[0] = 32'h00000000;
	
   //continuously assigned outputs
   assign rdDataA = rdAddrA ? regfile[rdAddrA] : 32'h00000000;
   assign rdDataB = rdAddrB ? regfile[rdAddrB] : 32'h00000000;
   assign rdDataC = rdAddrC ? regfile[rdAddrC] : 32'h00000000; 
   
   always @(negedge clk)
   begin   					// Always write on the negative edge
      if (writeEnable) regfile[wrAddr] <= wrData;
   end
endmodule