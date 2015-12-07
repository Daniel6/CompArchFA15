/*
	Test jumping capability of 4 core processor
*/
module test4Core_jump #(parameter instructions_root = "./instructions/",
						parameter waveforms_root = "./waveforms/");
	reg clk;
	reg[31:0] expected_pc;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "jump.dat"})) DUT2 (.clk(clk));

	initial begin
		$dumpfile({waveforms_root, "j.vcd"}); //dump info to create wave propagation later
        $dumpvars(0, test4Core_jump);
		expected_pc = 32'd8;
		#2;
		if (DUT2.pcOut !== expected_pc) begin
			$write("%c[31m",27);
			$display("4 Core J test failed. Expected PC %d but ended at %d", expected_pc, DUT2.pcOut);
			$write("%c[0m",27);
		end
		else begin
			$write("%c[32m",27);
			$display("4 Core J test passed.");
			$write("%c[0m",27);
		end
		$finish;
	end
endmodule // test4Core_jump