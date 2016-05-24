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

reg signed [nBits-1:0] ALUResult;

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
			 $display("Src A: %h, SrcB: %h \n", SrcA, SrcB);
			 ALUResult = SrcA[nBits-1]<=0; //If MSB is 1, know that is is negative  //{30'd0,~SrcA[nBits-1]}; //     (SrcA>=SrcB) ? 32'd0:32'd1;   //Src A = -2; SrcB = R0 = 0; The SrcA<SrcB = 0
			end
		3'b111:		// No nothing		
			 ALUResult = SrcA;   
			 
		default:   	
			ALUResult = 32'd0;
	endcase
	
end
endmodule

