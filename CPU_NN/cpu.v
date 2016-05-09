module cpu(CLK);
	parameter BUS_WIDTH=32;
	input CLK;
	
	// Cycle counter
	reg[BUS_WIDTH-1:0] CLK_cycle;

	// IF variables
	wire [BUS_WIDTH-1:0] PCplus1;
	reg [BUS_WIDTH-1:0] F_PC;
	reg [BUS_WIDTH-1:0]Instr;
	reg PCEn;
	reg [BUS_WIDTH-1:0] InstrD;
	
		
	//Instantiate Instruction Memory
	instructionMemory IM1 (F_PC,Instr);
	
	//IF initial
	initial begin
		F_PC = 0;
		CLK_cycle = 0;
		PCEn = 1;	
		Instr = 0;
	end

	assign PCplus1 = F_PC +1;
	always@(posedge CLK)
		begin
			CLK_cycle = CLK_cycle + 1;
			
			if(PCEn && ~Instr)
				F_PC = 0;
			else if (PCEn)
				F_PC = PCplus1;
			else
				$display(" Must be an error!");
		end

	// IF Pipeline register
	always@(posedge CLK)
		begin 
			InstrD = Instr;
			$display(" Cycle: %d, PC: %d, Instr: %h, InstrD: %h", CLK_cycle,F_PC,Instr,InstrD);
		end
			
endmodule
