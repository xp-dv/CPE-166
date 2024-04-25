/* 4-bit D Flip-Flop with Clock Enable and Asynchronous Clear */
module dff4_ce(
  input clk, clr, ce, // Clock, Clear, Clock Enable
  input [3:0] d, // Data in
  output reg [3:0] q // Data out
);

always @(posedge clk or posedge clr) begin // Active High Clock and Asynchronous Active High Clear
  if (clr)
    q <= 4'b0;
  else if (ce) // Synchronous Clock Enable
    q <= d;
end

endmodule
