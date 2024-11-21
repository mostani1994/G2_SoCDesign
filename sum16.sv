`include "sum4.sv"

module sum16(
                input logic clk,
                input logic reset,
                input logic pushin,  // start signal
  				input logic [175:0] A,   // input A   
  				input logic [351:176] B,   // input B
                output logic pushout,   // done signal
  				output logic [10:0] Z   // output result Z
);
  wire [10:0] product0, product1, product2, product3; 
  wire pushout0, pushout1, pushout2, pushout3, pushout_mul;
  sum4mult sum4_0 (.clk(clk), .reset(reset), .pushin(pushin), .A(A[43:0]), .B(B[219:176]), .pushout(pushout0), .Z(product0));
  sum4mult sum4_1 (.clk(clk), .reset(reset), .pushin(pushin), .A(A[87:44]), .B(B[263:220]), .pushout(pushout1), .Z(product1));
  sum4mult sum4_2 (.clk(clk), .reset(reset), .pushin(pushin), .A(A[131:88]), .B(B[307:264]), .pushout(pushout2), .Z(product2));
  sum4mult sum4_3 (.clk(clk), .reset(reset), .pushin(pushin), .A(A[175:132]), .B(B[351:308]), .pushout(pushout3), .Z(product3));
  fpa final_add (.clk(clk), .reset(reset), .pushin(pushout0 & pushout1 & pushout2 & pushout3), .A(product0), .B(product1), .C(product2), .D(product3), .pushout(pushout), .Z(Z));
  
endmodule
