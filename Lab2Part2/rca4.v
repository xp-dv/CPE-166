/* 4-bit Ripple Carry Adder */
module rca4(
  input[3:0] a,
  input[3:0] b,
  input cin,
  output cout,
  output [3:0] sum
);

wire[2:0] w;

fa fa0(.a(a[0]), .b(b[0]), .cin(cin), .cout(w[0]), .sum(sum[0]));
fa fa1(.a(a[1]), .b(b[1]), .cin(w[0]), .cout(w[1]), .sum(sum[1]));
fa fa2(.a(a[2]), .b(b[2]), .cin(w[1]), .cout(w[2]), .sum(sum[2]));
fa fa3(.a(a[3]), .b(b[3]), .cin(w[2]), .cout(cout), .sum(sum[3]));

endmodule
