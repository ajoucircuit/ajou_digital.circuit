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


module tb_newpprca();
 reg clk=1'b0;
 reg [3:0]A, B;
 reg Cin;
 
 wire [3:0]S;
 wire Cout;

 pprca_4bit pprca0(A,B,Cin,clk,S,Cout);
 
 always #5 clk=~clk;
 
 initial begin
 A=4'b1100; B=4'b1101; Cin=0;
 #10
 A=4'b1000; B=4'b0001; Cin=0;
 #10
 A=4'b0100; B=4'b0111; Cin=0;
 #10
 A=4'b0010; B=4'b1101; Cin=1;
 #10
 A=4'b0101; B=4'b0101; Cin=1;
 #10
 A=4'b1101; B=4'b1000; Cin=0;

  end
endmodule
