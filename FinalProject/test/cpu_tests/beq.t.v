/*
	Test BEQ functionality of 4 core processor
	similar to BNE but tests for equality instead of inequality
*/
module test4Core_BranchEqual #(parameter instructions_root = "./instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "branch-equal.dat"})) DUT10 (.clk(clk));
	initial begin
		$dumpfile("cpu10.vcd"); //dump info to create wave propagation later
        $dumpvars(0, test4Core_BranchEqual);
		#4;
		if (DUT10.pcOut !== 32'd12) begin
			$display("4 Core BEQ test failed.");
		end
		else begin
			$display("4 Core BEQ test passed.");
		end
		$finish;
	end
endmodule // test4Core_BranchEqual