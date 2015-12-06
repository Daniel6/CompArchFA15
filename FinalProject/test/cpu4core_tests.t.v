/*
	Test addition capability of 4 core processor
*/
module test4Core_Addition #(parameter instructions_root = "../instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "add-4-cores.dat"})) DUT1 (.clk(clk));

	initial begin
		$dumpfile("cpu1.vcd"); //dump info to create wave propagation later
        $dumpvars(0, test4Core_Addition);
		#8;
		if (DUT1.regfile.registers[12] !== 32'd4 ||
			DUT1.regfile.registers[13] !== 32'd5 ||
			DUT1.regfile.registers[14] !== 32'd3 ||
			DUT1.regfile.registers[15] !== 32'd2) begin
			$display("4 Core ADD test failed.");
		end
		else begin
			$display("4 Core ADD test passed.");
		end
		$finish;
 	end
endmodule // test4Core_Addition

// /*
// 	Test jumping capability of 4 core processor
// */
// module test4Core_jump #(parameter instructions_root = "../instructions/");
// 	reg clk;
// 	reg expected_pc;
// 	initial clk = 0;
// 	always #1 clk = !clk;

// 	cpu #(.cores(4), .instruction_file({instructions_root, "jump.dat"})) DUT2 (.clk(clk));

// 	initial begin
// 		$dumpfile("cpu2.vcd"); //dump info to create wave propagation later
//         $dumpvars(0, test4Core_jump);
// 		expected_pc = 32'd8;
// 		#2;
// 		if (DUT2.pc !== expected_pc) begin
// 			$display("4 Core J test failed. Expected PC %d but ended at %d", expected_pc, DUT2.pc);
// 		end
// 		else begin
// 			$display("4 Core J test passed.");
// 		end
// 		$finish;
// 	end
// endmodule // test4Core_jump

// /*
// 	Test XOR Immediate functionality of 4 core processor
// 	XORI is mainly used to assign values to registers since we don't have ADD Immediate
// */
// module test4Core_xori #(parameter instructions_root = "../instructions/");
// 	reg clk;
// 	initial clk = 0;
// 	always #1 clk = !clk;

// 	cpu #(.cores(4), .instruction_file({instructions_root, "xori-4-cores.dat"})) DUT3 (.clk(clk));

// 	initial begin
// 		$dumpfile("cpu3.vcd"); //dump info to create wave propagation later
//         $dumpvars(0, test4Core_xori);
// 		#4;
// 		if (DUT3.regfile.registers[9] !== 32'd1 ||
// 			DUT3.regfile.registers[10] !== 32'd2 ||
// 			DUT3.regfile.registers[11] !== 32'd2 ||
// 			DUT3.regfile.registers[12] !== 32'd6) begin
// 			$display("4 Core XORI test failed.");
// 		end
// 		else begin
// 			$display("4 Core XORI test passed.");
// 		end
// 		$finish;
// 	end
// endmodule // test4Core_xori

// /*
// 	Test SUB functionality of 4 core processor
// */
// module test4Core_Subtraction #(parameter instructions_root = "../instructions/");
// 	reg clk;
// 	initial clk = 0;
// 	always #1 clk = !clk;

// 	cpu #(.cores(4), .instruction_file({instructions_root, "sub-4-cores.dat"})) DUT4 (.clk(clk));

// 	initial begin
// 		$dumpfile("cpu4.vcd"); //dump info to create wave propagation later
//         $dumpvars(0, test4Core_Subtraction);
// 		#4;
// 		if (DUT4.regfile.registers[12] !== 32'd2 ||
// 			DUT4.regfile.registers[13] !== 32'd1 ||
// 			DUT4.regfile.registers[14] !== 32'd1 ||
// 			DUT4.regfile.registers[15] !== 32'd0) begin
// 			$display("4 Core SUB test failed.");
// 		end
// 		else begin
// 			$display("4 Core SUB test passed.");
// 		end
// 		$finish;
// 	end
// endmodule // test4Core_Subtraction

// /*
// 	Test LW functionality of 4 core processor
// 	manually assign values to 4 memory addresses
// 	load those 4 memory addresses into register file
// */
// module test4Core_LoadWord #(parameter instructions_root = "../instructions/");
// 	reg clk;
// 	initial clk = 0;
// 	always #1 clk = !clk;

// 	cpu #(.cores(4), .instruction_file({instructions_root, "load-4-cores.dat"})) DUT5 (.clk(clk));
// 	initial begin
// 		$dumpfile("cpu5.vcd"); //dump info to create wave propagation later
//         $dumpvars(0, test4Core_LoadWord);
// 		DUT5.dm.memory[0] = 32'd100;
// 		DUT5.dm.memory[1] = 32'd101;
// 		DUT5.dm.memory[2] = 32'd102;
// 		DUT5.dm.memory[3] = 32'd103;
// 		#4;
// 		if (DUT5.regfile.registers[12] !== DUT5.dm.memory[0] ||
// 			DUT5.regfile.registers[13] !== DUT5.dm.memory[1] ||
// 			DUT5.regfile.registers[14] !== DUT5.dm.memory[2] ||
// 			DUT5.regfile.registers[15] !== DUT5.dm.memory[3]) begin
// 			$display("4 Core LW test failed.");
// 		end
// 		else begin
// 			$display("4 Core LW test passed.");
// 		end
// 		$finish;
// 	end
// endmodule // test4Core_LoadWord

// /*
// 	Test SW functionality of 4 core processor
// */
// module test4Core_StoreWord #(parameter instructions_root = "../instructions/");
// 	reg clk;
// 	initial clk = 0;
// 	always #1 clk = !clk;

// 	cpu #(.cores(4), .instruction_file({instructions_root, "store-4-cores.dat"})) DUT6 (.clk(clk));
// 	initial begin
// 		$dumpfile("cpu6.vcd"); //dump info to create wave propagation later
//         $dumpvars(0, test4Core_StoreWord);
// 		#4;
// 		if (DUT6.dm.memory[0] !== 32'd3 ||
// 			DUT6.dm.memory[1] !== 32'd2 ||
// 			DUT6.dm.memory[2] !== 32'd1 ||
// 			DUT6.dm.memory[3] !== 32'd0) begin
// 			$display("4 Core SW test failed.");
// 		end
// 		else begin
// 			$display("4 Core SW test passed.");
// 		end
// 		$finish;
// 	end
// endmodule // test4Core_StoreWord

// /*
// 	Test JR functionality of 4 core processor
// 	similar to J, but jumps to an absolute address
// */
// module test4Core_JumpRegister #(parameter instructions_root = "../instructions/");
// 	reg clk;
// 	initial clk = 0;
// 	always #1 clk = !clk;

// 	cpu #(.cores(4), .instruction_file({instructions_root, "jump-register.dat"})) DUT7 (.clk(clk));
// 	initial begin
// 		$dumpfile("cpu7.vcd"); //dump info to create wave propagation later
//         $dumpvars(0, test4Core_JumpRegister);
// 		#4;
// 		if (DUT7.pc !== 32'd12) begin
// 			$display("4 Core JR test failed.");
// 		end
// 		else begin
// 			$display("4 Core JR test passed.");
// 		end
// 		$finish;
// 	end
// endmodule // test4Core_JumpRegister

// /*
// 	Test JAL functionality of 4 core processor
// 	similar to JR, but also stores PC+4 in register 31
// 	Note: Usually in MIPS, the value assigned to register 31 is PC+8 since the instruction at PC+4 gets executed regardless 
// 		  of the jump due to pipelining of the CPU, but in our architecture we do not have pipelining, so the instruction at 
// 		  PC+4 does not get executed before the jump happens.
// */
// module test4Core_JumpAndLink #(parameter instructions_root = "../instructions/");
// 	reg clk;
// 	initial clk = 0;
// 	always #1 clk = !clk;

// 	cpu #(.cores(4), .instruction_file({instructions_root, "jump-and-link.dat"})) DUT8 (.clk(clk));
// 	initial begin
// 		$dumpfile("cpu8.vcd"); //dump info to create wave propagation later
//         $dumpvars(0, test4Core_JumpAndLink);
// 		#2;
// 		if (DUT8.pc !== 32'd8 ||
// 			DUT8.regfile.registers[31] !== 32'd4) begin
// 			$display("4 Core JR test failed.");
// 		end
// 		else begin
// 			$display("4 Core JR test passed.");
// 		end
// 		$finish;
// 	end
// endmodule // test4Core_JumpAndLink

// /*
// 	Test BNE functionality of 4 core processor
// 	jumps if two values are not equal to each other
// */
// module test4Core_BranchNotEqual #(parameter instructions_root = "../instructions/");
// 	reg clk;
// 	initial clk = 0;
// 	always #1 clk = !clk;

// 	cpu #(.cores(4), .instruction_file({instructions_root, "branch-not-equal.dat"})) DUT9 (.clk(clk));
// 	initial begin
// 		$dumpfile("cpu9.vcd"); //dump info to create wave propagation later
//         $dumpvars(0, test4Core_BranchNotEqual);
// 		#4;
// 		if (DUT9.pc !== 32'd12) begin
// 			$display("4 Core BNE test failed.");
// 		end
// 		else begin
// 			$display("4 Core BNE test passed.");
// 		end
// 		$finish;
// 	end
// endmodule // test4Core_BranchNotEqual

// /*
// 	Test BEQ functionality of 4 core processor
// 	similar to BNE but tests for equality instead of inequality
// */
// module test4Core_BranchEqual #(parameter instructions_root = "../instructions/");
// 	reg clk;
// 	initial clk = 0;
// 	always #1 clk = !clk;

// 	cpu #(.cores(4), .instruction_file({instructions_root, "branch-equal.dat"})) DUT10 (.clk(clk));
// 	initial begin
// 		$dumpfile("cpu10.vcd"); //dump info to create wave propagation later
//         $dumpvars(0, test4Core_BranchEqual);
// 		#4;
// 		if (DUT10.pc !== 32'd12) begin
// 			$display("4 Core BEQ test failed.");
// 		end
// 		else begin
// 			$display("4 Core BEQ test passed.");
// 		end
// 		$finish;
// 	end
// endmodule // test4Core_BranchEqual

// /*
// 	Test SLT functionality of 4 core processor
// 	compare two values and store either 1 or 0 in the result register representing boolean value of lessthan comparator
// */
// module test4Core_SetLessThan #(parameter instructions_root = "../instructions/");
// 	reg clk;
// 	initial clk = 0;
// 	always #1 clk = !clk;

// 	cpu #(.cores(4), .instruction_file({instructions_root, "slt-4-cores.dat"})) DUT11 (.clk(clk));
// 	initial begin
// 		$dumpfile("cpu11.vcd"); //dump info to create wave propagation later
//         $dumpvars(0, test4Core_SetLessThan);
// 		#4;
// 		if (DUT11.regfile.registers[12] !== 32'd1 ||
// 			DUT11.regfile.registers[13] !== 32'd0 ||
// 			DUT11.regfile.registers[14] !== 32'd0 ||
// 			DUT11.regfile.registers[15] !== 32'd0) begin
// 			$display("4 Core SLT test failed.");
// 		end
// 		else begin
// 			$display("4 Core SLT test passed.");
// 		end
// 		$finish;
// 	end
// endmodule // test4Core_SetLessThan
