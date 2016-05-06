/* PURPOSE: Test bed for control unit
 * INPUT  : Opcode
 * OUTPUT : Regester Write, Memory to Register transfer, Memory Write, 
 *          Control for ALU1, Control for ALU2, ALU Select, Regester Destination
 * Conor O'Connell
 * 5/6/2016
 */
 
module controlUnitTester();

reg [3:0] opcode;
wire RegWrite;
wire MemtoReg;
wire MemWrite;
wire [2:0] ALUControl1;
wire [2:0] ALUControl2;
wire ALUSrc;
wire RegDst;

controlUnit CU_1(opcode, RegWrite, MemtoReg, MemWrite, ALUControl1, ALUControl2, ALUSrc, RegDst);

initial 
  begin
    opcode = 'h1;
    #4
    opcode = 'h2;
    #4
    opcode = 'h3;
    #4
    opcode = 'h4;
    #4    
    opcode = 'hE;
    #4
    opcode = 'hF;
    #4;
  end    
endmodule