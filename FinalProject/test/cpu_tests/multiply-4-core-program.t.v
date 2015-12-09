/*
	Test SUB functionality of 4 core processor
*/
module test4Core_multiply #(parameter instructions_root = "./instructions/",
							   parameter waveforms_root = "./waveforms/");
	reg clk;
	initial clk = 1;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "test"})) DUT4 (.clk(clk));

	initial begin
		$dumpfile({waveforms_root, "multiply.vcd"}); //dump info to create wave propagation later
        $dumpvars(0, test4Core_multiply);
        #4
		if (DUT4.regfile.registers[2] !== 32'd10 ||
			DUT4.regfile.registers[4] !== 32'd6) begin
			$display("%d", DUT4.regfile.registers[29]);
			$write("%c[31m",27);
			$display("4 Core MULTIPLY test failed.");
			$write("%c[0m",27);
		end
		else begin
			$write("%c[32m",27);
			$display("4 Core MULTIPLY test passed.");
			$write("%c[0m",27);
		end

		$finish;
	end
endmodule // test4Core_Subtraction