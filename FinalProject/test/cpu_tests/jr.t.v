/*
	Test JR functionality of 4 core processor
	similar to J, but jumps to an absolute address
*/
module test4Core_JumpRegister #(parameter instructions_root = "./instructions/",
							    parameter waveforms_root = "./waveforms/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "jump-register.dat"})) DUT7 (.clk(clk));
	initial begin
		$dumpfile({waveforms_root, "jr.vcd"}); //dump info to create wave propagation later
        $dumpvars(0, test4Core_JumpRegister);
		#4;
		if (DUT7.pcOut !== 32'd12) begin
			$write("%c[31m",27);
			$display("4 Core JR test failed. Expected PC %d, got %d", DUT7.pcOut, 32'd12);
			$write("%c[0m",27);
		end
		else begin
			$write("%c[32m",27);
			$display("4 Core JR test passed.");
			$write("%c[0m",27);
		end
		$finish;
	end
endmodule // test4Core_JumpRegister