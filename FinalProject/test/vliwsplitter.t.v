module testVliwSplitter;

	reg testPass;
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

		testPass = 1;

		// ===============================================================================================================
		// 1 Core Tests

		// Pass in a vliw with all bits 0
		// Expect to get instruction with all bits 0
		vliw_1core = 32'b0;
		#2;
		if (instructions_1core[0] !== vliw_1core) begin
			$display("[1 Core] VLIW Splitter failed to pass instruction through properly (expected %b but got %b)", vliw_1core, instructions_1core[0]);
			testPass = 0;
		end

		// Pass in a vliw with all bits 1
		// Expect to get instruction with all bits 1
		vliw_1core = 32'hFFFF;
		#2;
		if (instructions_1core[0] !== vliw_1core) begin
			$display("[1 Core] VLIW Splitter failed to pass instruction through properly (expected %b but got %b)", vliw_1core, instructions_1core[0]);
			testPass = 0;
		end

		// Pass in a vliw with random bits
		// Expect to get instruction that matches vliw exactly
		vliw_1core = 32'hC6BD;
		#2;
		if (instructions_1core[0] !== vliw_1core) begin
			$display("[1 Core] VLIW Splitter failed to pass instruction through properly (expected %b but got %b)", vliw_1core, instructions_1core[0]);
			testPass = 0;
		end

		// ===============================================================================================================
		// 2 Core Tests

		// Pass in a vliw with all 0's
		// Expect both instructions to be all 0's
		vliw_2cores = 64'b0;
		#2;
		if (instructions_2cores[0] != 32'b0 || instructions_2cores[1] != 32'b0) begin
			$display("[2 Cores] VLIW Splitter failed to split VLIW properly:");
			$display("[Core  1] Expected %b 	Received %b", 32'b0, instructions_2cores[0]);
			$display("[Core  2] Expected %b 	Received %b", 32'b0, instructions_2cores[1]);
			testPass = 0;
		end

		// Pass in a vliw with all bits set to 1
		// Expect both instructions to be all 1's
		vliw_2cores = 64'hFFFFFFFF;
		#2;
		if (instructions_2cores[0] != 32'hFFFF || instructions_2cores[1] != 32'hFFFF) begin
			$display("[2 Cores] VLIW Splitter failed to split VLIW properly:");
			$display("[Core  1] Expected %b 	Received %b", 32'hFFFF, instructions_2cores[0]);
			$display("[Core  2] Expected %b 	Received %b", 32'hFFFF, instructions_2cores[1]);
			testPass = 0;
		end

		// Pass in a vliw with random bits
		// Expect the first half to be the first instruction and the second to be the second instruction
		vliw_2cores = 64'h827D9A12;
		#2;
		if (instructions_2cores[0] != 32'h827D || instructions_2cores[1] != 32'h9A12) begin
			$display("[2 Cores] VLIW Splitter failed to split VLIW properly:");
			$display("[Core  1] Expected %b 	Received %b", 32'h827D, instructions_2cores[0]);
			$display("[Core  2] Expected %b 	Received %b", 32'h9A12, instructions_2cores[1]);
			testPass = 0;
		end

		// ===============================================================================================================
		// 4 Core Tests

		// Pass in a vliw with all 0's
		// Expect all instructions to be all 0's
		vliw_4cores = 128'h0;
		#2;
		if (instructions_4cores[0] != 32'h0 || instructions_4cores[1] != 32'h0 || instructions_4cores[2] != 32'h0 || instruction_4cores[3] != 32'h0) begin
			$display("[4 Cores] VLIW Splitter failed to split VLIW properly:");
			$display("[Core  1] Expected %b 	Received %b", 32'h0, instructions_4cores[0]);
			$display("[Core  2] Expected %b 	Received %b", 32'h0, instructions_4cores[1]);
			$display("[Core  3] Expected %b 	Received %b", 32'h0, instructions_4cores[2]);
			$display("[Core  4] Expected %b 	Received %b", 32'h0, instructions_4cores[3]);
			testPass = 0;
		end

		// Pass in a vliw with all 1's
		// Expect all instructions to be all 1's
		vliw_4cores = 128'hFFFFFFFFFFFFFFFF;
		#2;
		if (instructions_4cores[0] != 32'hFFFF || instructions_4cores[1] != 32'hFFFF || instructions_4cores[2] != 32'hFFFF || instruction_4cores[3] != 32'hFFFF) begin
			$display("[4 Cores] VLIW Splitter failed to split VLIW properly:");
			$display("[Core  1] Expected %b 	Received %b", 32'hFFFF, instructions_4cores[0]);
			$display("[Core  2] Expected %b 	Received %b", 32'hFFFF, instructions_4cores[1]);
			$display("[Core  3] Expected %b 	Received %b", 32'hFFFF, instructions_4cores[2]);
			$display("[Core  4] Expected %b 	Received %b", 32'hFFFF, instructions_4cores[3]);
			testPass = 0;
		end

		// Pass in a vliw with random bits
		// Expect the vliw to be divided evenly among the 4 instructions
		vliw_4cores = 128'h8A2B52C671126F5A;
		#2;
		if (instructions_4cores[0] != 32'h8A2B || instructions_4cores[1] != 32'h52C6 || instructions_4cores[2] != 32'h7112 || instruction_4cores[3] != 32'h6F5A) begin
			$display("[4 Cores] VLIW Splitter failed to split VLIW properly:");
			$display("[Core  1] Expected %b 	Received %b", 32'h8A2B, instructions_4cores[0]);
			$display("[Core  2] Expected %b 	Received %b", 32'h52C6, instructions_4cores[1]);
			$display("[Core  3] Expected %b 	Received %b", 32'h7112, instructions_4cores[2]);
			$display("[Core  4] Expected %b 	Received %b", 32'h6F5A, instructions_4cores[3]);
			testPass = 0;
		end
		
		$finish;
	end

endmodule