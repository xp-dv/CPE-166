/* 3-bit Arithmetic Logic Unit Test Bench*/
module alu_tb();

reg [2:0] s;
reg [3:0] a, b;
reg cin;
wire [3:0] y;
parameter CLK_PERIOD = 20000; // 20000 ps = 20 ns = 50 MHz

alu uut(.s(s), .a(a), .b(b), .cin(cin), .y(y));

integer i;
initial begin
  a = 4'h3;
  b = 4'hA;
  cin = 1'b1;
  for (i = 0; i < 8; i = i + 1) begin // 2^(3) = 8 iterations
    s = i; #CLK_PERIOD;
  end
$stop; // Suspend simulation
end

endmodule
