/* PURPOSE: This is the module that contains memory image in hex formate
 * 			 The memory can be accessed depending on the PC value 
 * INPUT	: PC address
 * OUTPUT	: Instruction at the memory location
 * Saroj Bardewa
 * ECE 586
 */

module instructionMemory(F_PC,Instr);
	parameter OUT_BUS_WIDTH=32;   			// Output Bus Width
	parameter IN_BUS_WIDTH=32;				// Input Bus Width
	parameter MEMORY_WIDTH=32;				// Bits of Memory accessed at a time
	parameter ADDRESS_SIZE= 2**10;                //2**IN_BUS_WIDTH; // Size of memory bank. Depends on locations 
									    	// that can be referenced by a Program Counter

	input[IN_BUS_WIDTH-1:0] F_PC;			//input PC 
	output reg [OUT_BUS_WIDTH-1:0] Instr;	// Hex memory

	reg[MEMORY_WIDTH-1:0] instrctMemoryBank[0:ADDRESS_SIZE-1]; //32 bits 2^16 registers

	initial
		begin
			$readmemh("memoryImage.txt",instrctMemoryBank);  //Read Memory Image
		end

	always@(F_PC)
		begin
			Instr = instrctMemoryBank[F_PC];  // Read F_PC = 0 --> first eight bits
			//$display("PC: %d 	Instruction: %h",F_PC,Instr);
		end
endmodule