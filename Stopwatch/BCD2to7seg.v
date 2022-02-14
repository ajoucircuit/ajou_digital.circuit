module bcd27seg(bcd, seg);	//bcd to 7-segment decoder
	input [3:0]bcd;
	output reg [6:0]seg;

always @(*) begin
	case (bcd)
	4'd0 : seg = 7'b111_1110;
	4'd1 : seg = 7'b011_0000;
	4'd2 : seg = 7'b110_1101;
	4'd3 : seg = 7'b111_1001;
	4'd4 : seg = 7'b011_0011;
	4'd5 : seg = 7'b101_1011;
	4'd6 : seg = 7'b001_1111;
	4'd7 : seg = 7'b111_0000;
	4'd8 : seg = 7'b111_1111;
	4'd9 : seg = 7'b111_0011;
	default : seg = 7'b000_0000;
	endcase
end

endmodule
