module test_instruction_module();

reg clk;
reg [31:0] inputaddress;
wire [63:0] two_output_instructions;

wire [31:0] one_output_instructions;

	instructionmemory #(1, "one-core-memory.dat") dut1(.clk(clk), 
																.address(inputaddress), 
																.dataOut(one_output_instructions));
	instructionmemory #(.cores(2),
		                .instructions("two-core-memory.dat"))
		                 dut2(.clk(clk), 
		                 	            .address(inputaddress), 
		                 	            .dataOut(two_output_instructions));
initial clk = 0;
always #1 clk = !clk;

initial begin 

		$dumpfile("instruction_module.t.vcd");
	    $dumpvars(0, test_instruction_module);

	    inputaddress = 0;
	    #4;
	    inputaddress = 1;
	    #4;
	    inputaddress = 2;
	    #4
	    inputaddress = 3;
	    #4
	    

	    $finish;

end 



endmodule