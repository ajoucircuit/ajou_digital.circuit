`timescale 1ns/1ns

module tb_cd100();

	reg clk = 0;
	reg reset = 1;
	wire clk_100;

	clk_div_100 clk100 (clk, reset, clk_100);
	
	always #5 clk = ~clk;

 initial begin
	#5820000	reset = 0;
	#112		reset = 1;
end

endmodule

module tb_cd1k();

	reg clk = 0;
	reg reset = 1;
	wire clk_1k;

	clk_div_1k clk1k (clk, reset, clk_1k);
	
	always #5 clk = ~clk;

 initial begin
	#582000	reset = 0;
	#112	reset = 1;
end

endmodule

