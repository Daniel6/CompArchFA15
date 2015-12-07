/*
	Test JR functionality of 4 core processor
	similar to J, but jumps to an absolute address
*/
module test4Core_JumpRegister #(parameter instructions_root = "./instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "jump-register.dat"})) DUT7 (.clk(clk));
	initial begin
		$dumpfile("cpu7.vcd"); //dump info to create wave propagation later
        $dumpvars(0, test4Core_JumpRegister);
		#4;
		if (DUT7.pcOut !== 32'd12) begin
			$display("4 Core JR test failed. Expected PC %d, got %d", DUT7.pcOut, 32'd12);
		end
		else begin
			$display("4 Core JR test passed.");
		end
		$finish;
	end
endmodule // test4Core_JumpRegister