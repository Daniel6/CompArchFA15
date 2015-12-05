module testControlTable;
reg clk;
reg [31:0] instruction;

   wire [1:0] pc_next;
   wire alu_src;
   wire [1:0] alu_ctrl;
   wire reg_we;
   wire [1:0] reg_in;
   wire mem_we;
   wire beq;
   wire bne;
   wire[25:0]    target;
   wire[15:0]    imm;
   wire[4:0]     rs;
   wire[4:0]     rt;
   wire[4:0]     aw;

controlTable control(.clk(clk), 
					 .instruction(instruction),
					 .pc_next(pc_next),
					 .alu_src(alu_src),
					 .alu_ctrl(alu_ctrl),
					 .reg_we(reg_we),
					 .reg_in(reg_in),
					 .mem_we(mem_we),
					 .beq(beq),
					 .bne(bne),
					 .target(target),
					 .imm(imm),
					 .rs(rs),
					 .rt(rt),
					 .aw(aw));

initial clk = 0;
always #1 clk = !clk;
reg dutpassed = 1;



    parameter lw = 6'b100011;
    parameter sw = 6'b101011;
    parameter j = 6'b000010;
    parameter jal = 6'b000011;
    parameter beq_code = 6'b000100;
    parameter bne_code = 6'b000101;
    parameter xori = 6'b001110;
    parameter alu = 6'b000000;

    parameter add = 6'b100000;
    parameter sub = 6'b100010;
    parameter slt = 6'b101010;
    parameter jr = 6'b001000;


    parameter rs_code = 5'b00001;
    parameter rt_code = 5'b00011;
    parameter rd_code = 5'b00111;
    parameter imm_code = 16'h000A;
    parameter target_code = 26'b10101010101010101010101010;

initial begin
	$dumpfile("controlTable.vcd");
	$dumpvars(0,testControlTable);
	$display("TESTING CONTROL TABLE");

	//TESTING LW
	
	instruction = {lw, rs_code, rt_code, imm_code};
	#2
	if (pc_next !== 2'b0 || aw !== rt_code || alu_src !== 1'b0 || alu_ctrl !== 2'b0 || reg_we !== 1'b1 || reg_in !== 2'b1 || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b0) begin
            dutpassed = 0;
            $display("LW Test failed");
    end

	//TESTING SW
	instruction = {sw, rs_code,rt_code, imm_code};
	#2
	if (pc_next !== 2'b0 || aw !== 5'bx || alu_src !== 1'b0 || alu_ctrl !== 2'b0 || reg_we !== 1'b0 || reg_in !== 2'bx || mem_we !== 1'b1 || beq !== 1'b0 || bne !== 1'b0) begin
            dutpassed = 0;
            $display("SW Test failed");
    end

	//J
	instruction = {j, target_code};
	#2
	if (pc_next !== 2'b1 || aw !== 5'bx || alu_src !== 1'bx || alu_ctrl !== 2'bx || reg_we !== 1'b0 || reg_in !== 2'bx || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b0) begin
        dutpassed = 0;
        $display("J Test failed");
    end	
	//JR
	instruction = {alu,rs_code, 21'b000000000000000001000 };
	#2
    if (pc_next !== 2'b10 || aw !== 5'bx || alu_src !== 1'bx || alu_ctrl !== 2'bx || reg_we !== 1'b0 || reg_in !== 2'bx || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b0) begin
        dutpassed = 0;
        $display("JR Test failed");
    end

	//JAL
	instruction = {jal, target_code};
	#2
    if (pc_next !== 2'b1 || aw !== 5'd31 || alu_src !== 1'bx || alu_ctrl !== 2'bx || reg_we !== 1'b1 || reg_in !== 2'b10 || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b0) begin
        dutpassed = 0;
        $display("JAL Test failed");
    end

	//BEQ
	instruction = {beq_code, rs_code, rt_code, imm_code};
	#2
    if (pc_next !== 2'b0 || aw !== 5'bx || alu_src !== 1'b1 || alu_ctrl !== 2'b1 || reg_we !== 1'b0 || reg_in !== 2'bx || mem_we !== 1'b0 || beq !== 1'b1 || bne !== 1'b0) begin
        dutpassed = 0;
        $display("BEQ Test failed");
    end
	//BNE
	instruction = {bne_code, rs_code,rt_code,imm_code};
	#2
   if (pc_next !== 2'b0 || aw !== 5'bx || alu_src !== 1'b1 || alu_ctrl !== 2'b1 || reg_we !== 1'b0 || reg_in !== 2'bx || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b1) begin
        dutpassed = 0;
        $display("BNE Test failed");
    end
	//XORI
	instruction = {xori, rs_code, rt_code, imm_code};
	#2
	if (pc_next !== 2'b0 || aw !== rt_code || alu_src !== 1'b0 || alu_ctrl !== 2'b10 || reg_we !== 1'b1 || reg_in !== 2'b0 || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b0) begin
        dutpassed = 0;
        $display("XORI Test failed");
    end
	//ADD
	instruction = {alu, rs_code, rt_code, rd_code, 11'b00000100000};
	#2
	if (pc_next !== 2'b0 || aw !== rd_code || alu_src !== 1'b1 || alu_ctrl !== 2'b0 || reg_we !== 1'b1 || reg_in !== 2'b0 || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b0) begin
        dutpassed = 0;
        $display("ADD Test failed");
    end
	//SUB
	instruction = {alu, rs_code, rt_code, rd_code, 11'b00000100010};
	#2
	if (pc_next !== 2'b0 || aw !== rd_code || alu_src !== 1'b1 || alu_ctrl !== 2'b1 || reg_we !== 1'b1 || reg_in !== 2'b0 || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b0) begin
        dutpassed = 0;
        $display("SUB Test failed");
    end
	//SLT
	instruction = {alu, rs_code, rt_code, rd_code, 11'b00000101010};
	#2
	if (pc_next !== 2'b0 || aw !== rd_code || alu_src !== 1'b1 || alu_ctrl !== 2'b11 || reg_we !== 1'b1 || reg_in !== 2'b0 || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b0) begin
        dutpassed = 0;
        $display("SLT Test failed");
    end

    if( target !== instruction[25:0] ||imm_code !== imm_code || rs_code !==rs || rt_code!== rt) begin
    	dutpassed = 0;
    	$display("Decoder Test failed");
    end

    if (dutpassed == 1) begin
        $display("ControlTable Tests Passed");
    end

    else begin
        $display("ControlTable Tests Failed");
    end
	$finish;
end


endmodule