module testPcJumper;

	reg[31:0] pc_plus4;
	reg[3:0] [31:0] core_pcs;
	reg[3:0] core_controls;
	wire[31:0] next_pc;
	pcjumper #(.cores(1)) dut1(.pc_plus4(pc_plus4),
							   .core_pcs(core_pcs),
							   .core_controls(core_controls),
							   .next_pc(next_pc));

	reg dutPass;
	initial begin
		$dumpfile("pcjumper.t.vcd");
	    $dumpvars(0, testPcJumper);
	    dutPass = 1;
		//===============================================================
		// 4 Core Tests
		pc_plus4 = 32'b10101101100;
		core_pcs[3] = 32'd14; core_controls[3] = 1'b0;
		core_pcs[2] = 32'd24; core_controls[2] = 1'b0;
		core_pcs[1] = 32'd36; core_controls[1] = 1'b0;
		core_pcs[0] = 32'd64; core_controls[0] = 1'b0;
		#2;
		if (next_pc !== pc_plus4) begin
			$display("[Test 1] Fail: Expected %h but got %h", pc_plus4, next_pc);
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