/* 4-bit HEX/BCD to Common-Anode 7-Segment Display Decoder */
module hex_7seg_decoder_anode(
  input dp, // Decimal Point
  input [3:0] hex_in, // Hex or BCD Nibble
  output reg [7:0] seg_out // Pinout: Standard {DP,G,F,E,D,C,B,A} or DE10-Lite {7,6,5,4,3,2,1,0}
);

always @(hex_in or dp) begin
  case (hex_in)
  //  Input:           Output           ; Character Displayed
    4'b0000: seg_out = {~dp, 7'b1000000}; // 0
    4'b0001: seg_out = {~dp, 7'b1111001}; // 1
    4'b0010: seg_out = {~dp, 7'b0100100}; // 2
    4'b0011: seg_out = {~dp, 7'b0110000}; // 3
    4'b0100: seg_out = {~dp, 7'b0011001}; // 4
    4'b0101: seg_out = {~dp, 7'b0010010}; // 5
    4'b0110: seg_out = {~dp, 7'b0000010}; // 6
    4'b0111: seg_out = {~dp, 7'b1111000}; // 7
    4'b1000: seg_out = {~dp, 7'b0000000}; // 8
    4'b1001: seg_out = {~dp, 7'b0010000}; // 9
    4'b1010: seg_out = {~dp, 7'b0001000}; // A
    4'b1011: seg_out = {~dp, 7'b0000011}; // b
    4'b1100: seg_out = {~dp, 7'b1000110}; // C
    4'b1101: seg_out = {~dp, 7'b0100001}; // d
    4'b1110: seg_out = {~dp, 7'b0000110}; // E
    4'b1111: seg_out = {~dp, 7'b0001110}; // F
    default: seg_out = 8'b11111111;       // Blank Display
  endcase
end

endmodule
