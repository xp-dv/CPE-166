/* 4-bit D Flip-Flop with Clock Enable and Asynchronous Clear Test Bench */
module dff4_ce_tb();

reg clr, ce, clk; // Clear, Clock Enable, Clock
reg [3:0] d; // Data in
wire [3:0] q; // Data out
parameter CLK_PERIOD = 20000; // 20000 ps = 20 ns = 50 MHz

dff4_ce uut (.d(d), .clr(clr), .ce(ce), .clk(clk), .q(q));

// To ensure that the rising edge of the clock signal occurs as close to the middle of the input signal as possible:
// All desired inputs should last for one full clock period
// The input signal should only ever rise or fall with the falling edge of the clock signal
initial clk = 1'b0;
always #(CLK_PERIOD / 2) clk = ~clk;

initial begin
  {clr, ce, d} = 6'b1_1_1111; #CLK_PERIOD;
  {clr, ce, d} = 6'b1_0_1010; #CLK_PERIOD;
  {clr, ce, d} = 6'b0_1_0101; #CLK_PERIOD;
  {clr, ce, d} = 6'b0_0_0001; #CLK_PERIOD;

  $stop; // Suspend simulation
end

endmodule
