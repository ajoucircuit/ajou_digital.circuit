`timescale 1ns/1ns

module CRC_32_gen(clk,rst,data_in,data_out,crc_bit);

input clk;
input rst;
input [15:0]data_in;

output [47:0]data_out; // 16+32
output reg [31:0]crc_bit;

reg [79:0]crc_t; // 32*2+16
reg [47:0]reg_d;

wire line;
wire [9:0]tmp;

assign line = crc_t[79] ^ reg_d[47];
assign tmp = {10{crc_t[79]}}^{crc_t[48],crc_t[50],crc_t[52],crc_t[54],crc_t[55],crc_t[61],crc_t[63],crc_t[69],crc_t[71],crc_t[78]};

integer i = 1;

always@ (posedge clk or negedge rst) begin
	if(~rst) begin
		crc_t = 80'h0;
		reg_d <= {data_in,32'b0};
	end
	else begin
		crc_t <= {tmp[0],crc_t[77:72],tmp[1],crc_t[70],tmp[2],crc_t[68:64],tmp[3],crc_t[62],tmp[4],crc_t[60:56],tmp[5],tmp[6],crc_t[53],tmp[7],crc_t[51],tmp[8],crc_t[49],tmp[9],line,48'b0};
		i <= i + 1;
		reg_d <= reg_d << 1;

		if(i == 49) begin
			crc_bit <= crc_t[79:48];
		end
	end
end


assign data_out = {data_in, crc_bit};


endmodule

module tb_crc_32();

reg clk = 1'b0;
reg rst = 1'b0;
reg [15:0]data_in;

wire [47:0]data_out;
wire [31:0]crc_bit;

CRC_32_gen crc0(clk,rst,data_in,data_out,crc_bit);

always #5 clk = ~clk;

initial begin

data_in = 16'b110000101100001;
#20
rst = 1'b1;
#5
rst = 1'b0;
#20
rst = 1'b1;

end

endmodule