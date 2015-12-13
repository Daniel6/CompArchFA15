module dflipflop1
(
  input clk,   // clock
  input en,    // enable
  input d,     // input
  output reg q // output
);
  always @(posedge clk) begin
    if (en) begin
      q <= d;
    end
  end
endmodule

module dflipflop8
(
  input clk,        // clock
  input en,         // enable
  input[7:0] d,     // input
  output reg[7:0] q // output
);
  always @(posedge clk) begin
    if (en) begin
      q <= d;
    end
  end
endmodule
