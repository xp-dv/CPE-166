/* 4-bit Simplified Microprocessor Top-Level Module */
module top(
  input logic clk, reset, cin_i, // Clock, Reset, Carry In
  input logic [3:0] m_i [1:0], // 2×4 Input Data. Not enough switches for m_i[2]
  output logic [7:0] seg_o [4:0] // 5×8 7 Segment Output
);
logic [3:0] r_q [2:0]; // 3×4 Output Memory

mpu mpu(.clk(clk), .reset(reset), .cin_i(cin_i), .m_i('{4'b0, m_i[1], m_i[0]}), .r_q(r_q));

/* 7-Segment Displays */
// R2 | R1 | R0 | M1 | M0
hex_7seg_decoder_anode seg0(.dp(1'b0), .hex_i(m_i[0]), .seg_o(seg_o[0]));
hex_7seg_decoder_anode seg1(.dp(1'b0), .hex_i(m_i[1]), .seg_o(seg_o[1]));
hex_7seg_decoder_anode seg2(.dp(1'b0), .hex_i(r_q[0]), .seg_o(seg_o[2]));
hex_7seg_decoder_anode seg3(.dp(1'b0), .hex_i(r_q[1]), .seg_o(seg_o[3]));
hex_7seg_decoder_anode seg4(.dp(1'b0), .hex_i(r_q[2]), .seg_o(seg_o[4]));

endmodule
