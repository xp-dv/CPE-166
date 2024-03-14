/* 3-bit Binary Combinational Multiplier Test Bench*/
module multiplier3_tb();
reg [2:0] x;
reg [2:0] y;
wire [5:0] p;

multiplier3 uut(.x(x), .y(y), .p(p));

integer i;
	
initial begin
  for (i = 0; i < 64; i = i + 1) begin
    {x,y} = i; #5;
  end
$stop; // End RTL simulation without exiting
end
	
endmodule
