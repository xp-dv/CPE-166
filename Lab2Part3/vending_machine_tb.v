module vending_machine_tb();

reg reset, clk, one, two, five; // Set inputs to a register to set data to them
wire d;
wire [2:0] r;
wire [2:0] cs, ns;
parameter CLK_PERIOD = 10; // 10 ps = 100 GHz

vending_machine uut (.reset(reset), .clk(clk), .cs(cs), .ns(ns), .one(one), .two(two), .five(five), .d(d), .r(r));

initial clk = 1'b0;
always #(CLK_PERIOD / 2) clk=~clk; // 2(5) = 10 picosecond period

integer i, k;
initial begin
  // To ensure that the rising edge of the clock signal occurs as close to the middle of the input signal as possible:
  // All desired inputs should last for one full clock period
  // The input signal should only ever rise or fall with the falling edge of the clock signal
  {five,two,one,reset} = 4'b1; #10;
  {five,two,one,reset} = 4'b0; #10;
  for (i = 0; i < 6; i = i + 1) begin
    {five,two,one} = 3'b0; #10;
    {five,two,one} = 3'b1; #10;
  end
  for (i = 0; i < 5; i = i + 1) begin
    {five,two,one} = 3'b0; #10;
    {five,two,one} = 3'b010; #10;
  end
  for (k = 0; k < 5; k = k + 1) begin
    for (i = 0; i < k; i = i + 1) begin
      {five,two,one} = 3'b0; #10;
      {five,two,one} = 3'b1; #10;
    end
      {five,two,one} = 3'b0; #10;
      {five,two,one} = 3'b100; #10;
  end
$stop; // Suspend simulation
end

endmodule
