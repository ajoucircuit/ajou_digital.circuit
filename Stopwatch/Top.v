module Control_sw(clk, reset, pause, digit, seg_data);	//Top module
	input clk, reset, pause;
	output [7:0] digit;
	output [7:0] seg_data;
	
	wire [6:0] seg;
	wire clk_100, clk_1k;
	wire d_pause;	// debouncing

	wire state;
	wire [3:0] bcd;
	wire dp;

debouncing deb_pause(clk, pause, d_pause);
state_switch(d_pause, state);
Stop_watch sw0(clk, reset, state, digit, bcd, dp);


bcd27seg	seg0(bcd, seg);

assign seg_data = {seg, dp};

endmodule
