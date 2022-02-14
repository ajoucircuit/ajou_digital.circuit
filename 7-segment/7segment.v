`timescale 1ns/1ns

module clk_div_100k(clk, reset, clk_100k);
	input clk, reset;
	output reg clk_100k=0;

reg [8:0] clk_cnt=0;

always @ (posedge clk)
	if(!reset) begin
		clk_100k <= 0;
		clk_cnt <= 0;
	end

	else begin
		if(clk_cnt == 9'b1_1111_0011) begin //9'd499
			clk_100k <= ~ clk_100k;
			clk_cnt <= 9'd0;
		end

		else begin
			clk_cnt <= clk_cnt+1;
		end
	end
endmodule

module segment_7(bcd, seg);
	input [4:0]bcd;
	output reg [6:0]seg;

always @(*) begin
	case (bcd)
	5'd0 : seg = 7'b111_1110;
	5'd1 : seg = 7'b011_0000;
	5'd2 : seg = 7'b110_1101;
	5'd3 : seg = 7'b111_1001;
	5'd4 : seg = 7'b011_0011;
	5'd5 : seg = 7'b101_1011;
	5'd6 : seg = 7'b001_1111;
	5'd7 : seg = 7'b111_0000;
	5'd8 : seg = 7'b111_1111;
	5'd9 : seg = 7'b111_0011;
	default : seg = 7'b000_0000;
	endcase
end

endmodule


module seg_top(clk, reset, digit, seg_data);
	input clk, reset;
	output  [7:0] digit;
	output [7:0] seg_data;

	wire [6:0] seg;
	wire clk_100k;
	reg [7:0] digit_reg;

	reg [4:0] bcd;
	reg dp;

segment_7 seg0(bcd, seg);
clk_div_100k cd100(clk, reset, clk_100k);

assign seg_data = {seg, dp};
assign digit = digit_reg;

always @(posedge clk_100k or negedge reset) 
	if(~reset) begin
		digit_reg = 8'b1000_0000;
	end

	else begin
		digit_reg = digit_reg>>1;
		if(digit_reg == 8'd0) begin
		 digit_reg = 8'b1000_0000;
		end
	end

always @(*) begin

case (digit_reg)
	8'b1000_0000 :  begin bcd = 5'd1; dp = 1'b0; end //1
	8'b0100_0000 :  begin bcd = 5'd9; dp = 1'b0; end //9
	8'b0010_0000 :  begin bcd = 5'd9; dp = 1'b0; end //9
	8'b0001_0000 :  begin bcd = 5'd6; dp = 1'b1; end //6.
	8'b0000_1000 :  begin bcd = 5'd0; dp = 1'b0; end //0
	8'b0000_0100 :  begin bcd = 5'd4; dp = 1'b1; end //4.
	8'b0000_0010 :  begin bcd = 5'd1; dp = 1'b0; end //1
	8'b0000_0001 :  begin bcd = 5'd3; dp = 1'b1; end //3.
endcase

end


endmodule

module tb_seg_top();

reg clk = 0;
reg reset = 1;
wire [7:0] digit;
wire [7:0] seg_data;

seg_top st0(clk, reset, digit, seg_data);

always #5 clk = ~clk;

initial begin 
#100

reset = 0 ;

#10
reset = 1;

end

endmodule