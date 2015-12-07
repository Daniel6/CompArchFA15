/*
	Test SLT functionality of 4 core processor
	compare two values and store either 1 or 0 in the result register representing boolean value of lessthan comparator
*/
module test4Core_SetLessThan #(parameter instructions_root = "./instructions/",
							   parameter waveforms_root = "./waveforms/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "slt-4-cores.dat"})) DUT11 (.clk(clk));
	initial begin
		$dumpfile({waveforms_root, "slt.vcd"}); //dump info to create wave propagation later
        $dumpvars(0, test4Core_SetLessThan);
		#4;
		if (DUT11.regfile.registers[12] !== 32'd1 ||
			DUT11.regfile.registers[13] !== 32'd0 ||
			DUT11.regfile.registers[14] !== 32'd0 ||
			DUT11.regfile.registers[15] !== 32'd0) begin
			$write("%c[31m",27);
			$display("4 Core SLT test failed.");
			$write("%c[0m",27);
		end
		else begin
			$write("%c[32m",27);
			$display("4 Core SLT test passed.");
			$write("%c[0m",27);
		end
		$finish;
	end
endmodule // test4Core_SetLessThan
