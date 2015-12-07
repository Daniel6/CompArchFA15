/*
	Test XOR Immediate functionality of 4 core processor
	XORI is mainly used to assign values to registers since we don't have ADD Immediate
*/
module test4Core_xori #(parameter instructions_root = "./instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "xori-4-cores.dat"})) DUT3 (.clk(clk));

	initial begin
		$dumpfile("cpu3.vcd"); //dump info to create wave propagation later
        $dumpvars(0, test4Core_xori);
		#4;
		if (DUT3.regfile.registers[9] !== 32'd1 ||
			DUT3.regfile.registers[10] !== 32'd2 ||
			DUT3.regfile.registers[11] !== 32'd2 ||
			DUT3.regfile.registers[12] !== 32'd6) begin
			$write("%c[31m",27);
			$display("4 Core XORI test failed.");
			$write("%c[0m",27);
		end
		else begin
			$write("%c[32m",27);
			$display("4 Core XORI test passed.");
			$write("%c[0m",27);
		end
		$finish;
	end
endmodule // test4Core_xori