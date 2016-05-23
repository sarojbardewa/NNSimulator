/***************************************
 * ALU Execution Unit for NNDesign Project
 * PURPOSE: 
 *		It is a big part ALU Module
 *	May 19, 2016
  * Saroj Bardewa
********************************************/

module ALU_Parent(ALUResult, ALU1Control,SrcA, SrcB);
parameter nBits = 32;
input [nBits-1:0] SrcA,SrcB;
input [2:0] ALU1Control;
output[nBits-1:0] ALUResult;

reg[nBits-1:0] ALUResult;

always@(ALU1Control,SrcA,SrcB) 
begin
	case(ALU1Control)
		3'b000:        //Add the data(add)
             ALUResult = SrcA+SrcB;
		3'b001:		 //Multiply the data (mul)
			 ALUResult = SrcA*SrcB; 
		3'b010:		// Set if non-negative
			 ALUResult = (SrcA>=SrcB) ? 32'b1:32'b0;   //Src A = -2; SrcB = R0 = 0; The SrcA<SrcB = 0
		3'b111:		// No nothing		
			 ALUResult = SrcA;   
			 
		default:   	
			ALUResult = 32'd0;
	endcase
	
end
endmodule

