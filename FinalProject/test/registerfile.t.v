module testRegisterFile;
	wire[31:0] ReadData1;		// Data from first register read
	wire[31:0] ReadData2;		// Data from second register read
	reg[31:0] WriteData;		// Data to write to register
	reg[4:0] ReadRegister1;		// Address of first register to read
	reg[4:0] ReadRegister2;		// Address of second register to read
	reg[4:0] WriteRegister;		// Address of register to write
	reg RegWrite;				// Enable writing of register when High
	reg clk;					// Clock (Positive Edge Triggered)
	
	// Register File for 1 core
	registerfile dut1 #(.cores(1)) (.read_data_1(ReadData1),
									.read_data_2(ReadData2),
									.write_data(WriteData),
									.read_address_1(ReadRegister1),
									.read_address_2(ReadRegister2),
									.write_address(WriteRegister),
									.write_enable(RegWrite),
									.clk(clk)
	);

	initial clk = 0;
	always #1 clk = !clk;

	initial begin
		RegWrite = 1'b1;
		WriteRegister = 5'b01111;
		WriteData = 5'b10101;
		#20
		$display("Wrote %b to %b.", WriteData, WriteRegister);
		ReadRegister1 = 5'b01111;
		#20
		$display("Read %b from %b.", ReadData1, ReadRegister1);
	end
endmodule
