/*
	Test BNE functionality of 4 core processor
	jumps if two values are not equal to each other
*/
module test4Core_BranchNotEqual #(parameter instructions_root = "./instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "branch-not-equal.dat"})) DUT9 (.clk(clk));
	initial begin
		$dumpfile("cpu9.vcd"); //dump info to create wave propagation later
        $dumpvars(0, test4Core_BranchNotEqual);
		#4;
		if (DUT9.pcOut !== 32'd12) begin
			$display("4 Core BNE test failed expected PC %d, got %d", 32'd12, DUT9.pcOut);
		end
		else begin
			$display("4 Core BNE test passed");
		end
		$finish;
	end
endmodule // test4Core_BranchNotEqual