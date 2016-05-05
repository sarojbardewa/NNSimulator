/******************************
 * PURPOSE: Load and store of data
 *			takes place on Data Memory
 *			It is used for I-type of instruction.
 *	INPUTS: Clock, Memory Write Enable, ALU Memory Address,
 *			Write Data
 *	OUTPUT: Stored Data
 *  AUTHOR: Saroj Bardewa
 *******************************/
 
 // readEn is added, which controls reading of data from the module.. This control signal
 // is determined by Control Unit when load instruction is used
 
 module dataMemory(CLK,writeEn,readEn,ALUMemAdd,writeDataM,readDataW);
	parameter IN_BUS_WIDTH=32;
	parameter MEMORY_WIDTH=32;				// Bits of Memory accessed at a time 
	parameter ADDRESS_SIZE=1024; // Size of memory bank. Depends on locations 
											// that can be referenced by a Address size
	
	input 	CLK, writeEn,readEn;
	input 	[IN_BUS_WIDTH-1:0] ALUMemAdd;
	input 	[MEMORY_WIDTH-1:0] writeDataM;  // 32bit data value
	output reg 	[MEMORY_WIDTH-1:0] readDataW;
	

	/* At positive clock edge, if there is write enable, the module latches in the data
	 * specified by the ALU memory address. If it is load, then the module reads out the 
	 * value stored at the particular register specified by the input address */
	
	reg[MEMORY_WIDTH-1:0] dataMemoryBank[ADDRESS_SIZE-1:0]; //32 bits 1024 registers QUESTION-Size of memory??

	initial
		begin
			$readmemh("dataMemoryFile.txt",dataMemoryBank);  //Read Memory Image
			
			$display("Init Read %d f ",dataMemoryBank[1],ALUMemAdd);
			$display("Init Read %d from the Address: %d",dataMemoryBank[3],ALUMemAdd);
			$display("Init Read %d from the Address: %d",dataMemoryBank[5],ALUMemAdd);
		end
	
	//Write Data is clock synchronous
	always@(posedge CLK,ALUMemAdd,writeEn,writeDataM,readEn)
		begin
			if(writeEn)
				begin
					dataMemoryBank[ALUMemAdd] <= writeDataM ;  // Read F_PC = 0 --> first eight bits
					$display("Wrote %d to the Address: %d",dataMemoryBank[ALUMemAdd],ALUMemAdd);
				end
			else if(readEn)
				begin
					readDataW <= dataMemoryBank[ALUMemAdd];  //Read from an address and output the data
					$display("Read %d from the Address: %d",readDataW,ALUMemAdd);
				end
			else
				$display("No Memory Access!");
			end

endmodule
	

