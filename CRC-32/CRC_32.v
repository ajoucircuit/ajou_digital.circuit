`timescale 1ns/1ns

module CRC_32_gen(clk,rst,data_in,data_out,crc_bit);

input clk;
input rst;
input [4:0]data_in;

output [36:0]data_out; // 5+32
output reg [31:0]crc_bit;

reg [68:0]crc_t; // 32*2+5
reg [36:0]reg_d;

wire line;
wire [9:0]tmp;

assign line = crc_t[68] ^ reg_d[36];
assign tmp = {10{crc_t[68]}}^{crc_t[37],crc_t[39],crc_t[41],crc_t[43],crc_t[44],crc_t[50],crc_t[52],crc_t[58],crc_t[60],crc_t[67]};

integer i = 1;

always@ (posedge clk or negedge rst) begin
	if(~rst) begin
		crc_t = 69'h0;
		reg_d <= {data_in,32'b0};
	end
	else begin
		crc_t <= {tmp[0],crc_t[66:61],tmp[1],crc_t[59],tmp[2],crc_t[57:53],tmp[3],crc_t[51],tmp[4],crc_t[49:45],tmp[5],tmp[6],crc_t[42],tmp[7],crc_t[40],tmp[8],crc_t[38],tmp[9],line,37'b0};
		i <= i + 1;
		reg_d <= reg_d << 1;

		if(i == 38) begin
			crc_bit <= crc_t[68:37];
		end
	end
end

assign data_out = {data_in, crc_bit};


endmodule

module tb_crc_32();

reg clk = 1'b0;
reg rst = 1'b0;
reg [4:0]data_in;

wire [36:0]data_out;
wire [31:0]crc_bit;

CRC_32_gen crc0(clk,rst,data_in,data_out,crc_bit);

always #5 clk = ~clk;

initial begin

data_in = 5'b11001;
#20
rst = 1'b1;
#5
rst = 1'b0;
#20
rst = 1'b1;

end

endmodule