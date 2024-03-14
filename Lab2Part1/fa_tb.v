/* Full Adder Test Bench */
module fa_tb();
reg a, b, cin;
wire cout, sum;

fa uut(.a(a), .b(b), .cin(cin), .cout(cout), .sum(sum));

integer i;
	
initial begin
  for (i = 0; i < 8; i = i + 1) begin
    {a,b,cin} = i; #5;
  end
$finish;
end
	
endmodule
