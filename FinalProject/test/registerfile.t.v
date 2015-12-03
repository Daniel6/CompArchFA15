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
		testFlag = 0;

		// ===============================================================================================================
		// 1 Core Tests
		$display("Testing 1-Core Register File...");
		// Write to a register and then read from the register and check if the value we wrote is there
		testFlag = testFlag + 1;
		RegWrite_1core = 1'b1;
		WriteRegister_1core = 5'b01111;
		WriteData_1core = 5'b10101;
		ReadRegister1_1core = 5'b01111;
		#2;
		if (ReadData1_1core !== WriteData_1core) begin
			$display("[Test %d] Unexpected read data from %b", testFlag, ReadRegister1_1core);
			$display("[Test %d] Expected %b, got %b", testFlag, WriteData_1core, ReadData1_1core);
			dutPass = 0;
		end

		// Try to write to a register but haha regwrite is off so you cant
		testFlag = testFlag + 1;
		RegWrite_1core = 1'b0;
		WriteRegister_1core = 5'b01111;
		WriteData_1core = 5'b11111;
		ReadRegister1_1core = 5'b01111;
		#2;
		if (ReadData1_1core === WriteData_1core) begin
			$display("[Test %d] Unexpected read data from %b", testFlag, ReadRegister1_1core);
			$display("[Test %d] Expected %b, got %b", 5'b10101, testFlag, ReadData1_1core);
			dutPass = 0;
		end

		// Write to a register and then go and write to another register
		// And then go back and read from the first register and it should
		// Still have held its value
		testFlag = testFlag + 1;
		RegWrite_1core = 1'b1;
		WriteRegister_1core = 5'b01001;
		WriteData_1core = 5'b00001;
		ReadRegister1_1core = 5'b00000;
		#2;
		WriteRegister_1core = 5'b01111;
		WriteData_1core = 5'b01101;
		#2;
		ReadRegister1_1core = 5'b01001;
		if (ReadData1_1core !== 5'b00001) begin
			$display("[Test %d] Unexpected read data from %b", testFlag, ReadRegister1_1core);
			$display("[Test %d] Expected %b, got %b", 5'b00001, testFlag, ReadData1_1core);
			dutPass = 0;
		end

		// Test simultaneous reading
		// Write to a register and then write to another register and read from both
		testFlag = testFlag + 1;
		RegWrite_1core = 1'b1;
		WriteRegister_1core = 5'b01001;
		WriteData_1core = 5'b00001;
		ReadRegister1_1core = 5'b01001;
		#2;
		if (ReadData1_1core !== WriteData_1core) begin
			$display("[Test %d] Unexpected read data from %b", testFlag, ReadRegister1_1core);
			$display("[Test %d] Expected %b, got %b", testFlag, WriteData_1core, ReadData1_1core);
			dutPass = 0;
		end
		WriteRegister_1core = 5'b11011;
		WriteData_1core = 5'b11001;
		ReadRegister2_1core = 5'b11011;
		#2;
		if (ReadData2_1core !== WriteData_1core) begin
			$display("[Test %d] Unexpected read data from %b", testFlag, ReadRegister2_1core);
			$display("[Test %d] Expected %b, got %b", testFlag, WriteData_1core, ReadData2_1core);
			dutPass = 0;
		end

		if (dutPass) begin
			$display("Pass");
		end
		else
			$display("Fail");
		end

		// ===============================================================================================================
		// 4 Core Tests
		$display("Testing 4-Core Register File...");

		$finish;
	end
endmodule
