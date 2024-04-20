/* 4-bit 4 to 1 Multiplexer Test Bench */
module mux4_4to1_tb();

reg[1:0] s;
reg[3:0] d0, d1, d2, d3;
wire[3:0] y;

mux4_4to1 uut(.s(s), .d0(d0), .d1(d1), .d2(d2), .d3(d3), .y(y));

integer i;
initial begin
  for (i = 0; i < 262144; i = i + 1) begin // 2^(2+4*4) = 262144 iterations
    {s,d0,d1,d2,d3} = i;
    #5;
  end
$stop; // Suspend simulation
end

endmodule
