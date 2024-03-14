/* Half Adder Test Bench */
module ha_tb();
reg a, b;
wire cout, sum;

ha uut(.a(a), .b(b), .cout(cout), .sum(sum));

integer i;
	
initial begin
  for (i = 0; i < 4; i = i + 1) begin
    {a,b} = i; #5;
  end
$finish;
end
	
endmodule
