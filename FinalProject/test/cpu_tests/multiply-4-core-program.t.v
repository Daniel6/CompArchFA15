/*
	Test Multiply functionality of 4 core processor
	17 Cycles using 4 core.
	34 cycles using single core.
	50% speed up.
*/
module test4Core_multiply #(parameter instructions_root = "./instructions/",
							   parameter waveforms_root = "./waveforms/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "multass.dat"})) DUT4 (.clk(clk));
	initial begin
		$dumpfile({waveforms_root, "multiply.vcd"}); //dump info to create wave propagation later
        $dumpvars(0, test4Core_multiply);
        DUT4.dm.memory[0] = 32'd1;
		DUT4.dm.memory[1] = 32'd3;
		DUT4.dm.memory[2] = 32'd2;
		DUT4.dm.memory[3] = -3;
		DUT4.dm.memory[4] = 3;
		DUT4.dm.memory[5] = 10;
		DUT4.regfile.registers[3] = 0;
		DUT4.dm.memory[512] = 0;
		DUT4.dm.memory[511] = 0;
		DUT4.dm.memory[510] = 0;
		DUT4.dm.memory[509] = 32'bx;
		#34

		if (DUT4.regfile.registers[2] !== 32'd10 ||
			DUT4.regfile.registers[3] !== 32'd6) begin
			$display("%d", DUT4.regfile.registers[29]);
			$display("%d", DUT4.regfile.registers[31]);
			$display("%d", DUT4.pc.out/4);
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
