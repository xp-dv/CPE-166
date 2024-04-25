module vending_machine(
  input clk, reset, one, two, five,
  output reg d, // Dispense Drink. Activated when machine contains 5 cents or more
  output reg [2:0] r = 0 // Coin Return. Max coin return is 4 cents. Drinks cost 5 cents
);

// State Definitions. cents# = cents fed to machine. ret# = coins to return
// Use the bit-specifying binary format instead of typing a decimal number in the state definitions
// which relieves the compiler from having to truncate full-size decimal integers into 3-bit integers.
// Typedef Enum is a better method for defining state names and the state registers, but it is only supported in SystemVerilog
parameter cents0 = 3'b000, cents1 = 3'b001, cents2 = 3'b010, cents3 = 3'b0011, cents4 = 3'b100;
reg [2:0] cs, ns; // Current State and Next State

/* State Combinational Logic */
always @(cs or one or two or five) begin // Mealy State Machine
  case (cs)
    cents0: begin
      if (one) ns = cents1;
      else if (two) ns = cents2;
      else ns = cs;
    end
    cents1: begin
      if (one) ns = cents2;
      else if (two) ns = cents3;
      else if (five) ns = cents0;
      else ns = cs;
    end
    cents2: begin
      if (one) ns = cents3;
      else if (two) ns = cents4;
      else if (five) ns = cents0;
      else ns = cs;
    end
    cents3: begin
      if (one) ns = cents4;
      else if (two | five) ns = cents0;
      else ns = cs;
    end
    cents4: begin
      if (one | two | five) ns = cents0;
      else ns = cs;
    end
    default: ns = cents0;

  endcase
end

/* Output Combinational Logic */
always @(cs or one or two or five) begin // Mealy State Machine
  case (cs)
    cents0: begin
      if (five) d = 1;
      else d = 0;
      r = 0;
    end
    cents1: begin
      if (five) begin
        d = 1;
        r = 1;
      end
      else begin 
        d = 0;
        r = 0;
      end
    end
    cents2: begin
      if (five) begin
        d = 1;
        r = 2;
      end
      else begin 
        d = 0;
        r = 0;
      end
    end
    cents3: begin
      if (two) begin
        d = 1;
        r = 0;
      end
      else if (five) begin
        d = 1;
        r = 3;
      end
      else begin 
        d = 0;
        r = 0;
      end
    end
    cents4: begin
      if (one) begin
        d = 1;
        r = 0;
      end
      else if (two) begin
        d = 1;
        r = 1;
      end
      else if (five) begin
        d = 1;
        r = 4;
      end
      else begin 
        d = 0;
        r = 0;
      end
    end
    default: {d,r} = 0;
  endcase
end

/* State Register and Reset Logic */
always @(posedge clk or posedge reset) begin // Asynchronous active-high reset syntax required by IEEE Verilog standard
  if (reset)
    cs <= cents0;
  else
    cs <= ns;
end

endmodule
