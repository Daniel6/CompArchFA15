/*
	Test addition capability of 4 core processor
*/
module test4Core_Addition #(parameter instructions_root = "./instructions/",
							parameter waveforms_root = "./waveforms/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "add-4-cores.dat"})) DUT1 (.clk(clk));

	initial begin
		$dumpfile({waveforms_root, "add.vcd"}); //dump info to create wave propagation later
        $dumpvars(0, test4Core_Addition);
		#16;
		if (DUT1.regfile.registers[12] !== 32'd4 ||
			DUT1.regfile.registers[13] !== 32'd5 ||
			DUT1.regfile.registers[14] !== 32'd3 ||
			DUT1.regfile.registers[15] !== 32'd2) begin
			$write("%c[31m",27);
			$display("4 Core ADD test failed.");
			$write("%c[0m",27);
		end
		else begin
			$write("%c[32m",27);
			$display("4 Core ADD test passed.");
			$write("%c[0m",27);
		end
		$finish;
 	end
endmodule // test4Core_Addition