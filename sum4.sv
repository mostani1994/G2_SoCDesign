`include "fpa.sv"
`include "fpm.sv"

module sum4mult(
                input logic clk,
                input logic reset,
                input logic pushin,  // start signal
                input logic [43:0] A,   // input A   
                input logic [43:0] B,   // input B
                output logic pushout,   // done signal
  				output logic [10:0] Z   // output result Z
);
  wire [10:0] product0, product1, product2, product3; 
  wire pushout0, pushout1, pushout2, pushout3;
  fpm mul0 (.clk(clk), .reset(reset), .pushin(pushin), .A(A[10:0]), .B(B[10:0]), .pushout(pushout0), .Z(product0));
  fpm mul1 (.clk(clk), .reset(reset), .pushin(pushin), .A(A[21:11]), .B(B[21:11]), .pushout(pushout1), .Z(product1));
  fpm mul2 (.clk(clk), .reset(reset), .pushin(pushin), .A(A[32:22]), .B(B[32:22]), .pushout(pushout2), .Z(product2));
  fpm mul3 (.clk(clk), .reset(reset), .pushin(pushin), .A(A[43:33]), .B(B[43:33]), .pushout(pushout3), .Z(product3));
  fpa add0 (.clk(clk), .reset(reset), .pushin(pushout0 & pushout1 & pushout2 & pushout3), .A(product0), .B(product1), .C(product2), .D(product3), .pushout(pushout), .Z(Z));
  
endmodule
