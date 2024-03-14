module vending_machine_tb();
reg RESET, CLK, ONE, TWO, FIVE; // Set inputs to a register to set data to them
wire D;
wire[2:0] R;
wire[2:0] CS, NS;

vending_machine uut (.reset(RESET), .clk(CLK), .cs(CS), .ns(NS), .one(ONE), .two(TWO), .five(FIVE), .d(D), .r(R));

initial CLK = 0;
always #5 CLK=~CLK; // 2(5) = 10 picosecond period

integer i, k;
initial begin
  // Inputs must last for a full period
  {FIVE,TWO,ONE,RESET} = 1; #15; // The additional half-period offset is REQUIRED so each state change happens at the end of the input pulse
  {FIVE,TWO,ONE,RESET} = 0; #10;
  for (i = 0; i < 6; i = i + 1) begin
    {FIVE,TWO,ONE} = 0; #10;
    {FIVE,TWO,ONE} = 1; #10;
  end
  for (i = 0; i < 5; i = i + 1) begin
    {FIVE,TWO,ONE} = 0; #10;
    {FIVE,TWO,ONE} = 2; #10;
  end
  for (k = 0; k < 5; k = k + 1) begin
    for (i = 0; i < k; i = i + 1) begin
      {FIVE,TWO,ONE} = 0; #10;
      {FIVE,TWO,ONE} = 1; #10;
    end
      {FIVE,TWO,ONE} = 0; #10;
      {FIVE,TWO,ONE} = 4; #10;
  end
$finish;
end

endmodule
