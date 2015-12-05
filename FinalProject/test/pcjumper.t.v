module testPcJumper;

	reg[31:0] pc_plus4;
	reg[3:0] [31:0] core_pcs;
	reg[3:0] core_controls;
	wire[31:0] next_pc_4cores;
	wire[31:0] next_pc_1core;

	pcjumper #(.cores(1)) dut0(.pc_plus4(pc_plus4),
							   .core_pcs(core_pcs[0]),
							   .core_controls(core_controls[0]),
							   .next_pc(next_pc_1core));

	pcjumper #(.cores(4)) dut1(.pc_plus4(pc_plus4),
							   .core_pcs(core_pcs),
							   .core_controls(core_controls),
							   .next_pc(next_pc_4cores));

	reg dutPass;
	initial begin
		$dumpfile("pcjumper.t.vcd");
	    $dumpvars(0, testPcJumper);
	    dutPass = 1;
		//===============================================================
		// Tests
		pc_plus4 = 32'b10101101100;
		core_pcs[3] = 32'd14; core_controls[3] = 1'b0;
		core_pcs[2] = 32'd24; core_controls[2] = 1'b0;
		core_pcs[1] = 32'd36; core_controls[1] = 1'b0;
		core_pcs[0] = 32'd64; core_controls[0] = 1'b0; // Core 1
		#2;
		if (next_pc_4cores !== pc_plus4) begin
			$display("[Test 1] Fail: Expected %h but got %h", pc_plus4, next_pc_4cores);
			dutPass = 0;
		end
		if (next_pc_1core !== pc_plus4) begin
			$display("[Test 1b] Fail: Expected %h but got %h", pc_plus4, next_pc_1core);
			dutPass = 0;
		end

		pc_plus4 = 32'b10101101100;
		core_pcs[3] = 32'd14; core_controls[3] = 1'b0;
		core_pcs[2] = 32'd24; core_controls[2] = 1'b1;
		core_pcs[1] = 32'd36; core_controls[1] = 1'b0;
		core_pcs[0] = 32'd64; core_controls[0] = 1'b0;
		#2;
		if (next_pc_4cores !== core_pcs[2]) begin
			$display("[Test 2] Fail: Expected %h but got %h", core_pcs[2], next_pc_4cores);
			dutPass = 0;
		end
		if (next_pc_1core !== pc_plus4) begin
			$display("[Test 2b] Fail: Expected %h but got %h", pc_plus4, next_pc_1core);
			dutPass = 0;
		end

		pc_plus4 = 32'b10101101100;
		core_pcs[3] = 32'd14; core_controls[3] = 1'b0;
		core_pcs[2] = 32'd24; core_controls[2] = 1'b1;
		core_pcs[1] = 32'd36; core_controls[1] = 1'b1;
		core_pcs[0] = 32'd64; core_controls[0] = 1'b0;
		#2;
		if (next_pc_4cores !== core_pcs[1]) begin
			$display("[Test 3] Fail: Expected %h but got %h", core_pcs[1], next_pc_4cores);
			dutPass = 0;
		end
		if (next_pc_1core !== pc_plus4) begin
			$display("[Test 3b] Fail: Expected %h but got %h", pc_plus4, next_pc_1core);
			dutPass = 0;
		end

		pc_plus4 = 32'b10101101100;
		core_pcs[3] = 32'd14; core_controls[3] = 1'b1;
		core_pcs[2] = 32'd24; core_controls[2] = 1'b1;
		core_pcs[1] = 32'd36; core_controls[1] = 1'b1;
		core_pcs[0] = 32'd64; core_controls[0] = 1'b1;
		#2;
		if (next_pc_4cores !== core_pcs[0]) begin
			$display("[Test 4] Fail: Expected %h but got %h", core_pcs[0], next_pc_4cores);
			dutPass = 0;
		end
		if (next_pc_1core !== core_pcs[0]) begin
			$display("[Test 4b] Fail: Expected %h but got %h", core_pcs[0], next_pc_1core);
			dutPass = 0;
		end

		if (dutPass) begin
			$display("PC Jumper passed all tests");
		end
		else begin
			$display("PC Jumper failed tests");
		end
		$finish;
	end
endmodule