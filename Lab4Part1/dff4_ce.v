/* 4-bit D Flip-Flop with Clock Enable and Asynchronous Clear */
module dff4_ce(
  input clr, ce, clk, // Clear, Clock Enable, Clock
  input [3:0] d, // Data in
  output reg [3:0] q // Data out
);

always @(posedge clk or posedge clr) begin // Active High Clock and Asynchronous Active High Clear
  if (clr)
    q <= 0;
  else if (ce) // Synchronous Clock Enable
    q <= d;
end

endmodule
