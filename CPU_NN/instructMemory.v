/* PURPOSE: This is the module that contains memory image in hex formate
 * 			 The memory can be accessed depending on the PC value 
 * INPUT	: PC address
 * OUTPUT	: Instruction at the memory location
 * Saroj Bardewa
 * ECE 586
 */

module instructionMemory(PC,Instr);
	parameter OUT_BUS_WIDTH	=32;   			// Output Bus Width
	parameter IN_BUS_WIDTH	=32;				// Input Bus Width
	parameter MEMORY_WIDTH	=32;				//2**IN_BUS_WIDTH; // Size of memory bank. Depends on locations 
	parameter ADDRESS_SIZE	= 2**16;								    	// that can be referenced by a Program Counter

	input[IN_BUS_WIDTH-1:0] PC;			//input PC 
	output reg [OUT_BUS_WIDTH-1:0] Instr;	// Hex memory

	reg[MEMORY_WIDTH-1:0] instrctMemoryBank[0:ADDRESS_SIZE-1]; //32 bits 2^16 registers

	initial
		begin
			$readmemh("memoryImage.txt",instrctMemoryBank);  //Read Memory Image
		end

	always@(PC)
		begin
			Instr = instrctMemoryBank[PC];  // Read PC = 0 --> first eight bits
		end
endmodule