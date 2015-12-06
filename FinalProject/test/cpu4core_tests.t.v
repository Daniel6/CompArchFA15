/*
	Test addition capability of 4 core processor
*/
module test4Core_Addition #(parameter instructions_root = "../instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu DUT #(.cores(4), .instruction_file({instructions_root, "4core_addition_test.dat"})) (.clk(clk));

	initial begin
		#8;
		if (cpu.registerfile.registers[12] !== 32'd4 ||
			cpu.registerfile.registers[13] !== 32'd5 ||
			cpu.registerfile.registers[14] !== 32'd3 ||
			cpu.registerfile.registers[15] !== 32'd2) begin
			$display("4 Core Addition test failed.");
		end
 	end
endmodule

/*
	Test jumping capability of 4 core processor
*/
module test4Core_jump #(parameter instructions_root = "../instructions/");
	reg clk;
	reg expected_pc;
	initial clk = 0;
	always #1 clk = !clk;

	cpu DUT #(.cores(4), .instruction_file({instructions_root, "jump.dat"})) (.clk(clk));

	initial begin
		expected_pc = 32'd8;
		#2;
		if (cpu.pc !== expected_pc) begin
			$display("4 Core Jump test failed. Expected PC %d but ended at %d", expected_pc, cpu.pc);
		end
	end
end

/*
	Test XOR Immediate functionality of 4 core processor
	XORI is mainly used to assign values to registers since we don't have ADD Immediate
*/
module test4Core_xori #(parameter instructions_root = "../instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu DUT #(.cores(4), .instruction_file({instructions_root, "xori.dat"})) (.clk(clk));

	initial begin
		#4;
		if (cpu.registerfile.registers[9] !== 32'd1 ||
			cpu.registerfile.registers[10] !== 32'd2 ||
			cpu.registerfile.registers[11] !== 32'd2 ||
			cpu.registerfile.registers[12] !== 32'd6) begin
			$display("4 Core XORI test failed.");
		end
	end
endmodule
