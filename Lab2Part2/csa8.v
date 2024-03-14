/* 8-bit Carry Select Adder */
module csa8(
  input[7:0] a,
  input[7:0] b, // Remove only for FPGA demo
  // input bswitch, // Add only for FPGA demo
  input cin,
  output cout,
  output [7:0] sum
);

// wire[7:0] b; // Add only for FPGA demo
wire s;
wire[1:0] w;
wire[3:0] wb0;
wire[3:0] wb1;

// assign b = bswitch ? 8 : 3; // Add only for FPGA demo

rca4 rca0(.a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(s), .sum(sum[3:0]));
rca4 rca1(.a(a[7:4]), .b(b[7:4]), .cin(0), .cout(w[0]), .sum(wb0));
rca4 rca2(.a(a[7:4]), .b(b[7:4]), .cin(1), .cout(w[1]), .sum(wb1));

mux_2to1 mux(.s(s), .d0(w[0]), .d1(w[1]), .y(cout));
mux4_2to1 muxb(.s(s), .d0(wb0), .d1(wb1), .y(sum[7:4]));

endmodule
