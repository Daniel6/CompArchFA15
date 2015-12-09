/*
	Test addition capability of 4 core processor
*/
module test4Core_SelfAddition #(parameter instructions_root = "./instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "add-self.dat"})) DUT1 (.clk(clk));

	initial begin
		$dumpfile("add-self.vcd"); //dump info to create wave propagation later
        $dumpvars(0, test4Core_SelfAddition);
		#4;
		if (DUT1.regfile.registers[11] !== 32'd6 ||
			DUT1.regfile.registers[12] !== 32'd8 ||
			DUT1.regfile.registers[13] !== 32'd10 ||
			DUT1.regfile.registers[14] !== 32'd12) begin
			$write("%c[31m",27);
			$display("4 Core ADD SELF test failed.");
			$display("%b", DUT1.regfile.registers[11]);
			$display("%b", DUT1.regfile.registers[12]);
			$display("%b", DUT1.regfile.registers[13]);
			$display("%b", DUT1.regfile.registers[14]);
			$write("%c[0m",27);
		end
		else begin
			$write("%c[32m",27);
			$display("4 Core ADD SELF test passed.");
			$write("%c[0m",27);
		end
		$finish;
 	end
endmodule // test4Core_Addition
