/* Single-bit 2 to 1 Multiplexer */
module mux_2to1(
  input s,
  input d0,
  input d1,
  output y
);

assign y = s ? d1 : d0;

endmodule
