/* 4-bit Simplified Microprocessor Top-Level Module */
module top(
  input logic clk, reset_n, cin_i, // Internal 50 MHz Clock, Reset Btn (3.3 V Schmitt Trigger), Carry In Switch
  input logic [3:0] m_i [2:0], // 3×4-bit Input Data
  output logic [7:0] seg_o [5:0] // 5×8-bit 7 Segment Output
);
logic [3:0] r_q [2:0]; // 3×4 Output Memory

mpu mpu (
  .clk(clk),
  .reset(~reset_n), // Invert reset btn due to inverting Schmitt trigger
  .cin_i(cin_i),
  .m_i('{m_i[2], m_i[1], m_i[0]}), // '{} is the array assignment operator with index zero starting at right-most element
  .r_q(r_q)
);

/* 7-Segment Displays */
// R2 | R1 | R0 | M2 | M1 | M0
hex_7seg_decoder_anode seg0(.dp(1'b0), .hex_i(m_i[0]), .seg_o(seg_o[0]));
hex_7seg_decoder_anode seg1(.dp(1'b0), .hex_i(m_i[1]), .seg_o(seg_o[1]));
hex_7seg_decoder_anode seg2(.dp(1'b0), .hex_i(m_i[2]), .seg_o(seg_o[2]));
hex_7seg_decoder_anode seg3(.dp(1'b0), .hex_i(r_q[0]), .seg_o(seg_o[3]));
hex_7seg_decoder_anode seg4(.dp(1'b0), .hex_i(r_q[1]), .seg_o(seg_o[4]));
hex_7seg_decoder_anode seg5(.dp(1'b0), .hex_i(r_q[2]), .seg_o(seg_o[5]));

endmodule
