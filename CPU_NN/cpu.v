module cpu(CLK);
	parameter BUS_WIDTH=32;
	parameter IMMEDIATE = 16;  // No of bits in immediate field
	parameter REGISTER = 6;	   // Size of Registers
	parameter OPCODE = 4; 	   // Size of OPCODE
	parameter ALU_FUNCT_BITS = 3;  // For Alu operations
	
	input CLK;
	
	// Cycle counter
	reg[BUS_WIDTH-1:0] CLK_cycle;

	// IF variables
	wire [BUS_WIDTH-1:0] PCplus1;
	reg [BUS_WIDTH-1:0] PC;
	wire [BUS_WIDTH-1:0]Instr;
//	reg PCEn;
	reg [BUS_WIDTH-1:0] InstrD;
//--------------------------------------------
	// Inputs to ID_EX Registers
	wire [IMMEDIATE-1:0] valin;
	wire [REGISTER-1:0] A1;
	wire [REGISTER-1:0] A2;
	wire [REGISTER-1:0] A3;
	wire [REGISTER-1:0] A4;
	wire [BUS_WIDTH-1:0] WD3;
	wire [REGISTER-1:0] WriteDstReg;
	wire [OPCODE-1:0] OP;
	
	// Register Files Input and output
	wire RegWriteD,RegWrite; 					//Write Enable Wire
	wire [BUS_WIDTH-1:0]Src1AD,Src1A;
	wire [BUS_WIDTH-1:0]Src1BD,Src1B;
	wire [BUS_WIDTH-1:0]Src1CD,Src1C;
	
	//Sign Extend
	wire [BUS_WIDTH-1:0] SignImmD,SignImm;
	wire [IMMEDIATE-1:0] SignImmIn;
	
	//Control Unit
	wire ALU1SrcD,ALU1Src;
	wire RegDstD,RegDst;
	wire [ALU_FUNCT_BITS-1:0]ALU1CntrlD,ALU1Cntrl;
	wire [ALU_FUNCT_BITS-1:0]ALU2CntrlD,ALU2Cntrl;
	wire MemWriteD,MemWrite;
	wire MemReadD,MemRead;
	wire MemtoRegD,MemtoReg;
	wire PCEnD,PCEn;
	wire [REGISTER-1:0]RtD,Rt;
	wire [REGISTER-1:0]RdD,Rd;
	
	//Execute Unit
	wire [REGISTER-1:0] writeDstReg;
	
	//Assign statements
	assign OP = InstrD[31:28];
	assign A1 = InstrD[27:22];
	assign A2 = InstrD[21:16];
	assign A3 = InstrD[15:10];
	assign A4 = writeDstReg;
	assign SignImmIn = InstrD[IMMEDIATE-1:0];
	assign RtD = InstrD[21:16];
	assign RdD = InstrD[15:10];

	//-------------------------------------------------------------
		
	//IF initial
	initial begin
		PC = 0;
		CLK_cycle = 0;
	//	PCEn = 0; 
	end

	//===========================================================================
	// Instruction Fetch
	//Instantiate Instruction Memory
	instructionMemory IM1 (PC,Instr);
	
	always@(posedge CLK)
		CLK_cycle = CLK_cycle + 1;
	
	always@(posedge CLK)
		begin 
			if(~PCEn)       		// If PC is not enabled, then insert a bubble
				InstrD = 32'b0;  // If PC is disabled insert a bubble
			else
				InstrD = Instr;
		end
	always @(Instr)
		begin
			$display(" Cycle: %d, PC: %d, Instr: %h, InstrD: %h", CLK_cycle,PC,Instr,InstrD);
		end
		
				
	always@(posedge CLK)
		begin
			if(PCEn)
				PC = PC+1;
		end
	
	// IF Pipeline register
	
	//Execution Unit
	wire [BUS_WIDTH-1:0]Src1B1;  //Output of ALUSrc Mux
	wire [BUS_WIDTH-1:0]ALUOut1, ALUOut2; //Output of ALU1
	wire [BUS_WIDTH-1:0] WriteData;
	wire [BUS_WIDTH-1:0] RdDataM;
	wire [BUS_WIDTH-1:0] Result;
	
	assign WriteData = Src1B;
	assign Result 	 = WD3;

	// Instantiate Register File
	regfile ArtNNRegisterUnit(.clk(CLK),.writeEnable(RegWrite),.wrAddr(A4),.wrData(WD3),
					  .rdAddrA(A1),.rdDataA(Src1AD),.rdAddrB(A2),.rdDataB(Src1BD),
					  .rdAddrC(A3),.rdDataC(Src1CD));
	
	
	// sign extended
	signEx ArtNNSignExtUnit(.clk(CLK),.valin(SignImmIn),.extended(SignImmD));
	
	//Control Unit
	controlUnit ArtNNControlUnit(.opcode(OP), .RegWrite(RegWriteD), .MemtoReg(MemtoRegD), .MemWrite(MemWriteD), .ALUControl1(ALU1CntrlD),
                .ALUControl2(ALU2CntrlD), .ALUSrc(ALU1SrcD),.RegDst(RegDstD),.PCEn(PCEnD),.MemRead(MemRead));
	
	// ID_EX Register
	IFEX_Reg ArtNNIFEXRegUnit(CLK,PCEnD,RegWriteD, ALU1SrcD, RegDstD,ALU1CntrlD, ALU2CntrlD,MemWriteD,MemReadD,MemtoRegD,Src1AD,Src1BD,Src1CD,RtD,RdD,SignImmD,
					PCEn,RegWrite,ALU1Src, RegDst,ALU1Cntrl, ALU2Cntrl,MemWrite,MemRead,MemtoReg,Src1A,Src1B,Src1C,Rt,Rd,SignImm);
	
	// 2 input mux to select write Destination Register
	mux32x2_6bits ArtNNMux_RegDest(.in0(Rt), .in1(Rd),.select(RegDst),.out(WriteDstReg));
	
	// 2 input mux to select ALU1 Source
	mux32x2 ArtNNMux_ALU1Src(.in0(Src1B), .in1(SignImm),.select(ALU1Src),.out(Src1B1));
	
	// ALU1
	ALU ALU1(.ALUResult(ALUOut1),.ALUControl(ALU1Cntrl),.SrcA(Src1A),.SrcB(Src1B));
	
	//ALU2
	ALU ALU2(.ALUResult(ALUOut2),.ALUControl(ALU2Cntrl),.SrcA(ALUOut1),.SrcB(Src1C));
	
	//Data Memory
	dataMemory ArtNN_DataMem(.CLK(CLK),.writeEn(MemWrite),.readEn(MemRead),.ALUMemAdd(ALUOut2),.writeDataM(WriteData),.readDataW(RdDataM));
	
	// 2 input Write Back Mux to select DataMemory or ALUOut2
	mux32x2 ArtNNMux_WB(.in0(RdDataM), .in1(ALUOut2),.select(MemtoReg),.out(Result));
endmodule

