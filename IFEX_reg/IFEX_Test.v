module IFIEtest();
	parameter BUS_WIDTH=32;
	parameter ALU_FUNCT_BITS = 3;  // For Alu operations
	parameter REGISTER = 6;	   // Size of Registers
	
	reg CLK;
	// Register Files Input and output
	reg [BUS_WIDTH-1:0]Src1AD;
	reg [BUS_WIDTH-1:0]Src1BD;
	reg [BUS_WIDTH-1:0]Src1CD;
	
	//Sign Extend
	reg [BUS_WIDTH-1:0] SignImmD;
	
	//Control Unit
	reg PCEnD;
	reg RegWriteD;
	reg ALU1SrcD;
	reg RegDstD;
	reg [ALU_FUNCT_BITS-1:0]ALU1CntrlD;
	reg [ALU_FUNCT_BITS-1:0]ALU2CntrlD;
	reg MemWriteD;
	reg MemReadD;
	reg MemtoRegD;
	
	//Write Reg
	reg [REGISTER-1:0] RtD;
	reg [REGISTER-1:0] RdD;
	
	
	// Register Files Input and output
	wire[BUS_WIDTH-1:0]Src1A;
	wire[BUS_WIDTH-1:0]Src1B;
	wire[BUS_WIDTH-1:0]Src1C;
	
	//Sign Extend
	wire  [BUS_WIDTH-1:0] SignImm;
	
	//Control Unit
	wire  PCEn;
	wire  RegWrite;
	wire  ALU1Src;
	wire  RegDst;
	wire  [ALU_FUNCT_BITS-1:0]ALU1Cntrl;
	wire  [ALU_FUNCT_BITS-1:0]ALU2Cntrl;
	wire  MemWrite;
	wire  MemRead;
	wire  MemtoReg;
	
	//Write Reg
	wire [REGISTER-1:0] Rt;
	wire [REGISTER-1:0] Rd;
	
	IFEX_Reg Test1(CLK,PCEnD,RegWriteD, ALU1SrcD, RegDstD,ALU1CntrlD, ALU2CntrlD,MemWriteD,MemReadD,MemtoRegD,Src1AD,Src1BD,Src1CD,RtD,RdD,SignImmD,
					PCEn,RegWrite,ALU1Src, RegDst,ALU1Cntrl, ALU2Cntrl,MemWrite,MemRead,MemtoReg,Src1A,Src1B,Src1C,Rt,Rd,SignImm);
					
	initial CLK = 0;
	
	always
	begin
		CLK = ~CLK;
		#10;
	end	
	
	initial
	begin
		PCEnD = 1;RegWriteD =1; ALU1SrcD = 0; RegDstD = 1;ALU1CntrlD = 1; ALU2CntrlD = 1;MemWriteD =1;
		MemReadD = 1;MemtoRegD = 0;Src1AD = 1;Src1BD = 0;Src1CD = 1;RtD = 1;RdD =1;SignImmD = 1;
	#10 PCEnD = 1;RegWriteD =1; ALU1SrcD = 0; RegDstD = 1;ALU1CntrlD = 1; ALU2CntrlD = 1;MemWriteD =1;
		MemReadD = 1;MemtoRegD = 0;Src1AD = 1;Src1BD = 0;Src1CD = 1;RtD = 1;RdD =1;SignImmD = 1;
	#10 PCEnD = 1;RegWriteD =1; ALU1SrcD = 0; RegDstD = 1;ALU1CntrlD = 1; ALU2CntrlD = 1;MemWriteD =1;
		MemReadD = 1;MemtoRegD = 0;Src1AD = 1;Src1BD = 0;Src1CD = 1;RtD = 1;RdD =1;SignImmD = 1;
	
	#20 $finish();
	end
endmodule