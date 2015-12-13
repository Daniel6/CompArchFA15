module spimemory_wrapper(
  input clk,
  output[3:0] led
);
  cpu #(.cores(1), .instruction_file("string-reversal-1-core.dat")) coopoo (clk, led[0]);
endmodule
