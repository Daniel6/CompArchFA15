/*
	Test division assembly program
*/
module testDivision #(parameter instructions_root = "./instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "division.dat"})) DUT1 (.clk(clk));

	initial begin
		$dumpfile("division.vcd"); //dump info to create wave propagation later
        $dumpvars(0, testDivision);
		#24;
		if (DUT1.regfile.registers[2] !== 32'd2 ||
			DUT1.regfile.registers[3] !== 32'd1) begin
			$write("%c[31m",27);
			$display("Division test failed.");
			$write("%c[0m",27);
		end
		else begin
			$write("%c[32m",27);
			$display("Division test passed.");
			$write("%c[0m",27);
		end
		$finish;
 	end
endmodule
