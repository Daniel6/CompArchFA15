/*
	Demo Test
*/
module test4Core_Demo #(parameter instructions_root = "./instructions/");
	reg clk;
	initial clk = 0;
	always #1 clk = !clk;

	cpu #(.cores(4), .instruction_file({instructions_root, "dan.dat"})) DUT1 (.clk(clk));

	initial begin
		$dumpfile("demo.vcd"); //dump info to create wave propagation later
        $dumpvars(0, test4Core_Demo);
		#4;
		if (DUT1.regfile.registers[2] !== 32'd6) begin
			$write("%c[31m",27);
			$display("4 Core DEMO test failed.");
			$display("got: %d", DUT1.regfile.registers[2]);
			$write("%c[0m",27);
		end
		else begin
			$write("%c[32m",27);
			$display("4 Core DEMO test passed.");
			$display("got: %d", DUT1.regfile.registers[2]);
			$write("%c[0m",27);
		end
		$finish;
 	end
endmodule
