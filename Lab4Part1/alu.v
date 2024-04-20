/* 3-bit Arithmetic Logic Unit */
module alu(
  input [2:0] s, // Operation Select (aka Op Code). 3-bit = 8 possible operations
  input [3:0] a, b,
  input cin,
  output reg [3:0] y
);

always @(*) begin
  case (s)
    3'b000: y = a + b + cin; // ADD
    3'b001: y = a + ~b + cin; // ADD NOT B
    3'b010: y = b; // PASS B
    3'b011: y = a; // PASS A
    3'b100: y = a & b; // AND
    3'b101: y = a | b; // OR
    3'b110: y = ~a; // NOT A
    3'b111: y = a ^ b; // XOR
    default: y = 4'b0;
  endcase
end

endmodule
