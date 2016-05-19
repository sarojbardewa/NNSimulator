module cpuTest;
	parameter BUS_WIDTH=32;
	reg CLK;
	wire [BUS_WIDTH-1:0] CLK_cycle;
		// Get a cpu abstraction
	cpu ArtNN_CPU(CLK,CLK_cycle);
	initial CLK = 0;
	always 
		begin
			CLK = ~CLK;
			#20;
		end
	
	initial
		begin
		$monitor(" Time: %d, Cycle: %d", $time, CLK_cycle);
		end
endmodule
