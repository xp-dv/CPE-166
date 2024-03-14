/* 4-bit Ripple Carry Adder Test Bench*/
module rca4_tb();

reg[3:0] a;
reg[3:0] b;
reg cin;
wire cout;
wire[3:0] sum;

integer i;

rca4 uut(.a(a), .b(b), .cin(cin), .cout(cout), .sum(sum));

initial begin
  for (i = 0; i < 512; i = i + 1) begin
    {a,b,cin} = i;
    #5;
  end
$stop; // End RTL simulation without exiting
end

endmodule
