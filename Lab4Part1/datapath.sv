/* Microprocessor Datapath */
module datapath(
  input logic clk, clr_i, cin_i, // Clock, Clear, Carry In
  input logic [3:0] m_i [2:0], // 3×4 User Data Input
  input logic [3:0] ce_i, // Clock Enable
  input logic [2:0] w_i, // 2to1 Mux Selector
  input logic [1:0] sel_i, // 4to1 Mux Selector
  input logic [2:0] s_i, // ALU Operation Select (Opcode)
  output logic [3:0] r_q [2:0] // 3×4 memory block
);

logic [3:0] y_d [3:0];
logic [3:0] b_io, a_q;

mux4_2to1 mux0(.s(w_i[0]), .d0(m_i[0]), .d1(a_q), .y(y_d[0]));
mux4_2to1 mux1(.s(w_i[1]), .d0(m_i[1]), .d1(a_q), .y(y_d[1]));
mux4_2to1 mux2(.s(w_i[2]), .d0(m_i[2]), .d1(a_q), .y(y_d[2]));

dff4_ce dff0(.clk(clk), .clr(clr_i), .ce(ce_i[0]), .d(y_d[0]), .q(r_q[0]));
dff4_ce dff1(.clk(clk), .clr(clr_i), .ce(ce_i[1]), .d(y_d[1]), .q(r_q[1]));
dff4_ce dff2(.clk(clk), .clr(clr_i), .ce(ce_i[2]), .d(y_d[2]), .q(r_q[2]));

mux4_4to1 mux3(.s(sel_i), .d0(r_q[0]), .d1(r_q[1]), .d2(r_q[2]), .d3(4'b0/*GND*/), .y(b_io));

alu alu(.s(s_i), .a(a_q), .b(b_io), .cin(cin_i), .y(y_d[3]));

dff4_ce dff3(.clk(clk), .clr(clr_i), .ce(ce_i[3]), .d(y_d[3]), .q(a_q));

endmodule
