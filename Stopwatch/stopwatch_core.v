module Stop_watch(clk, reset, state, digit, bcd, dp);

	input clk, reset;
	input state;	// PAUSE/RUNNING
	output reg  [7:0] digit;
	output reg [3:0] bcd;
	output reg dp;

	reg [3:0] centi_sec_L, centi_sec_H;
	reg [3:0] sec_L, sec_H;
	reg [3:0] min_L, min_H;
	reg [3:0] hour_L, hour_H;

localparam PAUSE = 1'd0;
localparam RUNNING = 1'd1;

clk_div_100	cd100(clk, reset, clk_100);
clk_div_1k	cd1k(clk, reset, clk_1k);

always @(posedge clk_1k or negedge reset) begin


	if(~reset) begin
		digit = 8'b1000_0000;
	end
	else begin
		digit = digit>>1;
		if(digit == 8'd0) begin
		 digit = 8'b1000_0000;
		end
	end
end

always @(posedge clk_100 or negedge reset) begin

	if(~reset) begin	//initial value setting
		centi_sec_L = 4'd0;
		centi_sec_H = 4'd0;
		sec_L = 4'd0;
		sec_H = 4'd0;
		min_L = 4'd0;
		min_H = 4'd0;
		hour_L = 4'd0;
		hour_H = 4'd0;
	end

	else begin
	case(state)
	RUNNING : begin	//Count up time
			centi_sec_L = centi_sec_L + 4'd1;
			
			if(centi_sec_L == 4'd10) begin
				centi_sec_L = 4'd0;
				centi_sec_H = centi_sec_H + 4'd1;
				if(centi_sec_H == 4'd10) begin
					centi_sec_H = 4'd0;
					sec_L = sec_L + 4'd1;
				end
			end
		
			else if(sec_L == 4'd10) begin
				sec_L = 4'd0;
				sec_H = sec_H + 4'd1;
				if(sec_H == 4'd6) begin
					sec_H = 4'd0;
					min_L = min_L + 4'd1;
				end
			end

			else if(min_L == 4'd10) begin
				min_L = 4'd0;
				min_H = min_H + 4'd1;
				if(min_H == 4'd6) begin
					min_H = 4'd0;
					hour_L = hour_L + 4'd1;
				end
			end

			else if(hour_L == 4'd10) begin
				hour_L = 4'd0;
				hour_H = hour_H + 4'd1;
				if(hour_H == 4'd10) begin
					hour_H = 4'd0;
				end
			end
		end
	PAUSE : begin	//Pause & Restart
		end
	endcase
	end
end

always @(*) begin

case (digit)
	8'b1000_0000	: begin bcd = hour_H; dp = 1'b0; end //Hour
	8'b0100_0000	: begin bcd = hour_L; dp = 1'b1; end //Hour.
	8'b0010_0000	: begin bcd = min_H; dp = 1'b0; end //Min
	8'b0001_0000	: begin bcd = min_L; dp = 1'b1; end //Min.
	8'b0000_1000	: begin bcd = sec_H; dp = 1'b0; end //Sec
	8'b0000_0100	: begin bcd = sec_L; dp = 1'b1; end //Sec.
	8'b0000_0010	: begin bcd = centi_sec_H; dp = 1'b0; end //centi_sec
	8'b0000_0001	: begin bcd = centi_sec_L; dp = 1'b1; end //centi_sec.
	default		: begin bcd = 4'd0; dp = 1'd0; end
endcase

end

endmodule

module state_switch(d_pause, state);

	input d_pause;
	output reg state = 0;

always @(posedge d_pause) begin
	state = ~state;
end

endmodule
