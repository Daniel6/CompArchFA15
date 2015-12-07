/*
	Test LW functionality of 4 core processor
	manually assign values to 4 memory addresses
	load those 4 memory addresses into register file
*/
module test4Core_LoadWord #(parameter instructions_root = "./instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "load-4-cores.dat"})) DUT5 (.clk(clk));
	initial begin
		$dumpfile("cpu5.vcd"); //dump info to create wave propagation later
        $dumpvars(0, test4Core_LoadWord);
		DUT5.dm.memory[0] = 32'd100;
		DUT5.dm.memory[1] = 32'd101;
		DUT5.dm.memory[2] = 32'd102;
		DUT5.dm.memory[3] = 32'd103;
		#4;
		if (DUT5.regfile.registers[12] !== DUT5.dm.memory[0] ||
			DUT5.regfile.registers[13] !== DUT5.dm.memory[1] ||
			DUT5.regfile.registers[14] !== DUT5.dm.memory[2] ||
			DUT5.regfile.registers[15] !== DUT5.dm.memory[3]) begin
			$write("%c[31m",27);
			$display("4 Core LW test failed.");
			$write("%c[0m",27);
		end
		else begin
			$write("%c[32m",27);
			$display("4 Core LW test passed.");
			$write("%c[0m",27);
		end
		$finish;
	end
endmodule // test4Core_LoadWord