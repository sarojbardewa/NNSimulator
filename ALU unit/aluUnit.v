/***************************************
 * ALU Execution Unit for NNDesign Project
 * PURPOSE: 
 *		This is the execution unit of NNSimulator.
 * 		It takes in two inputs and based on the control
 *		signals produces an output.
 *	May 1, 2016
  * Saroj Bardewa & Conor O'Connell
********************************************/

module ALU(ALUResult, ALUControl,SrcA, SrcB);
parameter nBits = 32;
input [nBits-1:0] SrcA,SrcB;
input [2:0] ALUControl;
output[nBits-1:0] ALUResult;

reg[nBits-1:0] ALUResult;


initial begin 
        ALUResult = 32'd0; 
end 

 always@(ALUControl,SrcA,SrcB) 
 begin
	case(ALUControl)
		3'b000:        //Add the data(add)
             ALUResult <= SrcA+SrcB;
		3'b001:		 //Multiply the data (mul)
			 ALUResult <= SrcA*SrcB; 
		3'b010:		//Set Greater Than (SGT) (Comparator)		
			 ALUResult <= (SrcA>=SrcB) ? 32'b1:32'b0;   //Src A = -2; SrcB = R0 = 0; The SrcA<SrcB = 0
		3'b111:		// No nothing		
			 ALUResult <= SrcA;   
			 
		default:   	
			ALUResult = 32'd0;
	endcase
end
endmodule