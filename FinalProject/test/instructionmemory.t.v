module test_instruction_module();

reg clk;
reg [31:0] ipnutaddress;
wire [63:0] output_instructions;

	instructionmemory #(1, "one_core_memory.dat") test_one_core(.clk(clk), 
									.address(inputaddress), 
									.dataOut(output_instructions));
	instructionmemory #(.cores(2),
		                .instructions("two_core_memory.dat"))
		                 test_two_core(.clk(clk), 
		                 	            .address(inputaddress), 
		                 	            .dataOut(output_instructions));

initial begin 

		$dumpfile("instruction_module.t.vcd");
	    $dumpvars(0, test_instruction_module);

	    

	    $finish;

end 



endmodule