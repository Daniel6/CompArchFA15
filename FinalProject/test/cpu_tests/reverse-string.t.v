/*
	Test Reverse String functionality with 1 and 4 cores
*/
module testReverseString #(parameter instructions_root = "./instructions/",
						   parameter waveforms_root = "./waveforms/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;
	cpu #(.cores(4), .instruction_file({instructions_root, "string-reversal-1-core.dat"})) DUT_ReverseString_1_core (.clk(clk));
	cpu #(.cores(4), .instruction_file({instructions_root, "string-reversal-4-cores.dat"})) DUT_ReverseString_4_core (.clk(clk));

	initial begin
		$display("BEGIN");
		$dumpfile({waveforms_root, "reverse-string.vcd"}); //dump info to create wave propagation later
        $dumpvars(0, testReverseString);
        DUT_ReverseString_1_core.dm.memory[0] = 32'd1;
		DUT_ReverseString_1_core.dm.memory[1] = 32'd2;
		DUT_ReverseString_1_core.dm.memory[2] = 32'd3;
		DUT_ReverseString_1_core.dm.memory[3] = 32'd4;
		DUT_ReverseString_1_core.dm.memory[4] = 32'd5;
		DUT_ReverseString_1_core.dm.memory[5] = 32'd6;
		DUT_ReverseString_1_core.dm.memory[6] = 32'd7;
		DUT_ReverseString_1_core.dm.memory[7] = 32'd8;

		DUT_ReverseString_4_core.dm.memory[0] = 32'd1;
		DUT_ReverseString_4_core.dm.memory[1] = 32'd2;
		DUT_ReverseString_4_core.dm.memory[2] = 32'd3;
		DUT_ReverseString_4_core.dm.memory[3] = 32'd4;
		DUT_ReverseString_4_core.dm.memory[4] = 32'd5;
		DUT_ReverseString_4_core.dm.memory[5] = 32'd6;
		DUT_ReverseString_4_core.dm.memory[6] = 32'd7;
		DUT_ReverseString_4_core.dm.memory[7] = 32'd8;
		#10;
		$display("T=10");
		#10;
		$display("T=20");
		#20;
		$display("T=40");
		#20;
		$display("T=60");
		#24;
		$display("T=84");
		if (DUT_ReverseString_1_core.dm.memory[0] !== 32'd8 ||
			DUT_ReverseString_1_core.dm.memory[1] !== 32'd7 ||
			DUT_ReverseString_1_core.dm.memory[2] !== 32'd6 ||
			DUT_ReverseString_1_core.dm.memory[3] !== 32'd5 ||
			DUT_ReverseString_1_core.dm.memory[4] !== 32'd4 ||
			DUT_ReverseString_1_core.dm.memory[5] !== 32'd3 ||
			DUT_ReverseString_1_core.dm.memory[6] !== 32'd2 ||
			DUT_ReverseString_1_core.dm.memory[7] !== 32'd1) begin

			$write("%c[31m",27);
			$display("1 Core String Reversal test failed.");
			$write("%c[0m",27);
			$display("Expected 87654321, got %b%b%b%b%b%b%b%b", 
				DUT_ReverseString_1_core.dm.memory[0],
				DUT_ReverseString_1_core.dm.memory[1],
				DUT_ReverseString_1_core.dm.memory[2],
				DUT_ReverseString_1_core.dm.memory[3],
				DUT_ReverseString_1_core.dm.memory[4],
				DUT_ReverseString_1_core.dm.memory[5],
				DUT_ReverseString_1_core.dm.memory[6],
				DUT_ReverseString_1_core.dm.memory[7]);
		end
		else begin
			$write("%c[32m",27);
			$display("4 Core String Reversal test passed.");
			$write("%c[0m",27);
		end

		if (DUT_ReverseString_4_core.dm.memory[0] !== 32'd8 ||
			DUT_ReverseString_4_core.dm.memory[1] !== 32'd7 ||
			DUT_ReverseString_4_core.dm.memory[2] !== 32'd6 ||
			DUT_ReverseString_4_core.dm.memory[3] !== 32'd5 ||
			DUT_ReverseString_4_core.dm.memory[4] !== 32'd4 ||
			DUT_ReverseString_4_core.dm.memory[5] !== 32'd3 ||
			DUT_ReverseString_4_core.dm.memory[6] !== 32'd2 ||
			DUT_ReverseString_4_core.dm.memory[7] !== 32'd1) begin

			$write("%c[31m",27);
			$display("4 Core String Reversal test failed.");
			$write("%c[0m",27);
			$display("Expected 87654321, got %b%b%b%b%b%b%b%b", 
				DUT_ReverseString_4_core.dm.memory[0],
				DUT_ReverseString_4_core.dm.memory[1],
				DUT_ReverseString_4_core.dm.memory[2],
				DUT_ReverseString_4_core.dm.memory[3],
				DUT_ReverseString_4_core.dm.memory[4],
				DUT_ReverseString_4_core.dm.memory[5],
				DUT_ReverseString_4_core.dm.memory[6],
				DUT_ReverseString_4_core.dm.memory[7]);
		end
		else begin
			$write("%c[32m",27);
			$display("4 Core String Reversal test passed.");
			$write("%c[0m",27);
		end
		$finish;
	end
endmodule // test4Core_xori