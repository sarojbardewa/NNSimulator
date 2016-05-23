module cpuTest;
	parameter BUS_WIDTH=32;
	reg CLK;
	wire [BUS_WIDTH-1:0] CLK_cycle;
		// Get a cpu abstraction
	cpu ArtNN_CPU(CLK,CLK_cycle);
	initial
		begin
		CLK = 0;
	end
	always 
		begin
			#20;
			CLK = ~CLK;
			
		end
	
	initial
		begin
		$monitor(" Time: %d, Cycle: %d", $time, CLK_cycle);
		end
endmodule
