/* PURPOSE: Test bed for 32X4 multiplexer
 * INPUT: None
 * OUTPUT: None
 * Conor O'Connell
 * 5/5/2016
 */
 
 module muxX4tester();
  reg [31:0] in0;
  reg [31:0] in1;
  reg [31:0] in2;
  reg [31:0] in3;
  reg [1:0] select;
  wire [31:0] out;
  
  mux32x4 mux_2(in0, in1, in2, in3, select, out);
  
  initial 
    begin
      #2
      in0 = 0;
      in1 = 1;
      in2 = 2;
      in3 = 3;
      select = 'b00;
      #5
      select = 'b01;
      #5
      select = 'b10;
      #5
      select = 'b11;
      #5
      in3 = 'hFFFF8080;
      #5;
    end
endmodule