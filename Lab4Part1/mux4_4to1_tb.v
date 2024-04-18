/* 4-bit 4 to 1 Multiplexer Test Bench */
module mux4_4to1_tb();

reg s;
reg[3:0] d0, d1, d2, d3;
wire[3:0] y;

integer i;

mux4_4to1 uut(.s(s), .d0(d0), .d1(d1), .d2(d2), .d3(d3), .y(y));

initial begin
  for (i = 0; i < 131072; i = i + 1) begin // 2^(1+4*4) = 131072 iterations
    {s,d0,d1,d2,d3} = i;
    #5;
  end
$stop; // Suspend simulation
end

endmodule
