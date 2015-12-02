module testVliwSplitter;

	reg clk;
	reg [31:0] vliw_1core;
	wire [0:0] instructions_1core [31:0];
	reg [63:0] vliw_2cores;
	wire [1:0] instructions_2cores [31:0];
	reg [127:0] vliw_4cores;
	wire [3:0] instructions_4cores [31:0];

	vliwsplitter #(.cores(1), .inst_len(32)) dut_1core(.clk(clk), 
														.vliw(vliw_1core), 
														.instructions(instructions_1core));

	vliwsplitter #(.cores(2), .inst_len(32)) dut_2cores(.clk(clk), 
														.vliw(vliw_2cores), 
														.instructions(instructions_2cores));

	vliwsplitter #(.cores(4), .inst_len(32)) dut_4cores(.clk(clk), 
														.vliw(vliw_4cores), 
														.instructions(instructions_4cores));

	initial clk = 0;
	always #1 clk = !clk;

	initial begin 
		$dumpfile("vliwsplitter.t.vcd");
		$dumpvars(0, testVliwSplitter);
		$finish;
	end

endmodule