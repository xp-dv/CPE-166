/* Microprocessor FSM */
module fsm(
  input logic clk, reset, // Clock, Reset
  output logic clr_o, // Clear
  output logic [3:0] ce_o, // Clock Enable
  output logic [2:0] w_o, // 2to1 Mux Selector
  output logic [1:0] sel_o, // 4to1 Mux Selector
  output logic [2:0] s_o // ALU Operation Select (Opcode)
);

/* State Registers */
typedef enum logic [2:0] {
  CLEAR,
  IDLE,
  OP_MOV_RX_MX,
  OP_MOV_A_R0,
  OP_SBC_R1,
  OP_MOV_R2_A
} state_e;

state_e cs, ns; // Current State and Next State

/* Assembly Terms */
// Input | M[0], M[1], M[2], or Cin
// Reg | Registers R[0], R[1], R[2], or A
// Source | Source Register or Source Input
// Dest | Destination Register

/* Assembly Operations ( Name | Code | Operation ) */
// Move | MOV Dest, Source | Dest = Source
// Add with Carry | ADC Source | A = A + Source + Cin
// Subtract with Carry | SBC Source | A = A + ~Source + Cin

/* State Combinational Logic */
always_comb begin
  case (cs)
    // ce_o and clr_o must be set in every operation to prevent unintentionally writing to registers not related to the current operation
    CLEAR: begin
      ns = OP_MOV_RX_MX; // Manully force the next operation
    end
    IDLE: begin
      ns = IDLE; // No additional assembly instructions implemented
    end
    OP_MOV_RX_MX: begin
      ns = OP_MOV_A_R0; // Manully force the next operation
    end
    OP_MOV_A_R0: begin
      ns = OP_SBC_R1; // Manully force the next operation
    end
    OP_SBC_R1: begin
      ns = OP_MOV_R2_A; // Manully force the next operation
    end
    OP_MOV_R2_A: begin
      ns = IDLE; // Manully force the next operation
    end
    default: ns = CLEAR;
  endcase
end

/* Output Combinational Logic */
always_comb begin
  case (cs)
    // ce_o and clr_o must be set in every operation to prevent unintentionally writing to registers not related to the current operation
    CLEAR: begin
      // Operation Outputs
      clr_o = 1'b1;
      ce_o = 4'b0000;
      w_o = 3'b000;
      sel_o = 2'b00;
      s_o = 3'b000;
    end
    IDLE: begin
      // Operation Outputs
      clr_o = 1'b1;
      ce_o = 4'b0000;
      w_o = 3'b000;
      sel_o = 2'b00;
      s_o = 3'b000;
    end
    OP_MOV_RX_MX: begin
      // Operation Outputs
      clr_o = 1'b0;
      ce_o = 4'b0111; // Enable dff0 & dff1
      w_o = 3'b000; // dff[2:0] = M[2:0]

      // Don't Cares
      sel_o = 2'b00;
      s_o = 3'b000;
    end
    OP_MOV_A_R0: begin
      // Operation Outputs
      clr_o = 1'b0;
      ce_o = 4'b1000; // Enable dff3
      sel_o = 2'b00; // R0
      s_o = 3'b010; // PASS B

      // Don't Cares
      w_o = 3'b000;
    end
    OP_SBC_R1: begin
      // Operation Outputs
      clr_o = 1'b0;
      ce_o = 4'b1000; // Enable dff3
      sel_o = 2'b01; // Set B to R1
      s_o = 3'b001; // A + ~B + Cin

      // Don't Cares
      w_o = 3'b000;
    end
    OP_MOV_R2_A: begin
      // Operation Outputs
      clr_o = 1'b0;
      ce_o = 4'b0100; // Enable dff2
      w_o = 3'b100; // dff[2:0] = {A, M[1:0]}

      // Don't Cares
      sel_o = 2'b00;
      s_o = 3'b000;
    end
    default: begin
      clr_o = 1'b1;
      ce_o = 4'b0000;
      w_o = 3'b000;
      sel_o = 2'b00;
      s_o = 3'b000;
    end
  endcase
end

/* State Register and Reset Logic */
always_ff @(posedge clk or posedge reset) begin // Asynchronous active-high reset syntax required by IEEE Verilog standard
  if (reset)
    cs <= CLEAR;
  else
    cs <= ns;
end

endmodule
