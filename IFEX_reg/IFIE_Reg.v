module IFEX_Reg(CLK,PCEnD,RegWriteD, ALU1SrcD, RegDstD,ALU1CntrlD, ALU2CntrlD,MemWriteD,MemReadD,MemtoRegD,Src1AD,Src1BD,Src1CD,RtD,RdD,SignImmD,
					PCEn,RegWrite,ALU1Src, RegDst,ALU1Cntrl, ALU2Cntrl,MemWrite,MemRead,MemtoReg,Src1A,Src1B,Src1C,Rt,Rd,SignImm);

	parameter BUS_WIDTH=32;
	parameter ALU_FUNCT_BITS = 3;  // For Alu operations
	parameter REGISTER = 6;	   // Size of Registers
	
	// Register Files Input and output
	input CLK;
	input [BUS_WIDTH-1:0]Src1AD;
	input [BUS_WIDTH-1:0]Src1BD;
	input [BUS_WIDTH-1:0]Src1CD;
	
	//Sign Extend
	input [BUS_WIDTH-1:0] SignImmD;
	
	//Control Unit
	input PCEnD;
	input RegWriteD;
	input ALU1SrcD;
	input RegDstD;
	input [ALU_FUNCT_BITS-1:0]ALU1CntrlD;
	input [ALU_FUNCT_BITS-1:0]ALU2CntrlD;
	input MemWriteD;
	input MemReadD;
	input MemtoRegD;
	
	//Write Reg
	input [REGISTER-1:0] RtD;
	input [REGISTER-1:0] RdD;

	// Register Files Input and output
	output  reg [BUS_WIDTH-1:0]Src1A;
	output  reg [BUS_WIDTH-1:0]Src1B;
	output  reg [BUS_WIDTH-1:0]Src1C;
	
	//Sign Extend
	output  reg [BUS_WIDTH-1:0] SignImm;
	
	//Control Unit
	output  reg PCEn;
	output  reg RegWrite;
	output  reg ALU1Src;
	output  reg RegDst;
	output  reg [ALU_FUNCT_BITS-1:0]ALU1Cntrl;
	output  reg [ALU_FUNCT_BITS-1:0]ALU2Cntrl;
	output  reg MemWrite;
	output  reg MemRead;
	output  reg MemtoReg;
	
	//Write Reg
	output  reg [REGISTER-1:0] Rt;
	output  reg [REGISTER-1:0] Rd;
	
	initial PCEn = 0;
	
	always @(posedge CLK)
		begin
			PCEn		<= PCEnD;
			RegWrite 	<= RegWriteD;
			ALU1Src	    <= ALU1SrcD;
			RegDst 		<= RegDstD;
			ALU1Cntrl 	<= ALU1CntrlD;
			ALU2Cntrl	<= ALU2CntrlD;
			MemWrite	<= MemWriteD;
			MemRead		<= MemReadD;
			MemtoReg	<= MemtoRegD;
			Src1A		<= Src1AD;
			Src1B		<= Src1BD;
			Src1C		<= Src1CD;
			Rt			<= RtD;
			Rd			<= RdD;
			SignImm		<=SignImmD;
		end
endmodule
			
			
			
