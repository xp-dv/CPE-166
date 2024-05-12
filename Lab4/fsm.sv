/* Microprocessor Control Path FSM */

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

module fsm(
  input logic clk, reset, // Clock, Reset
  output logic clr_o, // Clear
  output logic [3:0] ce_o, // Clock Enable
  output logic [2:0] w_o, // 2 to 1 Mux Selector
  output logic [1:0] sel_o, // 4 to 1 Mux Selector
  output logic [2:0] s_o // ALU Operation Select (Opcode)
);

/* State Registers */
typedef enum logic [2:0] {
  CLEAR, // Reset/Clear Registers
  IDLE, // Hold register values
  OP_MOVM,
  OP_MOV_A_R0,
  OP_SBC_R1,
  OP_MOV_R2_A
} state_e;

state_e cs, ns; // Current State and Next State

/* State Combinational Logic */
always_comb begin
  case (cs)
    CLEAR: begin
      ns = OP_MOVM; // Manually force the next operation
    end
    IDLE: begin
      ns = IDLE; // No additional assembly instructions implemented
    end
    OP_MOVM: begin
      ns = OP_MOV_A_R0; // Manually force the next operation
    end
    OP_MOV_A_R0: begin
      ns = OP_SBC_R1; // Manually force the next operation
    end
    OP_SBC_R1: begin
      ns = OP_MOV_R2_A; // Manually force the next operation
    end
    OP_MOV_R2_A: begin
      ns = IDLE; // Manually force the next operation
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
      clr_o = 1'b0;
      ce_o = 4'b0000;
      w_o = 3'b000;
      sel_o = 2'b00;
      s_o = 3'b000;
    end
    OP_MOVM: begin
      // Operation Outputs
      clr_o = 1'b0;
      ce_o = 4'b0111; // Enable dff[2:0]
      w_o = 3'b000; // dff[2:0] = M[2:0]
      // Don't Cares
      sel_o = 2'b00;
      s_o = 3'b000;
    end
    OP_MOV_A_R0: begin
      // Operation Outputs
      clr_o = 1'b0;
      ce_o = 4'b1000; // Enable dff[3]
      sel_o = 2'b00; // Set B to R0
      s_o = 3'b010; // PASS B
      // Don't Cares
      w_o = 3'b000;
    end
    OP_SBC_R1: begin
      // Operation Outputs
      clr_o = 1'b0;
      ce_o = 4'b1000; // Enable dff[3]
      sel_o = 2'b01; // Set B to R1
      s_o = 3'b001; // A + ~B + Cin
      // Don't Cares
      w_o = 3'b000;
    end
    OP_MOV_R2_A: begin
      // Operation Outputs
      clr_o = 1'b0;
      ce_o = 4'b0100; // Enable dff[2]
      w_o = 3'b100; // dff[2:0] = {A, M[1:0]}
      // Don't Cares
      sel_o = 2'b00;
      s_o = 3'b000;
    end
    default: begin
      // CLEAR
      clr_o = 1'b1;
      ce_o = 4'b0000;
      w_o = 3'b000;
      sel_o = 2'b00;
      s_o = 3'b000;
    end
  endcase
end

/* State Register and Reset Logic */
// Negedge clock used so that datapath inputs are set before the posedge of the clock cycle sets the registers
// Asynchronous active-high reset syntax required by IEEE Verilog standard
always_ff @(negedge clk or posedge reset) begin
  if (reset)
    cs <= CLEAR;
  else
    cs <= ns;
end

endmodule
