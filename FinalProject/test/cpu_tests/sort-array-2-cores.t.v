/*
	Tests sorting an array to highest to lowest value
*/
module test2Core_Sort #(parameter instructions_root = "./instructions/",
								  parameter waveforms_root = "./waveforms/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(2), .instruction_file({instructions_root, "sort-array-2-cores.dat"})) DUT_SortArray_2_core (.clk(clk));

	initial begin
		$dumpfile({waveforms_root, "sort-array-2-cores.vcd"}); //dump info to create wave propagation later
        $dumpvars(0, test2Core_Sort);
        DUT_SortArray_2_core.dm.memory[0] = 32'd14;
		DUT_SortArray_2_core.dm.memory[1] = 32'd12;
		DUT_SortArray_2_core.dm.memory[2] = 32'd13;
		DUT_SortArray_2_core.dm.memory[3] = 32'd5;
		DUT_SortArray_2_core.dm.memory[4] = 32'd9;
		DUT_SortArray_2_core.dm.memory[5] = 32'd11;
		DUT_SortArray_2_core.dm.memory[6] = 32'd3;
		DUT_SortArray_2_core.dm.memory[7] = 32'd6;
		DUT_SortArray_2_core.dm.memory[8] = 32'd7;
		DUT_SortArray_2_core.dm.memory[9] = 32'd10;

		#1400;
		if (DUT_SortArray_2_core.dm.memory[0] !== 32'd14 ||
			DUT_SortArray_2_core.dm.memory[1] !== 32'd13 ||
			DUT_SortArray_2_core.dm.memory[2] !== 32'd12 ||
			DUT_SortArray_2_core.dm.memory[3] !== 32'd11 ||
			DUT_SortArray_2_core.dm.memory[4] !== 32'd10 ||
			DUT_SortArray_2_core.dm.memory[5] !== 32'd9 ||
			DUT_SortArray_2_core.dm.memory[6] !== 32'd7 ||
			DUT_SortArray_2_core.dm.memory[7] !== 32'd6 ||
			DUT_SortArray_2_core.dm.memory[8] !== 32'd5 ||
			DUT_SortArray_2_core.dm.memory[9] !== 32'd3) begin
			$write("%c[31m",27);
			$display("2 Core Sort test failed expected 14 13 12 11 10 9 7 6 5 3, got %d %d %d %d %d %d %d %d %d %d", DUT_SortArray_2_core.dm.memory[0], DUT_SortArray_2_core.dm.memory[1],DUT_SortArray_2_core.dm.memory[2],DUT_SortArray_2_core.dm.memory[3],DUT_SortArray_2_core.dm.memory[4],DUT_SortArray_2_core.dm.memory[5],DUT_SortArray_2_core.dm.memory[6],DUT_SortArray_2_core.dm.memory[7],DUT_SortArray_2_core.dm.memory[8], DUT_SortArray_2_core.dm.memory[9]);
			$write("%c[0m",27);
		end
		else begin
			$write("%c[32m",27);
			$display("2 Core Sort test passed");
			$write("%c[0m",27);
		end

		$finish;
	end
endmodule // test2Core_Sort