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
	reg PCEn;
	reg [BUS_WIDTH-1:0] InstrD;
	
		
	//IF initial
	initial begin
		PC = 0;
		CLK_cycle = 0;
		PCEn = 0; 
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
			PCEn = 1;
		end
		
				
	always@(posedge CLK)
		begin
			if(PCEn)
				PC = PC+1;
		end
	
	// IF Pipeline register
	
	
	//--------------------------------------------
	// Instruction Decode
	wire [IMMEDIATE-1:0] valin;
	wire [REGISTER-1:0] A1;
	wire [REGISTER-1:0] A2;
	wire [REGISTER-1:0] A3;
	wire [REGISTER-1:0] A4;
	wire [BUS_WIDTH-1:0] WD3;
	wire [REGISTER-1:0] WriteDstReg;
	wire [OPCODE-1:0] OP;
	
	// Register Files Input and output
	wire RegWrite; 					//Write Enable Wire
	wire [BUS_WIDTH-1:0]Src1AD;
	wire [BUS_WIDTH-1:0]Src1BD;
	wire [BUS_WIDTH-1:0]Src1CD;
	
	//Sign Extend
	wire [BUS_WIDTH-1:0] SignImmD;
	wire [IMMEDIATE-1:0] SignImmIn;
	
	//Control Unit
	wire RegWriteD;
	wire ALU1SrcD;
	wire RegDstD;
	wire [ALU_FUNCT_BITS-1:0]ALU1CntrlD;
	wire [ALU_FUNCT_BITS-1:0]ALU2CntrlD;
	wire MemWriteD;
	wire MemReadD;
	wire MemtoRegD;
	wire PCEnD;
	
	//Execute Unit
	wire [REGISTER-1:0] writeDstReg;
	
	//Assign statements
	assign OP = InstrD[31:28];
	assign A1 = InstrD[27:22];
	assign A2 = InstrD[21:16];
	assign A3 = InstrD[15:10];
	assign A4 = writeDstReg;
	assign SignImmIn = InstrD[IMMEDIATE-1:0];
	
	// Control Unit
	
	// Instantiate Register File
	regfile ArtNNRegisterUnit(.clk(CLK),.writeEnable(RegWrite),.wrAddr(A4),.wrData(WD3),
					  .rdAddrA(A1),.rdDataA(Src1AD),.rdAddrB(A2),.rdDataB(Src1BD),
					  .rdAddrC(A3),.rdDataC(Src1CD));
	
	
	// sign extended
	signEx ArtNNSignExtUnit(.clk(CLK),.valin(SignImmIn),.extended(SignImmD));
	
	//Control Unit
	controlUnit ArtNNControlUnit(.opcode(OP), .RegWrite(RegWriteD), .MemtoReg(MemtoRegD), .MemWrite(MemWriteD), .ALUControl1(ALU1CntrlD),
                .ALUControl2(ALU2CntrlD), .ALUSrc(ALU1SrcD),.RegDst(RegDstD),.PCEn(PCEnD));
	
endmodule

