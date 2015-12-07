/*
	Test SUB functionality of 4 core processor
*/
module test4Core_Subtraction #(parameter instructions_root = "./instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "sub-4-cores.dat"})) DUT4 (.clk(clk));

	initial begin
		$dumpfile("cpu4.vcd"); //dump info to create wave propagation later
        $dumpvars(0, test4Core_Subtraction);
		#4;
		if (DUT4.regfile.registers[12] !== 32'd2 ||
			DUT4.regfile.registers[13] !== 32'd1 ||
			DUT4.regfile.registers[14] !== 32'd1 ||
			DUT4.regfile.registers[15] !== 32'd0) begin
			$display("4 Core SUB test failed.");
		end
		else begin
			$display("4 Core SUB test passed.");
		end
		$finish;
	end
endmodule // test4Core_Subtraction