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
 
 module dataMemory(CLK,writeEn,ALUMemAdd,writeDataM,readDataW);
	//parameter DATA_BASE_ADD = 5;		// Starting data base address
	parameter OUTPUT_FILE_SIZE = 4100;         // Depends on the number of output to write
	parameter IN_BUS_WIDTH=32;
	parameter MEMORY_WIDTH=32;				// Bits of Memory accessed at a time 
	parameter ADDRESS_SIZE=2**16; 				// Size of memory bank
										   // that can be referenced by a Address size
	integer file;
	input 	CLK, writeEn;
	input 	[IN_BUS_WIDTH-1:0] ALUMemAdd;
	input 	[MEMORY_WIDTH-1:0] writeDataM;  // 32bit data value
	output wire [MEMORY_WIDTH-1:0] readDataW;
	

	/* At positive clock edge, if there is write enable, the module latches in the data
	 * specified by the ALU memory address. If it is load, then the module reads out the 
	 * value stored at the particular register specified by the input address */
	
	reg signed [MEMORY_WIDTH-1:0] dataMemoryBank[0:ADDRESS_SIZE-1]; //#of locations = ADDRESS_SIZE each with MEMORY_WIDTH size
	reg signed [MEMORY_WIDTH-1:0] outputMemoryBank[0:OUTPUT_FILE_SIZE-1];
	
	initial	$readmemh("memoryImage.txt",dataMemoryBank);    //Read Memory Image
	initial file = $fopen("outputMemoryImage.txt","w"); 	// Initially the file is empty
	
	assign readDataW = dataMemoryBank[ALUMemAdd]; //+DATA_BASE_ADD];  //Read from an address and output the data
	//Write Data is clock synchronous
	always@(posedge CLK)
		begin
			if(writeEn)
				begin
					outputMemoryBank[ALUMemAdd] = writeDataM ;  // Read F_PC = 0 --> first eight bits
					$fdisplay(file,"%08x",outputMemoryBank[ALUMemAdd]);  // Write the value to the file
				end
		end
		
endmodule
	

