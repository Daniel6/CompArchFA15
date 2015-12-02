module test_instruction_module()



initial begin 

		$dumpfile("instruction_module.t.vcd");
	    $dumpvars(0, test_instruction_module);

	    
	    $finish;

end 



endmodule