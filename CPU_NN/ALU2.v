module ALU2(ALUResult,ALUResult1,ALU2Control,SrcC);
parameter 						nBits = 32;
input [nBits-1:0]				SrcC,ALUResult1; 
input [2:0] 					ALU2Control;
output reg signed [nBits-1:0] 	ALUResult;

always@(ALU2Control,ALUResult1,SrcC)
begin
case(ALU2Control)
		3'b000:        //Add the data(add)
             ALUResult =  ALUResult1+SrcC;
		3'b001:		 //Multiply the data (mul)
			 ALUResult = ALUResult1*SrcC; 
		3'b010:		// Set if non-negative
			 ALUResult = (ALUResult1>=SrcC) ? 32'b1:32'b0;   //Src A = -2; SrcB = R0 = 0; The SrcA<SrcB = 0
		3'b111:		// Assign input to the output	
			 ALUResult = ALUResult1;   
			 
		default:   	
			ALUResult = 32'd0;    //
	endcase
end
endmodule