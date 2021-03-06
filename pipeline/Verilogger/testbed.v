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
  //TODO: relitive path was not working, so I used an absolute path. should fix eventually.
    if (data_file == `NULL) begin  //error checking block.
      $display("data_file handle was NULL");
      $finish;
    end
  end
  
  always  #  1 clk = ~clk; 
  //set up clock. current setup has no timestep, so everything is simulated takes place "instantaneously"
  
  always @(posedge clk) begin
  scan_file = $fscanf(data_file, "%h\n", captured_data); //open file
    if (!$feof(data_file)) begin //loop untill end of file
      $display("captured_data = %h", captured_data); //display hex value from current line in file
      //TODO: Known bug: not seeing value of final line? why? need to test more.
    end
  end
  
endmodule

