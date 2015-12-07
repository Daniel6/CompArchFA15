/*
	Test jumping capability of 4 core processor
*/
module test4Core_jump #(parameter instructions_root = "./instructions/");
	reg clk;
	reg[31:0] expected_pc;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "jump.dat"})) DUT2 (.clk(clk));

	initial begin
		$dumpfile("cpu2.vcd"); //dump info to create wave propagation later
        $dumpvars(0, test4Core_jump);
		expected_pc = 32'd8;
		#2;
		if (DUT2.pcOut !== expected_pc) begin
			$display("4 Core J test failed. Expected PC %d but ended at %d", expected_pc, DUT2.pcOut);
		end
		else begin
			$display("4 Core J test passed.");
		end
		$finish;
	end
endmodule // test4Core_jump