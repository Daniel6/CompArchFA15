module testRegisterFile;
	wire[31:0] ReadData1_1core;		// Data from first register read
	wire[31:0] ReadData2_1core;		// Data from second register read
	reg[31:0] WriteData_1core;		// Data to write to register
	reg[4:0] ReadRegister1_1core;		// Address of first register to read
	reg[4:0] ReadRegister2_1core;		// Address of second register to read
	reg[4:0] WriteRegister_1core;		// Address of register to write
	reg RegWrite_1core;				// Enable writing of register when High

	wire [4-1:0] ReadData1_4core [31:0];		// Data from first register read
	wire [4-1:0] ReadData2_4core [31:0];		// Data from second register read
	reg [4-1:0] WriteData_4core [31:0];		// Data to write to register
	reg [4-1:0] ReadRegister1_4core [4:0];		// Address of first register to read
	reg [4-1:0] ReadRegister2_4core [4:0];		// Address of second register to read
	reg [4-1:0] WriteRegister_4core [4:0];		// Address of register to write
	reg RegWrite_4core [4-1:0];				// Enable writing of register when High

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

	initial begin

		$dumpfile("registerfile.t.vcd");
	    $dumpvars(0, testRegisterFile);
		dutPass = 1;

		// ===============================================================================================================
		// 1 Core Tests

		// Write to a register and then read from the register and check if the value we wrote is there
		RegWrite_1core = 1'b1;
		WriteRegister_1core = 5'b01111;
		WriteData_1core = 5'b10101;
		ReadRegister1_1core = 5'b01111;
		#2;
		if (ReadData1_1core != WriteData_1core) begin
			$display("[1 Core] Unexpected read data from %b", ReadRegister1_1core);
			$display("[1 Core] Expected %b, got %b", WriteData_1core, ReadData1_1core);
			dutPass = 0;
		end

		// Try to write to a register but haha regwrite is off so you cant
		RegWrite_1core = 1'b0;
		WriteRegister_1core = 5'b01111;
		WriteData_1core = 5'b11111;
		ReadRegister1_1core = 5'b01111;
		#2;
		if (ReadData1_1core == WriteData_1core) begin
			$display("[1 Core] Unexpected read data from %b", ReadRegister1_1core);
			$display("[1 Core] Expected %b, got %b", 5'b10101, ReadData1_1core);
			dutPass = 0;
		end

		$finish;
	end
endmodule
