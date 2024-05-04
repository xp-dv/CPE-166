/* Traffic Signal Control System */
module traffic_signal_control_system
  import traffic_signal_colors_pkg::*;
#(
  // Traffic Signal Duration in Seconds (Given a 1 Hz Clock)
  parameter SIGNAL_DURATION_GREEN = 20,
  parameter SIGNAL_DURATION_YELLOW = 5,
  parameter SIGNAL_DURATION_PED_CROSSING = 25,
  parameter SIGNAL_DURATION_FLASHING = 20
) (
  input logic clk, reset, // Clock, Reset
  output color_e signal_sb, // Southbound Traffic Signal
  output color_e signal_sb_turn, // Southbound Left Turn Signal
  output color_e signal_nb, // Northbound Traffic Signal
  output color_e signal_nb_turn, // Northbound Left Turn Signal
  output color_e signal_wb, // Westbound Traffic Signal
  output color_e signal_wb_turn, // Westbound Left Turn Signal
  output color_e signal_eb, // Eastbound Traffic Signal
  output color_e signal_eb_turn, // Eastbound Left Turn Signal
  output color_e ped_signal_ns, // North-South Pedestrian Crossing Signal
  output color_e ped_signal_ew // East-West Pedestrian Crossing Signal
);
logic [7:0] timer = '0;

/* State Registers */
typedef enum logic [3:0] {
  FLASHING_RED, // Reset State. All Signals Flash Red
  SB_ALL_G, // Southbound All Green
  SB_TURN_Y, // Southbound Left Turn Signal Yellow
  NS_THROUGH_G, // North-South Through Traffic Green
  NB_G_SB_Y, // Northbound Green Southbound Yellow
  NB_ALL_G, // Northbound All Green
  NB_ALL_Y, // Northbound All Yellow
  WB_ALL_G, // Westbound All Green
  WB_TURN_Y, // Westbound Left Turn Signal Yellow
  EW_THROUGH_G, // East-West Through Traffic Green
  EB_G_WB_Y, // Eastbound Green Westbound Yellow
  EB_ALL_G, // Eastbound All Green
  EB_ALL_Y // Eastbound All Yellow
} state_e;
state_e cs, ns; // Current State and Next State

/* State and Output Combinational Logic */
always_comb begin
  // All lights not explicitly set in the case statement will defualt to RED
  signal_sb = RED;
  signal_sb_turn = RED;
  signal_nb = RED;
  signal_nb_turn = RED;
  signal_wb = RED;
  signal_wb_turn = RED;
  signal_eb = RED;
  signal_eb_turn = RED;
  ped_signal_ns = RED;
  ped_signal_ew = RED;
  case (cs)
    FLASHING_RED: begin
      // Output Logic
      signal_sb = FLASHING;
      signal_sb_turn = FLASHING;
      signal_nb = FLASHING;
      signal_nb_turn = FLASHING;
      signal_wb = FLASHING;
      signal_wb_turn = FLASHING;
      signal_eb = FLASHING;
      signal_eb_turn = FLASHING;
      ped_signal_ns = FLASHING;
      ped_signal_ew = FLASHING;
      // State Logic
      ns = (timer == 'b1) ? SB_ALL_G : FLASHING_RED;
    end
    SB_ALL_G: begin
      // Output Logic
      signal_sb = GREEN;
      signal_sb_turn = GREEN;
      // State Logic
      ns = (timer == 'b1) ? SB_TURN_Y : SB_ALL_G;
    end
    SB_TURN_Y: begin
      // Output Logic
      signal_sb = GREEN;
      signal_sb_turn = YELLOW;
      // State Logic
      ns = (timer == 'b1) ? NS_THROUGH_G : SB_TURN_Y;
    end
    NS_THROUGH_G: begin
      // Output Logic
      signal_sb = GREEN;
      signal_nb = GREEN;
      ped_signal_ns = GREEN;
      // State Logic
      ns = (timer == 'b1) ? NB_G_SB_Y : NS_THROUGH_G;
    end
    NB_G_SB_Y: begin
      // Output Logic
      signal_sb = YELLOW;
      signal_nb = GREEN;
      // State Logic
      ns = (timer == 'b1) ? NB_ALL_G : NB_G_SB_Y;
    end
    NB_ALL_G: begin
      // Output Logic
      signal_nb = GREEN;
      signal_nb_turn = GREEN;
      // State Logic
      ns = (timer == 'b1) ? NB_ALL_Y : NB_ALL_G;
    end
    NB_ALL_Y: begin
      // Output Logic
      signal_nb = YELLOW;
      signal_nb_turn = YELLOW;
      // State Logic
      ns = (timer == 'b1) ? WB_ALL_G : NB_ALL_Y;
    end
    WB_ALL_G: begin
      // Output Logic
      signal_wb = GREEN;
      signal_wb_turn = GREEN;
      // State Logic
      ns = (timer == 'b1) ? WB_TURN_Y : WB_ALL_G;
    end
    WB_TURN_Y: begin
      // Output Logic
      signal_wb = GREEN;
      signal_wb_turn = YELLOW;
      // State Logic
      ns = (timer == 'b1) ? EW_THROUGH_G : WB_TURN_Y;
    end
    EW_THROUGH_G: begin
      // Output Logic
      signal_wb = GREEN;
      signal_eb = GREEN;
      ped_signal_ew = GREEN;
      // State Logic
      ns = (timer == 'b1) ? EB_G_WB_Y : EW_THROUGH_G;
    end
    EB_G_WB_Y: begin
      // Output Logic
      signal_wb = YELLOW;
      signal_eb = GREEN;
      // State Logic
      ns = (timer == 'b1) ? EB_ALL_G : EB_G_WB_Y;
    end
    EB_ALL_G: begin
      // Output Logic
      signal_eb = GREEN;
      signal_eb_turn = GREEN;
      // State Logic
      ns = (timer == 'b1) ? EB_ALL_Y : EB_ALL_G;
    end
    EB_ALL_Y: begin
      // Output Logic
      signal_eb = YELLOW;
      signal_eb_turn = YELLOW;
      // State Logic
      ns = (timer == 'b1) ? SB_ALL_G : EB_ALL_Y;
    end
    default: ns = FLASHING_RED;
  endcase
end

/* State Register, Reset, and Timer Logic */
// Asynchronous active-high reset syntax required by IEEE Verilog standard
always_ff @(posedge clk or posedge reset) begin
  if (reset) begin
    cs <= FLASHING_RED;
    timer <= SIGNAL_DURATION_FLASHING;
  end
  else begin
    cs <= ns;
    if (timer == 'b1) begin
      case (cs)
        EB_ALL_Y: timer <= SIGNAL_DURATION_FLASHING;
        FLASHING_RED, NB_G_SB_Y, NB_ALL_Y, EB_G_WB_Y: timer <= SIGNAL_DURATION_GREEN;
        SB_ALL_G, NS_THROUGH_G, NB_ALL_G, WB_ALL_G, EW_THROUGH_G, EB_ALL_G: timer <= SIGNAL_DURATION_YELLOW;
        SB_TURN_Y, WB_TURN_Y:  timer <= SIGNAL_DURATION_PED_CROSSING;
        default: timer <= SIGNAL_DURATION_FLASHING;
      endcase
    end
    else begin
      timer <= timer - 1;
    end
  end
end

endmodule
