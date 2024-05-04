/* Traffic Signal Control System Test Bench */
`timescale 1ms/1ms

module traffic_signal_control_system_tb();

import traffic_signal_colors_pkg::*;

logic clk, reset;
color_e signal_sb;
color_e signal_sb_turn;
color_e signal_nb;
color_e signal_nb_turn;
color_e signal_wb;
color_e signal_wb_turn;
color_e signal_eb;
color_e signal_eb_turn;
color_e ped_signal_ns;
color_e ped_signal_ew;

localparam CLK_PERIOD = 1000; // 1000 ms = 1 Hz. Make sure CLK_PERIOD is whole number divisible by 2
localparam TEST_DURATION = (200 - 0.5) * CLK_PERIOD;

traffic_signal_control_system uut (
  .clk,
  .reset,
  .signal_sb,
  .signal_sb_turn,
  .signal_nb,
  .signal_nb_turn,
  .signal_wb,
  .signal_wb_turn,
  .signal_eb,
  .signal_eb_turn,
  .ped_signal_ns,
  .ped_signal_ew
);

/* Clock */
// To ensure that the rising edge of the clock signal occurs as close to the middle of the input signal as possible:
// All desired inputs should last for one full clock period
// The input signal should only ever rise or fall with the falling edge of the clock signal
initial clk = 1'b1;
always #(CLK_PERIOD / 2) clk = ~clk;

/* Test */
initial begin
  reset = 1'b1; #(CLK_PERIOD / 2);
  reset = 1'b0; #(TEST_DURATION);

  $stop; // Suspend simulation
end

endmodule
