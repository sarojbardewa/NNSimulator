//testbed for pipeline

//more test

//even more

module printtest();
reg clk;
reg [31:0] a; //test val, DELETE
integer               data_file    ; // file handler
integer               scan_file    ; // file handler
reg [31:0] captured_data;
`define NULL 0    


  initial begin
  //test block, DELETE
  clk = 0;
  $display("=========STARTING SIMULATION=========");
  a = 'h084F;
  $display("a = %h", a);
 
 //http://stackoverflow.com/questions/16630319/how-to-read-a-text-file-line-by-line-in-verilog
  data_file = $fopen("N:\\NNsimulator\\NNSimulator\\pipeline\\Verilogger\\data_file.txt", "r");
  //WARNING: hardcoded absolute path, plz fix
    if (data_file == `NULL) begin
      $display("data_file handle was NULL");
      $finish;
    end
  end
  
always  #  1 clk = ~clk;
  
  always @(posedge clk) begin
  scan_file = $fscanf(data_file, "%h\n", captured_data); 
  if (!$feof(data_file)) begin
    $display("captured_data = %h", captured_data);
    //Known bug: not seeing value of final line? why? need to test more.
  end
end
endmodule

