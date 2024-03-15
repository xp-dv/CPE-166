/* 12-bit Binary to Common-Anode 7-Segment Display Decoder */
module bin12_7seg3_decoder_anode(
  input [11:0] bin, // 12-bit Binary or Hex input
  // 7-Segment Displays
  output reg [7:0] disp0,
  output reg [7:0] disp1,
  output reg [7:0] disp2,
  output reg [7:0] disp3
  // Output Pinout: Standard {DP,G,F,E,D,C,B,A} or DE10-Lite {7,6,5,4,3,2,1,0}
);

reg dp = 1'b0; // Decimal Point //TODO: Add decimal and signed input capability
reg [15:0] bcd; // BCD Register. When BCD has finished calculating, it will be parallel shifted to the displays.

/* 4-bit HEX/BCD to Common-Anode 7-Segment Display Decoder Function */
function [7:0] hex_7seg_decoder_anode;
  input d; // Decimal Point
  input [3:0] hex; // Hex or BCD Nibble
  // Output Pinout: Standard {DP,G,F,E,D,C,B,A} or DE10-Lite {7,6,5,4,3,2,1,0}
  // d is inverted for common-anode 7-segment displays
  case (hex)
  //  Input:           Output           ; Character Displayed
    4'b0000: hex_7seg_decoder_anode = {~d, 7'b1000000}; // 0
    4'b0001: hex_7seg_decoder_anode = {~d, 7'b1111001}; // 1
    4'b0010: hex_7seg_decoder_anode = {~d, 7'b0100100}; // 2
    4'b0011: hex_7seg_decoder_anode = {~d, 7'b0110000}; // 3
    4'b0100: hex_7seg_decoder_anode = {~d, 7'b0011001}; // 4
    4'b0101: hex_7seg_decoder_anode = {~d, 7'b0010010}; // 5
    4'b0110: hex_7seg_decoder_anode = {~d, 7'b0000010}; // 6
    4'b0111: hex_7seg_decoder_anode = {~d, 7'b1111000}; // 7
    4'b1000: hex_7seg_decoder_anode = {~d, 7'b0000000}; // 8
    4'b1001: hex_7seg_decoder_anode = {~d, 7'b0010000}; // 9
    4'b1010: hex_7seg_decoder_anode = {~d, 7'b0001000}; // A
    4'b1011: hex_7seg_decoder_anode = {~d, 7'b0000011}; // b
    4'b1100: hex_7seg_decoder_anode = {~d, 7'b1000110}; // C
    4'b1101: hex_7seg_decoder_anode = {~d, 7'b0100001}; // d
    4'b1110: hex_7seg_decoder_anode = {~d, 7'b0000110}; // E
    4'b1111: hex_7seg_decoder_anode = {~d, 7'b0001110}; // F
    default: hex_7seg_decoder_anode = 8'b11111111;       // Blank Display
  endcase
endfunction

integer i;
always @(bin or dp) begin
  bcd = 0;
  // Double Dabble Binary to BCD Method
  for (i = 0; i < 12; i = i + 1) begin // Iterate once for each bit in input number
    if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 2'b11; // If any BCD digit is >= 5, add 3
    if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 2'b11;
    if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 2'b11;
    if (bcd[15:12] >= 5) bcd[15:12] = bcd[15:12] + 2'b11;
    bcd = {bcd[14:0], bin[11 - i]}; // Shift one bit, and shift in proper bit from input
  end
  
  disp0 = hex_7seg_decoder_anode(dp, bcd[3:0]);
  disp1 = hex_7seg_decoder_anode(dp, bcd[7:4]);
  disp2 = hex_7seg_decoder_anode(dp, bcd[11:8]);
  disp3 = hex_7seg_decoder_anode(dp, bcd[15:12]);

end

endmodule
