module clk_div_100(clk, reset, clk_100);	//clock divider 100Hz 100MHz
	input clk, reset;
	output reg clk_100=0;

reg [18:0] clk_cnt=0;

always @ (posedge clk)
	if(!reset) begin
		clk_100 <= 0;
		clk_cnt <= 0;
	end

	else begin 
		if(clk_cnt == 19'b111_1010_0001_0001_1111) begin	//19'd499999
			clk_100 <= ~ clk_100;
			clk_cnt <= 19'd0;
		end

		else begin
			clk_cnt <= clk_cnt+1;
		end
	end
endmodule

module clk_div_1k(clk, reset, clk_1k);	//clock dicider 1kHz from 100MHz
	input clk, reset;
	output reg clk_1k=0;

reg [15:0] clk_cnt=0;

always @ (posedge clk)
	if(!reset) begin
		clk_1k <= 0;
		clk_cnt <= 0;
	end

	else begin
		if(clk_cnt == 16'b1100_0011_0100_1111) begin	//16'd49999
			clk_1k <= ~ clk_1k;
			clk_cnt <= 15'd0;
		end

		else begin
			clk_cnt <= clk_cnt+1;
		end
	end
endmodule