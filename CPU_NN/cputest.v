module cpuTest;
	reg CLK;
	
		// Get a cpu abstraction
	cpu CPUA1 (CLK);
	initial CLK = 0;
	always 
		begin
			CLK= ~CLK;
			#10;
		end
	
endmodule
