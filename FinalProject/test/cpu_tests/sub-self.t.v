/*
	Test addition capability of 4 core processor
*/
module test4Core_SelfSubtraction #(parameter instructions_root = "./instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "sub-self.dat"})) DUT1 (.clk(clk));

	initial begin
		$dumpfile("sub-self.vcd"); //dump info to create wave propagation later
        $dumpvars(0, test4Core_SelfSubtraction);
		#4;
		if (DUT1.regfile.registers[11] !== 32'd3 ||
			DUT1.regfile.registers[12] !== 32'd1 ||
			DUT1.regfile.registers[13] !== 32'd1 ||
			DUT1.regfile.registers[14] !== 32'd0) begin
			$write("%c[31m",27);
			$display("4 Core SUB SELF test failed.");
			$display("%b", DUT1.regfile.registers[11]);
			$display("%b", DUT1.regfile.registers[12]);
			$display("%b", DUT1.regfile.registers[13]);
			$display("%b", DUT1.regfile.registers[14]);
			$write("%c[0m",27);
		end
		else begin
			$write("%c[32m",27);
			$display("4 Core SUB SELF test passed.");
			$write("%c[0m",27);
		end
		$finish;
 	end
endmodule // test4Core_Addition
