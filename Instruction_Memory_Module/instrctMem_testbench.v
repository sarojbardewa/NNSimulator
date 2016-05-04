/* PURPOSE: This is the test bed for instructMemory Module
 * INPUT: None
 * OUTPUT: None
 
 * Saroj Bardewa
 */

module instructMem_Test();
parameter OUT_BUS_WIDTH=32;   			//Output Bus Width
parameter IN_BUS_WIDTH =16;				//Input Bus Width

reg[IN_BUS_WIDTH-1:0] F_PC;			//input PC 
wire[OUT_BUS_WIDTH-1:0] Instr;				// Hex memory

instructionMemory IM_1(F_PC,Instr);

initial 
	begin
		F_PC = 0;   // zeroth address
	#10	F_PC = 1;   // first address
	#10	F_PC = 2;
	#10	F_PC = 3;
	#10	F_PC = 6;   //Out of Order
	#20	F_PC = 1;   //Out of order
	#20	F_PC = 9;

	#20 $finish();
	end
endmodule