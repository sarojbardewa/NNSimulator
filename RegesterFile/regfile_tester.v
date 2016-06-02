/* PURPOSE: Test bed for regfile
 * INPUT: None
 * OUTPUT: None
 * Conor O'Connell
 */

module regfiletester();

parameter NUM_ADDR_BITS = 6;
parameter REG_WIDTH = 32;

reg clk;
reg writeEnable;
reg [NUM_ADDR_BITS - 1:0] wrAddr;
reg [REG_WIDTH - 1:0] wrData;
reg [NUM_ADDR_BITS - 1:0] rdAddrA;
reg [NUM_ADDR_BITS - 1:0] rdAddrB;
reg [NUM_ADDR_BITS - 1:0] rdAddrC;
wire [REG_WIDTH - 1:0] rdDataA;
wire [REG_WIDTH - 1:0] rdDataB;
wire [REG_WIDTH - 1:0] rdDataC;

wire [REG_WIDTH - 1:0] rdDataA2;
wire [REG_WIDTH - 1:0] rdDataB2;
wire [REG_WIDTH - 1:0] rdDataC2;

reg [REG_WIDTH - 1:0] rdDataAbuf;
reg [REG_WIDTH - 1:0] rdDataBbuf;
reg [REG_WIDTH - 1:0] rdDataCbuf;

regfile RF_1( clk,  writeEnable, wrAddr, wrData, rdAddrA, rdDataA, rdAddrB, rdDataB, rdAddrC, rdDataC);

regfile RF_2( clk,  writeEnable, wrAddr, wrData, rdAddrA, rdDataA2, rdAddrB, rdDataB2, rdAddrC, rdDataC2);

always @(negedge clk)
  begin
    rdDataAbuf <= rdDataA2;
    rdDataBbuf <= rdDataB2;
    rdDataCbuf <= rdDataC2;
  end

initial
repeat (50) 
  begin
    #2 clk = !clk;
  end
 
initial 
  begin
    #1
    clk = 0;
    writeEnable = 'b1;
    wrAddr = 'h1;
    wrData = 'h14578BB0;
    #4
    writeEnable = 'b0;
    wrAddr = 'h2;
    wrData = 'h00000001;
    rdAddrA = 'h1;
    rdAddrC = 'h1;
    #4
    writeEnable = 'b1;
    wrAddr = 'h2;
    wrData = 'hFFFFFFFF;
    rdAddrA = 'h1;
    rdAddrB = 'h2;
    #4
    writeEnable = 'b1;
    wrAddr = 'h0;
    wrData = 'h88888888;
    rdAddrA = 'h3F;
    rdAddrB = 'h2;
    #4
    writeEnable = 'b1;
    wrAddr = 'h3F;
    wrData = 'h1;
    rdAddrA = 'h3F;
    rdAddrB = 'h0;
    #4
    writeEnable = 'b1;
    wrAddr = 'h0;
    wrData = 'hDDDDDDDD;
    rdAddrA = 'h3F;
    rdAddrB = 'h2;
    rdAddrC = 'h3F;
    #12
    $finish();
  end

endmodule