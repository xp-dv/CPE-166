/* 4-bit Simplified Microprocessor Top-Level Module */
module top(
  input logic clk, reset, cin_i, // Clock, Reset, Carry In
  input logic [3:0] m_i [1:0], // 2×4 Input Data. Not enough switches for m_i[2]
  output logic [7:0] seg_out [2:0] // 3×8 7 Segment Output
);
logic [3:0] r_q [2:0]; // 3×4 Output Memory

mpu mpu_block(.clk(clk), .reset(reset), .cin_i(cin_i), .m_i('{4'b0, m_i[1], m_i[0]}), .r_q(r_q));
hex_7seg_decoder_anode seg0(.dp(1'b0), .hex_in(r_q[0]), .seg_out(seg_out[0]));
hex_7seg_decoder_anode seg1(.dp(1'b0), .hex_in(r_q[1]), .seg_out(seg_out[1]));
hex_7seg_decoder_anode seg2(.dp(1'b0), .hex_in(r_q[2]), .seg_out(seg_out[2]));

endmodule
