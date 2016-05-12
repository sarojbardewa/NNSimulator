module IFID_Reg (CLK,Instr, InstrD);
	parameter NO_OF_BITS = 32;
	input CLK;
	input [NO_OF_BITS-1:0] Instr;
	output reg [NO_OF_BITS-1:0] InstrD;
	
	initial InstrD = 32'b0;
	
	always @(posedge CLK)
		 InstrD = Instr;
endmodule
	
	