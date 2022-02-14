`timescale 1ns/1ns

 module pgu(a,b,p,g);  
input [15:0] a,b;
output [15:0] p,g;

assign p=a^b;
assign g=a&b;

endmodule

module bclu(p,g,cin,ps,gs,c);  
input [3:0] p,g;
input cin;
output ps,gs;
output [2:0] c;

assign ps=p[3]&p[2]&p[1]&p[0];
assign gs=g[3]|p[3]&g[2]|p[3]&p[2]&g[1]|p[3]&p[2]&p[1]&g[0];

assign c[0]=g[0]|p[0]&cin;
assign c[1]=g[1]|p[1]&g[0]|p[1]&p[0]&cin;
assign c[2]=g[2]|p[2]&g[1]|p[2]&p[1]&g[0]|p[2]&p[1]&p[0]&cin;

endmodule

module clu(ps,gs,cin,c);   
input ps,gs,cin;
output c;

assign c=gs|ps&cin;

endmodule

module su(p,cin,c,s);   
input [15:0] p;
input cin;
input [14:0] c;
output [15:0] s;

assign s=p^{c,cin};
endmodule

module delay5_3(i,clk,o);
  input [2:0] i;
  input clk;
  output reg [2:0] o;

  reg [2:0] r_data [0:3];
  
  always@(posedge clk) begin
    r_data[0] <= i;
    r_data[1] <= r_data[0];
    r_data[2] <= r_data[1];
    r_data[3] <= r_data[2];
    o <= r_data[3];
  
end

endmodule

module delay4_3(i,clk,o);
  input [2:0] i;
  input clk;
  output reg [2:0] o;

  reg [2:0] r_data [0:2];
  
  always@(posedge clk) begin
    r_data[0] <= i;
    r_data[1] <= r_data[0];
    r_data[2] <= r_data[1];
    o <= r_data[2];
  
end

endmodule

module delay3_3(i,clk,o);
  input [2:0] i;
  input clk;
  output reg [2:0] o;

  reg [2:0] r_data [0:1];
  
  always@(posedge clk) begin
    r_data[0] <= i;
    r_data[1] <= r_data[0];
    o <= r_data[1];
  
end

endmodule

module delay2_3(i,clk,o);
  input [2:0] i;
  input clk;
  output reg [2:0] o;

  reg [2:0] r_data;
  
  always@(posedge clk) begin
    r_data <= i;
    o <= r_data;
  
end

endmodule

module delay1_4(i,clk,o);
  input [3:0] i;
  input clk;
  output reg [3:0] o;
  
  always@(posedge clk) begin
    o<=i;
  
end

endmodule

module delay2_4(d,clk,q);

  input [3:0] d;
  input clk;
  output reg [3:0] q;

  reg [3:0] r_data;

  always@(posedge clk) begin
    r_data <= d;
    q <= r_data;
   end
 endmodule

module delay3_4(i,clk,o);

  input [3:0] i;
  input clk;
  output reg [3:0] o;
  reg [3:0] r_data[0:1];

  always@(posedge clk) begin
    r_data[0] <= i;
    r_data[1] <= r_data[0];
    o <= r_data[1];
   end
 endmodule

module delay4_4(i,clk,o);

  input [3:0] i;
  input clk;
  output reg [3:0] o;
  reg [3:0] r_data[0:2];

  always@(posedge clk) begin
    r_data[0] <= i;
    r_data[1] <= r_data[0];
    r_data[2] <= r_data[1];
    o <= r_data[2];
   end
 endmodule

module delay6_16(i,clk,o);

  input [15:0] i;
  input clk;
  output reg [15:0] o;
  reg [15:0] r_data[0:4];

  always@(posedge clk) begin
    r_data[0] <= i;
    r_data[1] <= r_data[0];
    r_data[2] <= r_data[1];
    r_data[3] <= r_data[2];
    r_data[4] <= r_data[3];
    o <= r_data[4];
   end
 endmodule

module delay4_16(i,clk,o);

  input [15:0] i;
  input clk;
  output reg [15:0] o;
  reg [15:0] r_data[0:2];

  always@(posedge clk) begin
    r_data[0] <= i;
    r_data[1] <= r_data[0];
    r_data[2] <= r_data[1];
    o <= r_data[2];
   end
 endmodule

module delay1_16(i,clk,o);
  input [15:0] i;
  input clk;
  output reg [15:0] o;
  
  always@(posedge clk) begin
    o<=i;
  
end

endmodule

module delay1(i,clk,o);
  input i, clk;
  output reg o;
  
  always@(posedge clk) begin
    o<=i;
  
end
endmodule

module delay2(i,clk,o);
  input i, clk;
  output reg o;
  reg r_data;
 
  always@(posedge clk) begin
    r_data <= i;
    o <= r_data;
   end
 endmodule

module delay3(i,clk,o);
  input i, clk;
  output reg o;
  reg r_data[0:1];

  always@(posedge clk) begin
    r_data[0] <= i;
    r_data[1] <= r_data[0];
    o <= r_data[1];
   end
 endmodule

module delay4(i,clk,o);
  input i, clk;
  output reg o;
  reg r_data[0:2];

  always@(posedge clk) begin
    r_data[0] <= i;
    r_data[1] <= r_data[0];
    r_data[2] <= r_data[1];
    o <= r_data[2];
   end
 endmodule

module delay7(i,clk,o);
  input i, clk;
  output reg o;
  reg r_data[0:5];

  always@(posedge clk) begin
    r_data[0] <= i;
    r_data[1] <= r_data[0];
    r_data[2] <= r_data[1];
    r_data[3] <= r_data[2];
    r_data[4] <= r_data[3];
    r_data[5] <= r_data[4];
    o <= r_data[5];
   end
 endmodule

module CLA(a,b,cin,clk,s,cout);
input [15:0] a,b;
input cin;
input clk;
output [15:0] s;
output cout;

wire [15:0]p,g;
wire [14:0]c;
wire [3:0]ps,gs;

wire [15:0] A,B,P,G,P6;
wire CIN2,CIN3,CIN7;
wire [3:0]PS,GS;
wire [14:0]C;
wire C3,C7,C11,COUT;

delay1_16 f0(a,clk,A);
delay1_16 f1(b,clk,B);

delay2 f7(cin,clk,CIN2);
delay3 f8(cin,clk,CIN3);
delay7 f9(cin,clk,CIN7);

pgu pgu_pp0(A,B,p,g);

delay1_4 f2(p[3:0],clk,P[3:0]);
delay2_4 f3(p[7:4],clk,P[7:4]);
delay3_4 f4(p[11:8],clk,P[11:8]);
delay4_4 f5(p[15:12],clk,P[15:12]);
delay1_4 g2(g[3:0],clk,G[3:0]);
delay2_4 g3(g[7:4],clk,G[7:4]);
delay3_4 g4(g[11:8],clk,G[11:8]);
delay4_4 g5(g[15:12],clk,G[15:12]);
delay6_16 f6(p,clk,P6);

bclu bclu_pp0(P[3:0],G[3:0],CIN2,ps[0],gs[0],c[2:0]);
bclu bclu_pp1(P[7:4],G[7:4],c[3],ps[1],gs[1],c[6:4]);
bclu bclu_pp2(P[11:8],G[11:8],c[7],ps[2],gs[2],c[10:8]);
bclu bclu_pp3(P[15:12],G[15:12],c[11],ps[3],gs[3],c[14:12]);

delay1_4 d0(ps,clk,PS);
delay1_4 d1(gs,clk,GS);	

delay5_3 dl_c0(c[2:0],clk,C[2:0]);
delay4_3 dl_c1(c[6:4],clk,C[6:4]);
delay3_3 dl_c2(c[10:8],clk,C[10:8]);
delay2_3 dl_c3(c[14:12],clk,C[14:12]);

delay1 c0(c[3],clk,C3);	
delay1 c1(c[7],clk,C7);
delay1 c2(c[11],clk,C11);



clu clu_pp0(PS[0],GS[0],CIN3,c[3]);
clu clu_pp1(PS[1],GS[1],C3,c[7]);
clu clu_pp2(PS[2],GS[2],C7,c[11]);
clu clu_pp3(PS[3],GS[3],C11,COUT);

delay4 PL0(c[3],clk,C[3]);
delay3 PL1(c[7],clk,C[7]);
delay2 PL2(c[11],clk,C[11]);
delay1 c3(COUT,clk,cout);

su su0(P6,CIN7,C,s);

endmodule


module tb_pp_16_CLA();
 reg clk=1'b0;
 reg [15:0]A, B;
 reg Cin; 
 wire [15:0]S;
 wire Cout;

 CLA cla_16_0(A,B,Cin,clk,S,Cout);
 
 always #5 clk=~clk;
 
 initial begin
 A=16'b0101_0101_1111_0101; B=16'b0101_0100_0100_1000; Cin=0;
#10
 A=16'b0010_0100_0010_0100; B=16'b0000_0100_0100_1001; Cin=1;
#10
 A=16'b0010_1000_1000_0000; B=16'b1000_0010_0100_0001; Cin=0;

  end
endmodule


