/* 4-bit Simplified Microprocessor Unit */

/* Assembly Terms */
// Input | M[0], M[1], M[2], or Cin
// Reg | Registers R[0], R[1], R[2], or A
// Source | Source Register or Source Input
// Dest | Destination Register

/* Assembly Operations ( Name | Code | Operation ) */
// Move | MOV Dest, Source | Dest = Source
// Move All Inputs | MOVM | R0 = M0, R1 = M1, R2 = M2
// Add with Carry | ADC Source | A = A + Source + Cin
// Subtract with Carry | SBC Source | A = A + ~Source + Cin

module mpu(
  input logic clk, reset, cin_i, // Clock, Reset, Carry In
  input logic [3:0] m_i [2:0], // 3×4 Input Data
  output logic [3:0] r_q [2:0] // 3×4 Output Memory
);
logic clr_io; // Clear
logic [3:0] ce_io; // Clock Enable
logic [2:0] w_io; // RX Registers Mux Selector
logic [1:0] sel_io; // ALU Input B Mux Selector
logic [2:0] s_io; // ALU Operation Select (Opcode)

datapath datapath(.clk(clk), .clr_i(clr_io), .cin_i(cin_i), .m_i(m_i), .ce_i(ce_io), .w_i(w_io), .sel_i(sel_io), .s_i(s_io), .r_q(r_q));
fsm fsm(.clk(clk), .reset(reset), .clr_o(clr_io), .ce_o(ce_io), .w_o(w_io), .sel_o(sel_io), .s_o(s_io));

endmodule
