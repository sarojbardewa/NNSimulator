/* Testbench of ALU Exectuion Unit.
 * Saroj & Conor
 * May 1st, 2016
 */ 

module alutest();
parameter nBits=32;
reg[nBits-1:0] SrcA, SrcB;
reg [2:0] ALUControl;
wire[nBits-1:0] ALUResult;


ALU ALU1(ALUResult, ALUControl,SrcA, SrcB);

initial
begin
	 ALUControl=3'b000;	SrcA = 32'd0;	SrcB = 32'd1;  	//ADD : SrcA+SrcB = 0 + 1 = 1
#10 ALUControl=3'b000;	SrcA = 32'd0;	SrcB = -32'd1;  //ADD : SrcA+SrcB = 0 + (-1) = -1
#10 ALUControl=3'b001;	SrcA = 32'd0;	SrcB = 32'd1;  	//MUL : SrcA+SrcB = 0 * 1 = 0
#10 ALUControl=3'b001;	SrcA = 32'd1;	SrcB = 32'd1;  	//MUL : SrcA+SrcB = 1 * 1 = 1
#10 ALUControl=3'b001;	SrcA = 32'd1;	SrcB = -32'd1;  //MUL : SrcA+SrcB = 1 * (-1) = -1
#10 ALUControl=3'b010;	SrcA = 32'd1;	SrcB = 32'd0;   //SLT : SrcA<SrcB = 1 < 0 = 0;
#10 ALUControl=3'b010;	SrcA = -32'd1;	SrcB = 32'd0;   //SLT : SrcA<SrcB = -1 < 0 = 1;
#100 $finish();
end
endmodule
