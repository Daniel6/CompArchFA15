module testRegisterFile;
	wire [0:0] [31:0] ReadData1_1core;		// Data from first register read
	wire [0:0] [31:0] ReadData2_1core;		// Data from second register read
	reg [0:0] [31:0] WriteData_1core;		// Data to write to register
	reg [0:0] [4:0] ReadRegister1_1core;		// Address of first register to read
	reg [0:0] [4:0] ReadRegister2_1core;		// Address of second register to read
	reg [0:0] [4:0] WriteRegister_1core ;		// Address of register to write
	reg RegWrite_1core;				// Enable writing of register when High

	wire [4-1:0] [31:0] ReadData1_4core;		// Data from first register read
	wire [4-1:0] [31:0] ReadData2_4core;		// Data from second register read
	reg [4-1:0] [31:0] WriteData_4core;		// Data to write to register
	reg [4-1:0] [4:0] ReadRegister1_4core;		// Address of first register to read
	reg [4-1:0] [4:0] ReadRegister2_4core;		// Address of second register to read
	reg [4-1:0] [4:0] WriteRegister_4core;		// Address of register to write
	reg [4-1:0] RegWrite_4core;				// Enable writing of register when High

	reg clk;					// Clock (Positive Edge Triggered)

	// Register File for 1 core
	registerfile #(.cores(1)) dut1 (.read_data_1(ReadData1_1core),
									.read_data_2(ReadData2_1core),
									.write_data(WriteData_1core),
									.read_address_1(ReadRegister1_1core),
									.read_address_2(ReadRegister2_1core),
									.write_address(WriteRegister_1core),
									.write_enable(RegWrite_1core),
									.clk(clk));

	// Register File for 4 core
	registerfile #(.cores(4)) dut4 (.read_data_1(ReadData1_4core),
									.read_data_2(ReadData2_4core),
									.write_data(WriteData_4core),
									.read_address_1(ReadRegister1_4core),
									.read_address_2(ReadRegister2_4core),
									.write_address(WriteRegister_4core),
									.write_enable(RegWrite_4core),
									.clk(clk));

	initial clk = 0;
	always #1 clk = !clk;
	reg dutPass;
	reg testFlag;

	initial begin

		$dumpfile("registerfile.t.vcd");
	    $dumpvars(0, testRegisterFile);
		dutPass = 1;

		// ===============================================================================================================
		// 1 Core Tests
		$display("Testing 1-Core Register File...");
		// Write to a register and then read from the register and check if the value we wrote is there
		RegWrite_1core = 1'b1;
		WriteRegister_1core = 5'b01111;
		WriteData_1core = 32'b10101;
		ReadRegister1_1core = 5'b01111;
		#2;
		if (ReadData1_1core !== WriteData_1core) begin
			$display("[Test 1] Unexpected read data from %b", ReadRegister1_1core);
			$display("[Test 1] Expected %b, got %b", WriteData_1core, ReadData1_1core);
			dutPass = 0;
		end

		// Try to write to a register but haha regwrite is off so you cant
		RegWrite_1core = 1'b0;
		WriteRegister_1core = 5'b01111;
		WriteData_1core = 32'b11111;
		ReadRegister1_1core = 5'b01111;
		#2;
		if (ReadData1_1core === WriteData_1core) begin
			$display("[Test 2] Unexpected read data from %b", ReadRegister1_1core);
			$display("[Test 2] Expected %b, got %b", 32'b10101, ReadData1_1core);
			dutPass = 0;
		end

		// Write to a register and then go and write to another register
		// And then go back and read from the first register and it should
		// Still have held its value
		RegWrite_1core = 1'b1;
		WriteRegister_1core = 5'b01001;
		WriteData_1core = 32'b1;
		ReadRegister1_1core = 5'b0;
		#2;
		WriteRegister_1core = 5'b01111;
		WriteData_1core = 32'b01101;
		#2;
		ReadRegister1_1core = 5'b01001;
        #2
		if (ReadData1_1core !== 32'b00001) begin
			$display("[Test 3] Unexpected read data from %b", ReadRegister1_1core);
			$display("[Test 3] Expected %b, got %b", 32'b00001, ReadData1_1core);
			dutPass = 0;
		end

		// Test simultaneous reading
		// Write to a register and then write to another register and read from both
		RegWrite_1core = 1'b1;
		WriteRegister_1core = 5'b01001;
		WriteData_1core = 32'b00001;
		ReadRegister1_1core = 5'b01001;
		#2;
		if (ReadData1_1core !== WriteData_1core) begin
			$display("[Test 4] Unexpected read data from %b", ReadRegister1_1core);
			$display("[Test 4] Expected %b, got %b", WriteData_1core, ReadData1_1core);
			dutPass = 0;
		end
		WriteRegister_1core = 5'b11011;
		WriteData_1core = 32'b11001;
		ReadRegister2_1core = 5'b11011;
		#2;
		if (ReadData2_1core !== WriteData_1core) begin
			$display("[Test 5] Unexpected read data from %b", ReadRegister2_1core);
			$display("[Test 5] Expected %b, got %b", WriteData_1core, ReadData2_1core);
			dutPass = 0;
		end

		if (dutPass) begin
			$display("Pass");
		end
		else begin
			$display("Fail");
		end

		// ===============================================================================================================
		// 4 Core Tests
		$display("Testing 4-Core Register File...");

		// Test Case:
		// Write to 4 registers simultaneously
		// Read from those 4 registers
		// Expected Output:
		// Read the 4 written values
		RegWrite_4core[3:0] = 4'b1111;
		WriteData_4core[3] = 32'd87;
		WriteData_4core[2] = 32'd199;
		WriteData_4core[1] = 32'd100;
		WriteData_4core[0] = 32'd199;
		ReadRegister1_4core[3] = 5'd13;	ReadRegister2_4core[3] = 5'd1;
		ReadRegister1_4core[2] = 5'd16; ReadRegister2_4core[2] = 5'd30;
		ReadRegister1_4core[1] = 5'd27; ReadRegister2_4core[1] = 5'd11;
		ReadRegister1_4core[0] = 5'd19;	ReadRegister2_4core[0] = 5'd9;
		WriteRegister_4core[3] = 5'd13;
		WriteRegister_4core[2] = 5'd16;
		WriteRegister_4core[1] = 5'd27;
		WriteRegister_4core[0] = 5'd19;
		#2;
		for (int i = 3; i >= 0; i = i - 1) begin
			if (ReadData1_4core[i] !== WriteData_4core[i]) begin
				$display("[Test 6_%d] Fail: Expected %d, got %d", i, WriteData_4core[i], ReadData1_4core[i]);
				dutPass = 0;
			end
		end

		// Test Case:
		// Disable writing
		// read from the 4 registers that were written to in the above test case
		// This tests data persistence, making sure the registers maintain their values
		// Expected Output:
		// Read the 4 written values
		RegWrite_4core[3:0] = 4'b0000;
		WriteData_4core[3] = 32'd256;
		WriteData_4core[2] = 32'd129;
		WriteData_4core[1] = 32'd110;
		WriteData_4core[0] = 32'd189;
		ReadRegister1_4core[3] = 5'd13;	ReadRegister2_4core[3] = 5'd1;
		ReadRegister1_4core[2] = 5'd16; ReadRegister2_4core[2] = 5'd30;
		ReadRegister1_4core[1] = 5'd27; ReadRegister2_4core[1] = 5'd11;
		ReadRegister1_4core[0] = 5'd19;	ReadRegister2_4core[0] = 5'd9;
		WriteRegister_4core[3] = 5'd14;
		WriteRegister_4core[2] = 5'd17;
		WriteRegister_4core[1] = 5'd28;
		WriteRegister_4core[0] = 5'd20;
		#2;
		if (ReadData1_4core[3] !== 32'd87) begin
			$display("[Test 7_1] Fail: Expected %d, got %d", 32'd87, ReadData1_4core[3]);
			dutPass = 0;
		end
		if (ReadData1_4core[2] !== 32'd199) begin
			$display("[Test 7_2] Fail: Expected %d, got %d", 32'd199, ReadData1_4core[2]);
			dutPass = 0;
		end
		if (ReadData1_4core[1] !== 32'd100) begin
			$display("[Test 7_3] Fail: Expected %d, got %d", 32'd100, ReadData1_4core[1]);
			dutPass = 0;
		end
		if (ReadData1_4core[0] !== 32'd199) begin
			$display("[Test 7_4] Fail: Expected %d, got %d", 32'd199, ReadData1_4core[0]);
			dutPass = 0;
		end

		if (dutPass) begin
			$display("Pass");
		end
		else begin
			$display("Fail");
		end
		
		$finish;
	end
endmodule
