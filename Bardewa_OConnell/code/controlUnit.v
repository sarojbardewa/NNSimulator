/* PURPOSE: generates the correct control signals from the opcode.
 * INPUT : opcode, 
 * OUTPUT: PCEn, RegWrite, MemtoReg, MemWrite, ALUControl1, ALUControl2, ALUSrc, RegDst, MemRead
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

initial PCEn = 1;

//outputs only need updating when opcode changes.
always @(opcode)
case (opcode)
  4'b0000 : //NOP
  begin
        RegWrite <= 0;
        MemtoReg <= 1;
        MemWrite <= 0;
        ALUControl1 <= 'b111;
        ALUControl2 <= 'b111;
        ALUSrc <= 0;
        RegDst <= 0;
        PCEn <= 1;
  end
  4'b0001 : //ADD
  begin
        RegWrite <= 1;
        MemtoReg <= 1;
        MemWrite <= 0;
        ALUControl1 <= 'b000;
        ALUControl2 <= 'b111;
        ALUSrc <= 0;
        RegDst <= 1;
        PCEn <= 1;
  end
  4'b1001 : //ADDI
  begin
        RegWrite <= 1;
        MemtoReg <= 1;
        MemWrite <= 0;
        ALUControl1 <= 'b000;
        ALUControl2 <= 'b111;
        ALUSrc <= 1;
        RegDst <= 0;
        PCEn <= 1;
  end
  4'b0010 : //MUL
  begin
        RegWrite <= 1;
        MemtoReg <= 1;
        MemWrite <= 0;
        ALUControl1 <= 'b001;
        ALUControl2 <= 'b111;
        ALUSrc <= 0;
        RegDst <= 1;
        PCEn <= 1;
  end
  4'b0011 : //SINN 
  begin
        RegWrite <= 1;
        MemtoReg <= 1;
        MemWrite <= 0;
        ALUControl1 <= 'b010;//SLT
        ALUControl2 <= 'b111; 
        ALUSrc <= 0;
        RegDst <= 1;
        PCEn <= 1;
  end
  4'b0100 : //MAC
  begin
        RegWrite <= 1;			// Select Rd
        MemtoReg <= 1;			// Select ALUOut2
        MemWrite <= 0;			// Nothing to write in memory = 0
        ALUControl1 <= 'b001;	// MUL
        ALUControl2 <= 'b000;	// ADD
        ALUSrc <= 0;			// Select from SrcB = 0
        RegDst <= 1;			// Select Rd = 1 for R-type instruction
        PCEn <= 1;				// Always enable PC
  end
  4'b1110 : //LD
  begin
        RegWrite <= 1; 			// Write to register
        MemtoReg <= 0; 			// Select From Data Memory
        MemWrite <= 0; 			// Don't Write to memory
        ALUControl1 <= 'b000; 	// ADD, base + offset
        ALUControl2 <= 'b111; 	// Noting to do for ALU2
        ALUSrc <= 1;     		// We add immediate values, so it should be 1
        RegDst <= 0;	 		// Select Rt for I-type instruction
        PCEn <= 1;				// Keep loading PC
  end
  4'b1111 : //ST  
  begin
        RegWrite <= 0;			// Don't write to register
        MemtoReg <= 0;			// It is arbitrary, does not matter (X)
        MemWrite <= 1;			// Write to memory = 1
        ALUControl1 <= 'b000;	// ADD, base + offset
        ALUControl2 <= 'b111;	// Nothing to do for ALU2
        ALUSrc <= 1;			// Select Immediate value
        RegDst <= 0;  			// Select Rt for I-type but does not matter here
        PCEn <= 1;    			// Always enable PC
  end
  4'b1011 : //HALT
  begin
   #20 $finish();
	end
  default :$display("INVALID OPCODE ERROR"); 
endcase


endmodule