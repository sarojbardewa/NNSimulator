/***************************************
 * ALU Execution Unit for NNDesign Project
 * PURPOSE: 
 *		It is a big part ALU Module
 *	May 19, 2016
  * Saroj Bardewa
********************************************/

module ALU1(ALUResult, ALU1Control,SrcA, SrcB);
parameter 				nBits = 32;
input [nBits-1:0] 		SrcA,SrcB;    // Inputs to the ALU
input [2:0] 			ALU1Control;  // Control Signals
output[nBits-1:0] 		ALUResult;	  // Result of ALU

reg signed [nBits-1:0] ALUResult;     // Set output as a register

always@(ALU1Control,SrcA,SrcB) 
begin
	case(ALU1Control)
		3'b000:        //Add the data(add)
             ALUResult = SrcA+SrcB;
		3'b001:		 //Multiply the data (mul)
			begin
				ALUResult = SrcA*SrcB; 
				
			end
		3'b010:		// Set if non-negative
			begin
				ALUResult = SrcA[nBits-1]<=0; //If MSB is 1, know that is is negative  
			end
		3'b111:		// No nothing		
			 ALUResult = SrcA;   
			 
		default:   	
			ALUResult = 32'd0;    // This stage should never occur
	endcase
	
end
endmodule

