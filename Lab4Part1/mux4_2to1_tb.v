/* 4-bit 2 to 1 Multiplexer Test Bench */
module mux4_2to1_tb();

reg s;
reg [3:0] d0, d1;
wire [3:0] y;

mux4_2to1 uut(.s(s), .d0(d0), .d1(d1), .y(y));

integer i;
initial begin
  for (i = 0; i < 512; i = i + 1) begin // 2^(1+4*2) = 512 iterations
    {s,d0,d1} = i;
    #5;
  end
$stop; // Suspend simulation
end

endmodule
