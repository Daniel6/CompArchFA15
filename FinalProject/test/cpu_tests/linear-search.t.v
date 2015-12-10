
/*
	Test Linear Search
*/
module testLinearSearch #(parameter instructions_root = "./instructions/",
						   parameter waveforms_root = "./waveforms/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;
	cpu #(.cores(4), .instruction_file({instructions_root, "linear-search.dat"})) DUT (.clk(clk));

	initial begin
		$dumpfile({waveforms_root, "linear-search.vcd"}); //dump info to create wave propagation later
        $dumpvars(0, testLinearSearch);
        DUT.dm.memory[0] = 32'd1;
        DUT.dm.memory[1] = 32'd2;
        DUT.dm.memory[2] = 32'd3;
        DUT.dm.memory[3] = 32'd4;
        DUT.dm.memory[4] = 32'd5;
        DUT.dm.memory[5] = 32'd6;
        DUT.dm.memory[6] = 32'd7;
        DUT.dm.memory[7] = 32'd8;
        DUT.dm.memory[8] = 32'd9;
        DUT.dm.memory[9] = 32'd10;

        #2;
		if (DUT.regfile.registers[4] !== 5 ||
            DUT.regfile.registers[25] !== 0 ||
            DUT.regfile.registers[27] !== 3 ||
            DUT.regfile.registers[2] !== 0) begin
			$display("Linear Search Failed at 1");
        end

        #2;
		if (DUT.regfile.registers[9] !== 1 ||
            DUT.regfile.registers[10] !== 2 ||
            DUT.regfile.registers[11] !== 3 ||
            DUT.regfile.registers[25] !== 3) begin
			$display("Linear Search Failed at 2");
        end

        #2;
		if (DUT.pc.out !== 4) begin
			$display("Linear Search Failed at 3");
        end

        #2;
		if (DUT.regfile.registers[9] !== 4 ||
            DUT.regfile.registers[10] !== 5 ||
            DUT.regfile.registers[11] !== 6 ||
            DUT.regfile.registers[25] !== 6) begin
			$display("Linear Search Failed at 4");
        end

        #2;
		if (DUT.pc.out !== 20) begin
			$display("Linear Search Failed at 5");
			$display("PC: %b", DUT.pc.out);
        end

        #2;
		if (DUT.regfile.registers[25] !== 3 ||
            DUT.regfile.registers[17] !== 1) begin
			$display("Linear Search Failed at 6");
			$display("t9: %b", DUT.regfile.registers[25]);
			$display("s1: %b", DUT.regfile.registers[17]);
        end

        #2
		if (DUT.regfile.registers[2] !== 4 ||
            DUT.pc.out !== 36) begin
			$write("%c[31m",27);
			$display("Linear Search test failed.");
			$write("%c[0m",27);
			$display("Expected %d, got %d",
				4,
				DUT.regfile.registers[2]);
        end
        else begin
			$write("%c[32m",27);
			$display("Linear Search test passed.");
			$write("%c[0m",27);
        end

        $finish;
    end

endmodule
