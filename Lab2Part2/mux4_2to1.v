/* 4-bit 2 to 1 Multiplexer */
module mux4_2to1(
  input s,
  input[3:0] d0,
  input[3:0] d1,
  output[3:0] y
);

assign y[3:0] = s ? d1[3:0] : d0[3:0];

endmodule
