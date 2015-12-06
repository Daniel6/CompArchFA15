/*
	Top level test module
	Instantiate every sub-test module
*/
module testCpu;
	test4Core_xori		test0(); // Test XORI on four cores
	test4Core_Addition 	test1(); // Test ADD on four cores
	test4Core_jump		test2(); // Test J on four cores

endmodule