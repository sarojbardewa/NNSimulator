/***************************************
 * ALU Execution Unit for NNDesign Project
 * PURPOSE: 
 *		It is a big part ALU Module
 *	May 19, 2016
  * Saroj Bardewa
********************************************/

module ALU_Parent(ALUResult, ALU1Control,ALU2Control,SrcA, SrcB, SrcC);
parameter nBits = 32;
input [nBits-1:0] SrcA,SrcB,SrcC;
input [2:0] ALU1Control;
input [2:0] ALU2Control;
output[nBits-1:0] ALUResult;

reg[nBits-1:0] ALUResult;

reg[nBits-1:0] ALUResult1;
 
always@(ALU1Control,ALU2Control) 
begin
	case(ALU1Control)
		3'b000:        //Add the data(add)
             ALUResult1 = SrcA+SrcB;
		3'b001:		 //Multiply the data (mul)
			 ALUResult1 = SrcA*SrcB; 
		3'b010:		// Set if non-negative
			 ALUResult1 = (SrcA>=SrcB) ? 32'b1:32'b0;   //Src A = -2; SrcB = R0 = 0; The SrcA<SrcB = 0
		3'b111:		// No nothing		
			 ALUResult1 = SrcA;   
			 
		default:   	
			ALUResult1 = 32'd0;
	endcase
	case(ALU2Control)
		3'b000:        //Add the data(add)
             ALUResult =  ALUResult1+SrcC;
		3'b001:		 //Multiply the data (mul)
			 ALUResult = ALUResult1*SrcC; 
		3'b010:		// Set if non-negative
			 ALUResult = (ALUResult1>=SrcC) ? 32'b1:32'b0;   //Src A = -2; SrcB = R0 = 0; The SrcA<SrcB = 0
		3'b111:		// No nothing		
			 ALUResult = ALUResult1;   
			 
		default:   	
			ALUResult = 32'd0;
	endcase
end
endmodule