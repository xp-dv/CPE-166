/* Single-bit 2 to 1 Multiplexer Test Bench */
module mux_2to1_tb();

reg s;
reg d0;
reg d1;
wire y;

integer i;

mux_2to1 uut(.s(s), .d0(d0), .d1(d1), .y(y));

initial begin
  for (i = 0; i < 8; i = i + 1) begin
    {s,d0,d1} = i;
    #5;
  end
 $finish;
end

endmodule
