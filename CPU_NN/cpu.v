module cpu(CLK);
	parameter BUS_WIDTH=32;
	input CLK;
	
	// Cycle counter
	reg[BUS_WIDTH-1:0] CLK_cycle;

	// IF variables
	wire [BUS_WIDTH-1:0] PCplus1;
	reg [BUS_WIDTH-1:0] F_PC;
	wire [BUS_WIDTH-1:0]Instr;
	reg PCEn;
	reg [BUS_WIDTH-1:0] InstrD;
	
		
	//IF initial
	initial begin
		F_PC = 0;
		CLK_cycle = 0;
	end

//Instantiate Instruction Memory
	instructionMemory IM1 (F_PC,Instr);
	
	always@(posedge CLK)
		CLK_cycle = CLK_cycle + 1;
	
	always@(posedge CLK)
		begin 
			InstrD = Instr;
		end
	always @(Instr)
		begin
			$display(" Cycle: %d, PC: %d, Instr: %h, InstrD: %h", CLK_cycle,F_PC,Instr,InstrD);
			PCEn = 1;
		end
		
				
	always@(posedge CLK)
		begin
			if(PCEn)
				F_PC = F_PC+1;
		end
	
	// IF Pipeline register
	
endmodule