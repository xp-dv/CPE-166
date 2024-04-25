/* Microprocessor FSM Test Bench*/
module fsm_tb();

logic clk, reset;
logic clr_o;
logic [3:0] ce_o;
logic [2:0] w_o;
logic [1:0] sel_o;
logic [2:0] s_o;
parameter CLK_PERIOD = 20000; // 20000 ps = 20 ns = 50 MHz

fsm uut (.clk(clk), .reset(reset), .clr_o(clr_o), .ce_o(ce_o), .w_o(w_o), .sel_o(sel_o), .s_o(s_o));

/* Clock */
// To ensure that the rising edge of the clock signal occurs as close to the middle of the input signal as possible:
// All desired inputs should last for one full clock period
// The input signal should only ever rise or fall with the falling edge of the clock signal
initial clk = 1'b0;
always #(CLK_PERIOD / 2) clk = ~clk;

initial begin

$stop; // Suspend simulation
end

endmodule
