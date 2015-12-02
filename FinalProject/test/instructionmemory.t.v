module test_instruction_module();

reg clk;
reg dutPass;
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
		dutPass = 1;
		inputaddress = 0;
		#4
	   	if(one_output_instructions !== 32'h00000000 || two_output_instructions !== 64'h0000000000000000)
	   	begin 
	   	dutPass =0;
	   	$display ("Woo FAIL at address %h", inputaddress);
	   	$display("%h", one_output_instructions);
	   	end
	   	inputaddress = inputaddress + 1;
		#2
	   	if(one_output_instructions !== 32'h11111111 || two_output_instructions !== 64'h1111111111111111)
	   	begin 
	   	dutPass =0;
	   	$display ("Woo FAIL at address %h", inputaddress);
	   	$display("%h", one_output_instructions);
	   	end
	   	inputaddress = inputaddress + 1;
	   	#2
	   	if(one_output_instructions !== 32'h22222222 || two_output_instructions !== 64'h2222222222222222)
	   	begin 
	   	dutPass =0;
	   	$display ("Woo FAIL at address %h", inputaddress);
	   	$display("%h", one_output_instructions);
	   	end
	   	inputaddress = inputaddress + 1;
	   	#2
	    if(one_output_instructions !== 32'h33333333 || two_output_instructions !== 64'h3333333333333333)
	   	begin 
	   	dutPass =0;
	   	$display ("Woo FAIL at address %h", inputaddress);
	   	$display("%h", one_output_instructions);
	   	end
	   	inputaddress = inputaddress + 1;
	   	#2
	   	if(one_output_instructions !== 32'h44444444 || two_output_instructions !== 64'h4444444444444444)
	   	begin 
	   	dutPass =0;
	   	$display ("Woo FAIL at address %h", inputaddress);
	   	$display("%h", one_output_instructions);
	   	end
	   	inputaddress = inputaddress + 1;
	   	#2
	   	if(one_output_instructions !== 32'h55555555 || two_output_instructions !== 64'h5555555555555555)
	   	begin 
	   	dutPass =0;
	   	$display ("Woo FAIL at address %h", inputaddress);
	   	$display("%h", one_output_instructions);
	   	end
	   	inputaddress = inputaddress + 1;
	   	#2
	   	if(one_output_instructions !== 32'h66666666 || two_output_instructions !== 64'h6666666666666666)
	   	begin 
	   	dutPass =0;
	   	$display ("Woo FAIL at address %h", inputaddress);
	   	$display("%h", one_output_instructions);
	   	end
	   	inputaddress = inputaddress + 1;
	   	#2
	    if(one_output_instructions !== 32'h77777777 || two_output_instructions !== 64'h7777777777777777)
	   	begin 
	   	dutPass =0;
	   	$display ("Woo FAIL at address %h", inputaddress);
	   	$display("%h", one_output_instructions);
	   	end
	   	inputaddress = inputaddress + 1;
	   	#2
	   	if(one_output_instructions !== 32'h88888888 || two_output_instructions !== 64'h8888888888888888)
	   	begin 
	   	dutPass =0;
	   	$display ("Woo FAIL at address %h", inputaddress);
	   	$display("%h", one_output_instructions);
	   	end
	   	inputaddress = inputaddress + 1;
	   	#2
	   	if(one_output_instructions !== 32'h99999999 || two_output_instructions !== 64'h9999999999999999)
	   	begin 
	   	dutPass =0;
	   	$display ("Woo FAIL at address %h", inputaddress);
	   	$display("%h", one_output_instructions);
	   	end
	   	inputaddress = inputaddress + 1;
	   	#2
	   	if(one_output_instructions !== 32'haaaaaaaa || two_output_instructions !== 64'haaaaaaaaaaaaaaaa)
	   	begin 
	   	dutPass =0;
	   	$display ("Woo FAIL at address %h", inputaddress);
	   	$display("%h", one_output_instructions);
	   	end
	   	inputaddress = inputaddress + 1;
	   	#2
	    if(one_output_instructions !== 32'hbbbbbbbb || two_output_instructions !== 64'hbbbbbbbbbbbbbbbb)
	   	begin 
	   	dutPass =0;
	   	$display ("Woo FAIL at address %h", inputaddress);
	   	$display("%h", one_output_instructions);
	   	end
	   	inputaddress = inputaddress + 1;
	   	#2
	   	if(one_output_instructions !== 32'hcccccccc || two_output_instructions !== 64'hcccccccccccccccc)
	   	begin 
	   	dutPass =0;
	   	$display ("Woo FAIL at address %h", inputaddress);
	   	$display("%h", one_output_instructions);
	   	end
	   	inputaddress = inputaddress + 1;
	   	#2
	    if(one_output_instructions !== 32'hdddddddd || two_output_instructions !== 64'hdddddddddddddddd)
	   	begin 
	   	dutPass =0;
	   	$display ("Woo FAIL at address %h", inputaddress);
	   	$display("%h", one_output_instructions);
	   	end
	   	inputaddress = inputaddress + 1;
	   	#2
	   	if(one_output_instructions !== 32'heeeeeeee || two_output_instructions !== 64'heeeeeeeeeeeeeeee)
	   	begin 
	   	dutPass =0;
	   	$display ("Woo FAIL at address %h", inputaddress);
	   	$display("%h", one_output_instructions);
	   	end
	   	inputaddress = inputaddress + 1;
	   	#2
	    if(one_output_instructions !== 32'hffffffff || two_output_instructions !== 64'hffffffffffffffff)
	   	begin 
	   	dutPass =0;
	   	$display ("Woo FAIL at address %h", inputaddress);
	   	$display("%h", one_output_instructions);
	   	end
	   	inputaddress = inputaddress + 1;
	   	#2

	   	if(dutPass == 1 )
	   	$display("PASS :D");
	   	else   	begin 
	   	$display("FAIL :(");
	   	end
	    $finish;

end 



endmodule