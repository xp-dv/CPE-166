/* 4-bit 2 to 1 Multiplexer */
module mux4_2to1(
  input s,
  input[3:0] d0, d1,
  output[3:0] y
);

assign y = s ? d1 : d0;

endmodule
