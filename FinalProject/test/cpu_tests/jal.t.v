/*
	Test JAL functionality of 4 core processor
	similar to JR, but also stores PC+4 in register 31
	Note: Usually in MIPS, the value assigned to register 31 is PC+8 since the instruction at PC+4 gets executed regardless 
		  of the jump due to pipelining of the CPU, but in our architecture we do not have pipelining, so the instruction at 
		  PC+4 does not get executed before the jump happens.
*/
module test4Core_JumpAndLink #(parameter instructions_root = "./instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "jump-and-link.dat"})) DUT8 (.clk(clk));
	initial begin
		$dumpfile("cpu8.vcd"); //dump info to create wave propagation later
        $dumpvars(0, test4Core_JumpAndLink);
		#2;
		if (DUT8.pcOut !== 32'd8 ||
			DUT8.regfile.registers[31] !== 32'd4) begin
			$write("%c[31m",27);
			$display("4 Core JAL test failed.");
			$write("%c[35m",27);
			$display("PC should be %d, got %d", 32'd8, DUT8.pcOut);
			$display("Reg should be %d, got %d", 32'd4, DUT8.regfile.registers[31]);
			$write("%c[0m",27);
		end
		else begin
			$display("4 Core JAL test passed.");
			$write("%c[0m",27);
		end
		$finish;
	end
endmodule // test4Core_JumpAndLink