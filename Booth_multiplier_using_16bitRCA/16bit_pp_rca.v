`timescale 1ns/1ns

module full_adder(a, b, cin, s, cout);
 input a, b, cin;
 output s, cout;

 assign s = a ^ b ^ cin;
 assign cout = ( a & b ) | ( ( a ^ b ) & cin );

endmodule

module delay1(i,clk,o);
 input i;
 input clk;
 output reg o;

 always@(posedge clk)begin
  o <= i;
 end

endmodule

module delay2(i,clk,o);
 input i;
 input clk;
 output reg o;

 reg r_data;

 always@(posedge clk)begin
  r_data    <= i;
  o         <= r_data;
 end

endmodule

module delay3(i,clk,o);
 input i;
 input clk;
 output reg o;

 reg r_data[0:1];

 always@(posedge clk)begin
  r_data[0] <= i;
  r_data[1] <= r_data[0];
  o         <= r_data[1];
 end

endmodule

module delay4(i,clk,o); //??
 input i;
 input clk;
 output reg o;

 reg r_data[0:2];

 always@(posedge clk)begin
  r_data[0] <= i;
  r_data[1] <= r_data[0];
  r_data[2] <= r_data[1];
  o         <= r_data[2];
 end

endmodule

module pprca_4bit(A,B,Cin,clk,S,Cout);

 input [3:0]A,B;
 input Cin;
 input clk;
 output [3:0]S;
 output Cout;

 wire [3:0]a, b;
 wire [2:0]s;
 wire [6:0]c;

 delay1 dl0(A[0],clk,a[0]);
 delay1 dl1(B[0],clk,b[0]);
 delay2 dl2(A[1],clk,a[1]);
 delay2 dl3(B[1],clk,b[1]);
 delay3 dl4(A[2],clk,a[2]);
 delay3 dl5(B[2],clk,b[2]);
 delay4 dl6(A[3],clk,a[3]);
 delay4 dl7(B[3],clk,b[3]);

 delay1 dl8(Cin,clk,c[0]);
 full_adder fa0(a[0],b[0],c[0],s[0],c[1]);
 delay1 dl9(c[1],clk,c[2]);
 full_adder fa1(a[1],b[1],c[2],s[1],c[3]);
 delay1 dl10(c[3],clk,c[4]);
 full_adder fa2(a[2],b[2],c[4],s[2],c[5]);
 delay1 dl11(c[5],clk,c[6]);
 full_adder fa3(a[3],b[3],c[6],S[3],Cout);

 delay1 dl14(s[2],clk,S[2]);
 delay2 dl13(s[1],clk,S[1]);
 delay3 dl12(s[0],clk,S[0]);

 endmodule

module delay4_4b(i,clk,o);
 input [3:0]i;
 input clk;
 output reg [3:0]o;

 reg [3:0]r_data[0:2];
 
 always@(posedge clk)begin
  r_data[0] <= i;
  r_data[1] <= r_data[0];
  r_data[2] <= r_data[1];
  o         <= r_data[2];
 end

endmodule

module delay8_4b(i,clk,o);
 input [3:0]i;
 input clk;
 output reg [3:0]o;

 reg [3:0]r_data[0:6];

 always@(posedge clk)begin
  r_data[0] <= i;
  r_data[1] <= r_data[0];
  r_data[2] <= r_data[1];
  r_data[3] <= r_data[2];
  r_data[4] <= r_data[3];
  r_data[5] <= r_data[4];
  r_data[6] <= r_data[5];
  o         <= r_data[6];
 end

endmodule

module delay12_4b(i,clk,o);
 input [3:0]i;
 input clk;
 output reg [3:0]o;

 reg [3:0]r_data[0:10];

 always@(posedge clk)begin
  r_data[0] <= i;
  r_data[1] <= r_data[0];
  r_data[2] <= r_data[1];
  r_data[3] <= r_data[2];
  r_data[4] <= r_data[3];
  r_data[5] <= r_data[4];
  r_data[6] <= r_data[5];
  r_data[7] <= r_data[6];
  r_data[8] <= r_data[7];
  r_data[9] <= r_data[8];
  r_data[10]<= r_data[9];
  o         <= r_data[10];
 end

endmodule

module pp_16_rca(clk, A, B, Cin, S, Cout);
input [15:0]A, B;
input clk;
input Cin;
output [15:0]S;
output Cout;

wire [2:0]c;
wire [15:4]a,b;
wire [11:0]s;

 delay4_4b dly0(A[7:4],clk,a[7:4]);
 delay4_4b dly1(B[7:4],clk,b[7:4]);
 delay8_4b dly2(A[11:8],clk,a[11:8]);
 delay8_4b dly3(B[11:8],clk,b[11:8]);
 delay12_4b dly4(A[15:12],clk,a[15:12]);
 delay12_4b dly5(B[15:12],clk,b[15:12]);

 pprca_4bit pr0(A[3:0],B[3:0],Cin,clk,s[3:0],c[0]);
 pprca_4bit pr1(a[7:4],b[7:4],c[0],clk,s[7:4],c[1]);
 pprca_4bit pr2(a[11:8],b[11:8],c[1],clk,s[11:8],c[2]);
 pprca_4bit pr3(a[15:12],b[15:12],c[2],clk,S[15:12],Cout);

 delay12_4b dly6(s[3:0],clk,S[3:0]);
 delay8_4b dly7(s[7:4],clk,S[7:4]);
 delay4_4b dly8(s[11:8],clk,S[11:8]);

endmodule

	
module tb_pp_16_rca();
 reg clk=1'b0;
 reg [15:0]A, B;
 reg Cin;
 
 wire [15:0]S;
 wire Cout;

 pp_16_rca pp_16_rca0(clk, A, B, Cin, S, Cout);
 
 always #5 clk=~clk;
 
 initial begin
 A=16'b0101_0101_1111_0101; B=16'b0101_0100_0100_1000; Cin=0;
#10
 A=16'b0010_0100_0010_0100; B=16'b0000_0100_0100_1001; Cin=1;
#10
 A=16'b0010_1000_1000_0000; B=16'b1000_0010_0100_0001; Cin=0;
#10
 A=16'b0111_0000_1010_0011; B=16'b0000_1110_0011_1110; Cin=1;
#10
 A=16'b1100_0011_1001_1100; B=16'b0001_0011_0101_1010; Cin=0;
  end
endmodule
