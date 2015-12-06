/*
	Test addition capability of 4 core processor
*/
module test4Core_Addition #(parameter instructions_root = "../instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu DUT #(.cores(4), .instruction_file({instructions_root, "add-4-cores.dat"})) (.clk(clk));

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

	cpu DUT #(.cores(4), .instruction_file({instructions_root, "xori-4-cores.dat"})) (.clk(clk));

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

/*
	Test SUB functionality of 4 core processor
*/
module test4Core_Subtraction #(parameter instructions_root = "../instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu DUT #(.cores(4), .instruction_file({instructions_root, "sub-4-cores.dat"})) (.clk(clk));

	initial begin
		#4;
		if (cpu.registerfile.registers[12] !== 32'd2 ||
			cpu.registerfile.registers[13] !== 32'd1 ||
			cpu.registerfile.registers[14] !== 32'd1 ||
			cpu.registerfile.registers[15] !== 32'd0) begin
			$display("4 Core SUB test failed.");
		end
	end
endmodule

/*
	Test LW functionality of 4 core processor
	manually assign values to 4 memory addresses
	load those 4 memory addresses into register file
*/
module test4Core_LoadWord #(parameter instructions_root = "../instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu DUT #(.cores(4), .instruction_file({instructions_root, "load-4-cores.dat"})) (.clk(clk));
	initial begin
		cpu.datamemory.memory[0] = 32'd100;
		cpu.datamemory.memory[1] = 32'd101;
		cpu.datamemory.memory[2] = 32'd102;
		cpu.datamemory.memory[3] = 32'd103;
		#4;
		if (cpu.registerfile.registers[12] !== cpu.datamemory.memory[0] ||
			cpu.registerfile.registers[13] !== cpu.datamemory.memory[1] ||
			cpu.registerfile.registers[14] !== cpu.datamemory.memory[2] ||
			cpu.registerfile.registers[15] !== cpu.datamemory.memory[3]) begin
			$display("4 Core LW test failed.");
		end
	end
endmodule

/*
	Test SW functionality of 4 core processor
*/
module test4Core_StoreWord #(parameter instructions_root = "../instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu DUT #(.cores(4), .instruction_file({instructions_root, "store-4-cores.dat"})) (.clk(clk));
	initial begin
		#4;
		if (cpu.datamemory.memory[0] !== 32'd3 ||
			cpu.datamemory.memory[1] !== 32'd2 ||
			cpu.datamemory.memory[2] !== 32'd1 ||
			cpu.datamemory.memory[3] !== 32'd0) begin
			$display("4 Core SW test failed.");
		end
	end
endmodule

/*
	Test JR functionality of 4 core processor
	similar to J, but jumps to an absolute address
*/
module test4Core_JumpRegister #(parameter instructions_root = "../instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu DUT #(.cores(4), .instruction_file({instructions_root, "jump-register.dat"})) (.clk(clk));
	initial begin
		#4;
		if (cpu.pc !== 32'd12) begin
			$display("4 Core JR test failed.");
		end
	end
endmodule

/*
	Test JAL functionality of 4 core processor
	similar to JR, but also stores PC+4 in register 31
	Note: Usually in MIPS, the value assigned to register 31 is PC+8 since the instruction at PC+4 gets executed regardless 
		  of the jump due to pipelining of the CPU, but in our architecture we do not have pipelining, so the instruction at 
		  PC+4 does not get executed before the jump happens.
*/
module test4Core_JumpAndLink #(parameter instructions_root = "../instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu DUT #(.cores(4), .instruction_file({instructions_root, "jump-and-link.dat"})) (.clk(clk));
	initial begin
		#2;
		if (cpu.pc !== 32'd8 ||
			cpu.registerfile.registers[31] !== 32'd4) begin
			$display("4 Core JR test failed.");
		end
	end
endmodule

/*
	Test BNE functionality of 4 core processor
	jumps if two values are not equal to each other
*/
module test4Core_BranchNotEqual #(parameter instructions_root = "../instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu DUT #(.cores(4), .instruction_file({instructions_root, "branch-not-equal.dat"})) (.clk(clk));
	initial begin
		#4;
		if (cpu.pc !== 32'd12) begin
			$display("4 Core BNE test failed.");
		end
	end
endmodule

/*
	Test BEQ functionality of 4 core processor
	similar to BNE but tests for equality instead of inequality
*/
module test4Core_BranchEqual #(parameter instructions_root = "../instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu DUT #(.cores(4), .instruction_file({instructions_root, "branch-equal.dat"})) (.clk(clk));
	initial begin
		#4;
		if (cpu.pc !== 32'd12) begin
			$display("4 Core BEQ test failed.");
		end
	end
endmodule

/*
	Test SLT functionality of 4 core processor
	compare two values and store either 1 or 0 in the result register representing boolean value of lessthan comparator
*/
module test4Core_SignedLessThan #(parameter instructions_root = "../instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu DUT #(.cores(4), .instruction_file({instructions_root, "slt.dat"})) (.clk(clk));
	initial begin
		#4;
		if (cpu.registerfile.registers[2] !== 32'd1) begin
			$display("4 Core SLT test failed.");
		end
	end
endmodule
