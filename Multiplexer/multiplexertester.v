/* PURPOSE: Test bed for multiplexer
 * INPUT: None
 * OUTPUT: None
 * Conor O'Connell
 * 5/5/2016
 */
module muxtester();
  reg [31:0] in0;
  reg [31:0] in1;
  reg select;
  wire [31:0] out;

  mux32x2 mux_1(in0, in1, select, out);
  
  initial 
    begin
      in0 = 'hFFFFFFFF;
      in1 = 'h01234567;
      select = 0;
      #2
      in0 = 'hBBBB0000;
      #2
      select = 1;
      #2
      in1 = 'hABCDEF00;
      #2
      select = 0;
    end
endmodule