/* 8-bit Carry Select Adder Test Bench*/
module csa8_tb();

reg[7:0] a;
reg[7:0] b;
reg cin;
wire cout;
wire[7:0] sum;

integer i;

csa8 uut(.a(a), .b(b), .cin(cin), .cout(cout), .sum(sum));

initial begin
  for (i = 0; i < 131072; i = i + 1) begin
    {a,b,cin} = i;
    #5;
  end
 $finish;
end

endmodule
