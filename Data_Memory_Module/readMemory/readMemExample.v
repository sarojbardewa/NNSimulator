module file_readmemh;
/* Declare an array 12 words deep and 32 locations wide */
reg[31:0] data[0:11];
initial $readmemh("dataMemoryFile.txt",data);
integer i;

initial begin
	$display("rdata : " );
	for(i=0;i<12;i=i+1)
		$display("%d: %h",i,data[i]);
end
endmodule
