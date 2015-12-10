/*
	Tests sorting an array to highest to lowest value
*/
module test1Core_Sort #(parameter instructions_root = "./instructions/",
								  parameter waveforms_root = "./waveforms/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(1), .instruction_file({instructions_root, "sort-array-1-core.dat"})) DUT_SortArray_1_core (.clk(clk));
	always @(DUT_SortArray_1_core.dm.memory[0]) begin
	    	$display("MEM[0]: %d", DUT_SortArray_1_core.dm.memory[0]);
	        $display("PC: %d", DUT_SortArray_1_core.pcOut);
	        
	        $display(" ");
	end

	always @(DUT_SortArray_1_core.dm.memory[1]) begin
	    	$display("MEM[1]: %d", DUT_SortArray_1_core.dm.memory[1]);
	        $display("PC: %d", DUT_SortArray_1_core.pcOut);
	        $display(" ");
	end

	always @(DUT_SortArray_1_core.dm.memory[2]) begin
	    	$display("MEM[2]: %d", DUT_SortArray_1_core.dm.memory[2]);
	        $display("PC: %d", DUT_SortArray_1_core.pcOut);
	        $display(" ");
	end

	always @(DUT_SortArray_1_core.dm.memory[3]) begin
	    	$display("MEM[3]: %d", DUT_SortArray_1_core.dm.memory[3]);
	        $display("PC: %d", DUT_SortArray_1_core.pcOut);
	        $display(" ");
	end

	always @(DUT_SortArray_1_core.dm.memory[4]) begin
	    	$display("MEM[4]: %d", DUT_SortArray_1_core.dm.memory[4]);
	        $display("PC: %d", DUT_SortArray_1_core.pcOut);
	        $display(" ");
	end

	always @(DUT_SortArray_1_core.dm.memory[5]) begin
	    	$display("MEM[5]: %d", DUT_SortArray_1_core.dm.memory[5]);
	        $display("PC: %d", DUT_SortArray_1_core.pcOut);
	        $display(" ");
	end

	always @(DUT_SortArray_1_core.dm.memory[6]) begin
	    	$display("MEM[6]: %d", DUT_SortArray_1_core.dm.memory[6]);
	        $display("PC: %d", DUT_SortArray_1_core.pcOut);
	        $display(" ");
	end

	always @(DUT_SortArray_1_core.dm.memory[7]) begin
	    	$display("MEM[7]: %d", DUT_SortArray_1_core.dm.memory[7]);
	        $display("PC: %d", DUT_SortArray_1_core.pcOut);
	        $display(" ");
	end

	always @(DUT_SortArray_1_core.dm.memory[8]) begin
	    	$display("MEM[8]: %d", DUT_SortArray_1_core.dm.memory[8]);
	        $display("PC: %d", DUT_SortArray_1_core.pcOut);
	        $display(" ");
	end

	always @(DUT_SortArray_1_core.dm.memory[9]) begin
	    	$display("MEM[9]: %d", DUT_SortArray_1_core.dm.memory[9]);
	        $display("PC: %d", DUT_SortArray_1_core.pcOut);
	        $display(" ");
	end

	initial begin
		$dumpfile({waveforms_root, "sort-array-1-core.vcd"}); //dump info to create wave propagation later
        $dumpvars(0, test1Core_Sort);
        DUT_SortArray_1_core.dm.memory[0] = 32'd14;
		DUT_SortArray_1_core.dm.memory[1] = 32'd12;
		DUT_SortArray_1_core.dm.memory[2] = 32'd13;
		DUT_SortArray_1_core.dm.memory[3] = 32'd5;
		DUT_SortArray_1_core.dm.memory[4] = 32'd9;
		DUT_SortArray_1_core.dm.memory[5] = 32'd11;
		DUT_SortArray_1_core.dm.memory[6] = 32'd3;
		DUT_SortArray_1_core.dm.memory[7] = 32'd6;
		DUT_SortArray_1_core.dm.memory[8] = 32'd7;
		DUT_SortArray_1_core.dm.memory[9] = 32'd10;

		#400;
		if (DUT_SortArray_1_core.dm.memory[0] !== 32'd14 ||
			DUT_SortArray_1_core.dm.memory[1] !== 32'd13 ||
			DUT_SortArray_1_core.dm.memory[2] !== 32'd12 ||
			DUT_SortArray_1_core.dm.memory[3] !== 32'd11 ||
			DUT_SortArray_1_core.dm.memory[4] !== 32'd10 ||
			DUT_SortArray_1_core.dm.memory[5] !== 32'd9 ||
			DUT_SortArray_1_core.dm.memory[6] !== 32'd7 ||
			DUT_SortArray_1_core.dm.memory[7] !== 32'd6 ||
			DUT_SortArray_1_core.dm.memory[8] !== 32'd5 ||
			DUT_SortArray_1_core.dm.memory[9] !== 32'd3) begin
			$write("%c[31m",27);
			$display("1 Core Sort test failed expected 14 13 12 11 10 9 7 6 5 3, got %d %d %d %d %d %d %d %d %d %d", DUT_SortArray_1_core.dm.memory[0], DUT_SortArray_1_core.dm.memory[1],DUT_SortArray_1_core.dm.memory[2],DUT_SortArray_1_core.dm.memory[3],DUT_SortArray_1_core.dm.memory[4],DUT_SortArray_1_core.dm.memory[5],DUT_SortArray_1_core.dm.memory[6],DUT_SortArray_1_core.dm.memory[7],DUT_SortArray_1_core.dm.memory[8], DUT_SortArray_1_core.dm.memory[9]);
			$write("%c[0m",27);
		end
		else begin
			$write("%c[32m",27);
			$display("4 Core Sort test passed");
			$write("%c[0m",27);
		end

		$finish;
	end
endmodule // test1Core_Sort