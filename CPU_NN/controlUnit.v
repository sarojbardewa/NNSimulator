/* PURPOSE: generates the correct control signals from the opcode.
 * INPUT : 
 * OUTPUT: 
 * Conor O'Connell
 * 5/6/2016
 */
module controlUnit(opcode, RegWrite, MemtoReg, MemWrite, ALUControl1, //don't need branch
                    ALUControl2, ALUSrc, RegDst,PCEn);

input [3:0] opcode;
output PCEn;
output RegWrite;
output MemtoReg;
output MemWrite;
output [2:0] ALUControl1;
output [2:0] ALUControl2;
output ALUSrc;
output RegDst;

reg RegWrite;
reg MemtoReg;
reg MemWrite;
reg [2:0] ALUControl1;
reg [2:0] ALUControl2;
reg ALUSrc;
reg RegDst;
reg PCEn;

always @(opcode)
case (opcode)
  4'b0000 : //NOP
  begin
        RegWrite = 0;
        MemtoReg = 0;
        MemWrite = 0;
        ALUControl1 = 'b111;
        ALUControl2 = 'b111;
        ALUSrc = 0;
        RegDst = 0;
		PCEn = 1;
  end
  4'b0001 : //ADD
  begin
        RegWrite = 1;
        MemtoReg = 0;
        MemWrite = 0;
        ALUControl1 = 'b000;
        ALUControl2 = 'b111;
        ALUSrc = 0;
        RegDst = 0;
		PCEn = 1;
  end
  4'b1001 : //ADDI
  begin
        RegWrite = 1;
        MemtoReg = 0;
        MemWrite = 0;
        ALUControl1 = 'b000;
        ALUControl2 = 'b111;
        ALUSrc = 1;
        RegDst = 0;
		PCEn = 1;
  end
  4'b0010 : //MUL
  begin
        RegWrite = 1;
        MemtoReg = 0;
        MemWrite = 0;
        ALUControl1 = 'b001;
        ALUControl2 = 'b111;
        ALUSrc = 0;
        RegDst = 0;
		PCEn = 1;
  end
  4'b0011 : //SINN / SLT
  begin
        RegWrite = 1;
        MemtoReg = 0;
        MemWrite = 0;
        ALUControl1 = 'b010;//SLT
        ALUControl2 = 'b111;
        ALUSrc = 0;
        RegDst = 0;
		PCEn = 1;
  end
  4'b0100 : //MAC
  begin
        RegWrite = 1;
        MemtoReg = 0;
        MemWrite = 0;
        ALUControl1 = 'b001;//MUL
        ALUControl2 = 'b000;//ADD
        ALUSrc = 0;
        RegDst = 0;
		PCEn = 1;
  end
  4'b1110 : //LD
  begin
        RegWrite = 1; //I don't know what these values should be...
        MemtoReg = 1;
        MemWrite = 0;
        ALUControl1 = 'b000;//ADD, base + offset
        ALUControl2 = 'b111;
        ALUSrc = 0;
        RegDst = 0;
		PCEn = 1;
  end
  4'b1111 : //ST  
  begin
        RegWrite = 0;//I don't know what these values should be...
        MemtoReg = 0;
        MemWrite = 1;
        ALUControl1 = 'b000;//ADD, base + offset
        ALUControl2 = 'b111;
        ALUSrc = 0;
        RegDst = 0;
		PCEn = 1;
  end
  4'b1011 : //HALT
  begin
	PCEn = 0;   // Disable PC
    $finish();
	end
  default :$display("INVALID OPCODE ERROR"); 
endcase

/*
ENDNOTES: ALUSrc and RegDst need verification.
LD and ST also.
*/


endmodule