`timescale 1ns/1ns

module booth_check(i,check,o,msb);
	input [7:0]i;
	input [2:0]check;
	output reg [7:0]o;
	output reg msb;

	always @(*) begin
		case (check)
			3'b000, 3'b111 : begin
				o = 8'b0000_0000;
				msb = 1'b0;
			end
	
			3'b001, 3'b010 : begin
				o = i;
				msb = i[7];
			end
		
			3'b011 : begin
				o = i <<1;
				msb = i[7];
			end

			3'b100 : begin 	
				o = (~i+1'b1) << 1;
				msb = ~i[7];
			end

			3'b101, 3'b110 : begin
				o = ~i+1'b1;
				msb = ~i[7];
			end
		endcase
	end
endmodule

module booth_top(a,b,clk,o);
	input [7:0]a,b;
	input clk;
	output [15:0]o;

	wire [7:0]pp0,pp1,pp2,pp3;
	wire m0,m1,m2,m3;
	wire [15:0] s0,s1;
	wire cout1,cout2,cout3;

	booth_check ck0(a,{b[1:0],1'b0},pp0,m0);
	booth_check ck1(a,{b[3:1]},pp1,m1);
	booth_check ck2(a,{b[5:3]},pp2,m2);
	booth_check ck3(a,{b[7:5]},pp3,m3);

	pp_16_rca bt_rca0(clk,{{8{m0}},pp0},{{6{m1}},pp1,2'b00},1'b0,s0,cout1);
	pp_16_rca bt_rca1(clk,{{4{m2}},pp2,4'b0000},{{2{m3}},pp3,6'b000_000},1'b0,s1,cout2);
	pp_16_rca bt_rca2(clk,s0,s1,1'b0,o,cout3);
endmodule

module tb_booth();

reg [7:0]mcnd;
reg [7:0]mplr;
reg clk = 1'b0;

wire [15:0]rslt;

booth_top bt_n_0(mcnd, mplr, clk, rslt);

always #5 clk = ~clk;

initial begin
mcnd = 8'b0001_0101; mplr = 8'b1010_1111; 
#10
mcnd = 8'b1011_0101; mplr = 8'b0010_1110; 
#10
mcnd = 8'b1101_0110; mplr = 8'b0100_1011; 
#10
mcnd = 8'b1011_0001; mplr = 8'b0010_1011; 
#10
mcnd = 8'b1001_0101; mplr = 8'b0010_0101; 

end

endmodule
