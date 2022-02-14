`timescale 1ns/1ns

module pgu (a, b, p, g);                                                                         // p, g ?? 
 input [15:0] a, b;
 output [15:0] p, g;

 assign p[15:0] = a[15:0] ^ b[15:0];
 assign g[15:0] = a[15:0] & b[15:0];

endmodule

module BCLU (p, g, cin, ps, gs, cout);                                                           // 4bit? ps, gs ?? ? ?? ??.
 input [3:0] p, g;
 input cin;
 output ps, gs;
 output [2:0] cout;
 
 wire c0, c1, c2;
 
 assign c0 = g[0] | ( p[0] & cin );
 assign c1 = g[1] | ( p[1] & g[0] ) | ( p[1] & p[0] & cin);
 assign c2 = g[2] | ( p[2] & g[1] ) | ( p[2] & p[1] & p[0] & cin);

 assign cout = {c2, c1, c0};                                                                     // ??? ?? 3bit? ??? ??.

 assign gs = g[3] | ( p[3] & g[2] ) | ( p[3] & p[2] & g[1] ) | ( p[3] & p[2] & p[1] & g[0] );
 assign ps = p[3] & p[2] & p[1] & p[0];

endmodule

module CLU (ps, gs, cin, cout);                                                                  // 4bit? ??? ??? ?? ??? ?? ?? ??.
 input ps, gs, cin;
 output cout;
 
  assign cout = gs | (ps & cin) ;

endmodule

module SU(c, p, s);                                                                              // c? p? ???? xor???? sum ??.
 input [15:0] c, p;
 output [15:0]s;

 assign s[15:0] = p[15:0] ^ c[15:0];

endmodule


module cla_16bit (a, b, cin, s, cout);                                                           // 16bit cla ??. 
 input [15:0] a, b;
 input cin;
 output [15:0] s;
 output cout;

 wire [15:0] p, g, c, c1;                                                                        // SU???? ??? c1? ??. 
 wire [3:0] ps, gs;
  
 pgu pgu0(a[15:0], b[15:0], p[15:0], g[15:0]);                                                   //p, g ?? 

 BCLU bclu0(p[3:0], g[3:0], cin, ps[0], gs[0], c[2:0]);                                          //ps, gs, c ??.
 BCLU bclu1(p[7:4], g[7:4], c[3], ps[1], gs[1], c[6:4]);
 BCLU bclu2(p[11:8], g[11:8], c[7], ps[2], gs[2], c[10:8]);
 BCLU bclu3(p[15:12], g[15:12], c[11], ps[3], gs[3], c[14:12]);

 CLU clu0(ps[0], gs[0], cin, c[3]);                                                              //?? ??.
 CLU clu1(ps[1], gs[1], c[3], c[7]);
 CLU clu2(ps[2], gs[2], c[7], c[11]);
 CLU clu3(ps[3], gs[3], c[11], cout);

 assign c1[15:0] = {c[14:0], cin};                                                               //SU ???? ??? 16bit? c? LSB? cin? ????? ????? ??? 15bit? MSB?? ???? LSB? cin ??.

 SU su0(c1[15:0], p[15:0], s[15:0]);                                                             //?? ??.
 
endmodule


module tb_test_cla16bit ();                                                                      //testbench ??. 
reg [15:0] a,b;
reg cin;
wire [15:0] s;
wire cout;

cla_16bit clatest(a, b, cin, s, cout);

initial begin                                                                                    //16bit rca? ?? ??? ?????.
 a= 16'b0000000000000000; b= 16'b0000000000000001; cin = 0;
 #10
 a= 16'b0100011100000010; b= 16'b0010010011110001;
 #10
 a= 16'b1000001010000000; b= 16'b0110001010000011;
 #10
 a= 16'b0111111111111111; b= 16'b0000000000000001;
 #10
 a= 16'b1000100011110110; b= 16'b1000000011011100;
 #10
 a= 16'b1111111111110000; b= 16'b1111111111110110;
end

endmodule
