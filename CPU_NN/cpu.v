/*****************************************************************
   This is 3-Stage Pipeline Neural Network Processor Module.
   It interconnects different modules together to form
   a processor.
   
   INPUT : Global clock 
   OUTPUT: Cycle counter value
   
   Author: Saroj Bardewa
   ECE586 Spring 2016
 ****************************************************************/
module cpu(CLK,CLK_cycle);
	parameter BUS_WIDTH=32;					// Width of the bus
	parameter IMMEDIATE = 16; 				// No of bits in immediate field
	parameter REGISTER = 6;	   				// Size of Registers
	parameter OPCODE = 4; 	   				// Size of OPCODE
	parameter ALU_FUNCT_BITS = 3;   		// For Alu operations
	
	input CLK;								// Global Clock
	
	// Cycle counter
	output reg [BUS_WIDTH-1:0] CLK_cycle;	

	// Instruction Fetch variables
	reg [BUS_WIDTH-1:0] PC;
	wire [BUS_WIDTH-1:0]Instr;
	reg [BUS_WIDTH-1:0] InstrD;

	// Register File inputs
	wire [REGISTER-1:0] 	A1;					//Register File input1
	wire [REGISTER-1:0] 	A2;					//Register File input2
	wire [REGISTER-1:0] 	A3;					//Register File input3
	wire [REGISTER-1:0] 	A4;					//Register File input4
	wire [BUS_WIDTH-1:0] 	WD;			        //Register File Write Data
	wire [REGISTER-1:0] 	WriteDstReg;		//Temporary Write Destination Register
	wire [OPCODE-1:0] 		OP;					//Control Unit Opcode
	
	//// Input and Output to Instruction Decode-Execute Pipeline Register
	wire RegWriteD,RegWrite; 					//Write Enable Wire
	wire [BUS_WIDTH-1:0]Src1AD,Src1A;			// Source-A into and out of pipeline register
	wire [BUS_WIDTH-1:0]Src1BD,Src1B;			// Source-B into and out of pipeline register
	wire [BUS_WIDTH-1:0]Src1CD,Src1C;			// Source-C into and out of pipeline register
	
	//Bit Field Extension
	wire [BUS_WIDTH-1:0] BitFieldImmD,BitFieldImm;    	//output of sign extend module and pipeline register
	wire [IMMEDIATE-1:0] BitFieldImmIn;					//Input to sign extend module
	
	//Control Unit
	wire ALU1SrcD,ALU1Src;								// ALU1 input1 
	wire RegDstD,RegDst;								// Register Destination into and out of pipeline register
	wire [ALU_FUNCT_BITS-1:0]ALU1CntrlD,ALU1Cntrl;		// ALU1 control into and out of pipeline register
	wire [ALU_FUNCT_BITS-1:0]ALU2CntrlD,ALU2Cntrl;		// ALU2 control into and out of pipeline register
	wire MemWriteD,MemWrite;							// Data memory write signal into and out of pipeline register
	wire MemtoRegD,MemtoReg;							// Register or Memory output select signal into and out of pipeline register
	wire PCEnD,PCEn;									// PC Enable signal into and out of pipeline register
	wire [REGISTER-1:0]RtD,Rt;							// Destination register for I-type instruction into and out of pipeline register
	wire [REGISTER-1:0]RdD,Rd;							// Destination register for R-type instruction into and out of pipeline register
	
	//Execution Unit
	wire [BUS_WIDTH-1:0]Src1B1;  						// Output of ALUSrc Mux
	wire [BUS_WIDTH-1:0]ALUOut1, ALUOut2; 				// Output of ALU1
	wire [BUS_WIDTH-1:0] WriteData;						// Data to write to data memory
	wire [BUS_WIDTH-1:0] RdDataM;						// Output of data memory
	wire [BUS_WIDTH-1:0] Result;						// Output of write back multiplexer

	//---------------------------------------------------------------------------//
	//IF initial
	initial begin
		PC = 0;
		CLK_cycle = 0;
	end

	//===========================================================================//
	// Instruction Fetch Unit
	//Instantiate Instruction Memory
	instructionMemory IM1 (PC,Instr);
	
	//Assign the Instruction bits into respective fields
	assign OP 	= InstrD[31:28];
	assign A1 	= InstrD[27:22];
	assign A2 	= InstrD[21:16];
	assign A3	 = InstrD[15:10];
	assign A4 	= WriteDstReg;
	assign RtD 	= InstrD[21:16];
	assign RdD 	= InstrD[15:10];
	assign WD   = Result;          	//Assign write back value to the register input
	assign WriteData = Src1B;
	
	assign BitFieldImmD  = InstrD[IMMEDIATE-1:0]; 

	//Update the global clock counter
	always@(posedge CLK)
		CLK_cycle = CLK_cycle + 1;

	//Update the program counter by 1
	always@(posedge CLK)
		begin
			if(PCEn)
				PC = PC+1;
		end
	
	always@(posedge CLK)
		begin 
				InstrD = Instr;
				
		end
	// Instantiate Register File
	regfile ArtNNRegisterUnit(.clk(CLK),.writeEnable(RegWrite),.wrAddr(A4),.wrData(WD),
					  .rdAddrA(A1),.rdDataA(Src1AD),.rdAddrB(A2),.rdDataB(Src1BD),
					  .rdAddrC(A3),.rdDataC(Src1CD));
	
	
	// Bit Field extended -16bits input and 32-bit output
	bitFieldExt ArtNNBitFieldExtUnit(.valin(BitFieldImmIn),.extended(BitFieldImmD));
	
	//Control Unit
	controlUnit ArtNNControlUnit(.opcode(OP), .RegWrite(RegWriteD), .MemtoReg(MemtoRegD), .MemWrite(MemWriteD), .ALUControl1(ALU1CntrlD),
                .ALUControl2(ALU2CntrlD), .ALUSrc(ALU1SrcD),.RegDst(RegDstD),.PCEn(PCEnD));
	
	// ID_EX Register
	IFEX_Reg ArtNNIFEXRegUnit(CLK,PCEnD,RegWriteD, ALU1SrcD, RegDstD,ALU1CntrlD, ALU2CntrlD,MemWriteD,MemtoRegD,Src1AD,Src1BD,Src1CD,RtD,RdD,BitFieldImmD,
					PCEn,RegWrite,ALU1Src, RegDst,ALU1Cntrl, ALU2Cntrl,MemWrite,MemtoReg,Src1A,Src1B,Src1C,Rt,Rd,BitFieldImm);
	
	// 2 input mux to select write Destination Register
	mux32x2_6bits ArtNNMux_RegDest(.in0(Rt), .in1(Rd),.select(RegDst),.out(WriteDstReg));
	
	// 2 input mux to select ALU1 Source
	mux32x2 ArtNNMux_ALU1Src(.in0(Src1B), .in1(BitFieldImm),.select(ALU1Src),.out(Src1B1));

	ALU_Parent ALU1(.ALUResult(ALUOut1),.ALU1Control(ALU1Cntrl),.SrcA(Src1A),.SrcB(Src1B1));
	
	ALU_Child ALU_Child1(.ALUResult(ALUOut2),.ALUResult1(ALUOut1),.ALU2Control(ALU2Cntrl),.SrcC(Src1C));
	//Data Memory
	dataMemory ArtNN_DataMem(.CLK(CLK),.writeEn(MemWrite),.ALUMemAdd(ALUOut2),.writeDataM(WriteData),.readDataW(RdDataM));
	
	// 2 input Write Back Mux to select DataMemory or ALUOut2
	mux32x2 ArtNNMux_WB(.in0(RdDataM), .in1(ALUOut2),.select(MemtoReg),.out(Result));
endmodule

