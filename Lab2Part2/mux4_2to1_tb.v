/* 4-bit 2 to 1 Multiplexer Test Bench */
module mux4_2to1_tb();

reg s;
reg[3:0] d0;
reg[3:0] d1;
wire[3:0] y;

integer i;

mux4_2to1 uut(.s(s), .d0(d0), .d1(d1), .y(y));

initial begin
  for (i = 0; i < 512; i = i + 1) begin
    {s,d0,d1} = i;
    #5;
  end
 $finish;
end

endmodule
