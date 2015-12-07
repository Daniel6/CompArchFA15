/*
	Test SW functionality of 4 core processor
*/
module test4Core_StoreWord #(parameter instructions_root = "./instructions/",
							 parameter waveforms_root = "./waveforms/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "store-4-cores.dat"})) DUT6 (.clk(clk));
	initial begin
		$dumpfile({waveforms_root, "sw.vcd"}); //dump info to create wave propagation later
        $dumpvars(0, test4Core_StoreWord);
		#4;
		if (DUT6.dm.memory[0] !== 32'd3 ||
			DUT6.dm.memory[1] !== 32'd2 ||
			DUT6.dm.memory[2] !== 32'd1 ||
			DUT6.dm.memory[3] !== 32'd0) begin
			$write("%c[31m",27);
			$display("4 Core SW test failed.");
			$write("%c[0m",27);
		end
		else begin
			$write("%c[32m",27);
			$display("4 Core SW test passed.");
			$write("%c[0m",27);
		end
		$finish;
	end
endmodule // test4Core_StoreWord