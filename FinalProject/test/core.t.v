
//-------------------------------
// Instruction Decoder Test
//-------------------------------

module testCore;

    reg clk;
    reg [31:0] regDataA;
    reg [31:0] regDataB;
    reg [15:0] imm;
    reg [25:0] addr;
    reg [1:0] pc_next;
    reg [1:0] reg_dst;
    reg alu_src;
    reg [1:0] alu_ctrl;
    reg reg_we;
    reg [1:0] reg_in;
    reg mem_we;
    reg beq;
    reg bne;
    reg [31:0] pcIn;
    reg [31:0] pcRes;
    reg myPc;
    reg [31:0] aluRes;

    reg dutpassed;

    initial clk = 0;
    always #1 clk = !clk;

    core DUT(.clk(clk),
               .regDataA(regDataA),
               .regDataB(regDataB),
               .imm(imm),
               .addr(addr),
               .pc_next(pc_next),
               .reg_dst(reg_dst),
               .alu_src(alu_src),
               .alu_ctrl(alu_ctrl),
               .reg_we(reg_we),
               .reg_in(reg_in),
               .mem_we(mem_we),
               .beq(beq),
               .bne(bne),
               .pcIn(pcIn),
               .pcRes(pcRes),
               .myPc(myPc),
               .aluRes(aluRes));

    initial begin
        $dumpfile("core.vcd"); //dump info to create wave propagation later
        $dumpvars(0, testCore);

        dutpassed = 1;
        $display("Testing core");

        // Test 1: Load Word
        regDataA = 32'd7;
        regDataB = 32'b0;
        imm = 16'd12;
        addr = 26'b0;
        pc_next = 0;
        reg_dst = 0;
        alu_src = 0;
        alu_ctrl = 0;
        reg_we = 1;
        reg_in = 1;
        mem_we = 0;
        beq = 0;
        bne = 0;
        pcIn = 32'b0;

        #2
        if (pcRes !== 32'd4) begin
            $display("Test 1 Failed");
            $display("expected pcRes: %b, actual pcRes: %b", 32'd4, pcRes);
            dutpassed = 0;
        end
        if (myPc !== 1'b0) begin
            $display("Test 1 Failed");
            $display("expected myPc: %b, actual myPc: %b", 0, myPc);
            dutpassed = 0;
        end
        if (aluRes !== 32'd19) begin
            $display("Test 1 Failed");
            $display("expected aluRes: %b, actual aluRes: %b", 32'd19, aluRes);
            dutpassed = 0;
        end

        // Test 2: Store Word
        regDataA = 32'd7;
        regDataB = 32'b0;
        imm = 16'd12;
        addr = 26'b0;
        pc_next = 0;
        reg_dst = 1'bx;
        alu_src = 0;
        alu_ctrl = 0;
        reg_we = 1;
        reg_in = 1'bx;
        mem_we = 1;
        beq = 0;
        bne = 0;
        pcIn = 32'b0;

        #2
        if (pcRes !== 32'd4) begin
            $display("Test 2 Failed");
            $display("expected pcRes: %b, actual pcRes: %b", 32'd4, pcRes);
            dutpassed = 0;
        end
        if (myPc !== 1'b0) begin
            $display("Test 2 Failed");
            $display("expected myPc: %b, actual myPc: %b", 0, myPc);
            dutpassed = 0;
        end
        if (aluRes !== 32'd19) begin
            $display("Test 2 Failed");
            $display("expected aluRes: %b, actual aluRes: %b", 32'd19, aluRes);
            dutpassed = 0;
        end

        // Test 3: Jump
        regDataA = 32'd7;
        regDataB = 32'b0;
        imm = 16'd12;
        addr = 26'b10101010101010101010101010;
        pc_next = 1;
        reg_dst = 1'bx;
        alu_src = 1'bx;
        alu_ctrl = 1'bx;
        reg_we = 0;
        reg_in = 1'bx;
        mem_we = 0;
        beq = 0;
        bne = 0;
        pcIn = 32'b0;

        #2
        if (pcRes !== 32'b00001010101010101010101010101000) begin
            $display("Test 3 Failed");
            $display("expected pcRes: %b, actual pcRes: %b", 32'b00001010101010101010101010101000, pcRes);
            dutpassed = 0;
        end
        if (myPc !== 1'b1) begin
            $display("Test 3 Failed");
            $display("expected myPc: %b, actual myPc: %b", 1'b1, myPc);
            dutpassed = 0;
        end

        // Test 4: Jump Register
        regDataA = 32'd42;
        regDataB = 32'bx;
        imm = 32'bx;
        addr = 32'bx;
        pc_next = 2'd2;
        reg_dst = 1'bx;
        alu_src = 1'bx;
        alu_ctrl = 1'bx;
        reg_we = 0;
        reg_in = 1'bx;
        mem_we = 0;
        beq = 0;
        bne = 0;
        pcIn = 32'b0;

        #2
        if (pcRes !== 32'd42) begin
            $display("Test 4 Failed");
            $display("expected pcRes: %b, actual pcRes: %b", 32'd42, pcRes);
            dutpassed = 0;
        end
        if (myPc !== 1'b1) begin
            $display("Test 4 Failed");
            $display("expected myPc: %b, actual myPc: %b", 1, myPc);
            dutpassed = 0;
        end

        // Test 5: Jump and Link
        regDataA = 32'd7;
        regDataB = 32'b0;
        imm = 16'd12;
        addr = 26'b10101010101010101010101010;
        pc_next = 1'b1;
        reg_dst = 2'd2;
        alu_src = 1'bx;
        alu_ctrl = 1'bx;
        reg_we = 1;
        reg_in = 2'd2;
        mem_we = 0;
        beq = 0;
        bne = 0;
        pcIn = 32'b0;

        #2
        if (pcRes !== 32'b00001010101010101010101010101000) begin
            $display("Test 5 Failed");
            $display("expected pcRes: %b, actual pcRes: %b", 32'b00001010101010101010101010101000, pcRes);
            dutpassed = 0;
        end
        if (myPc !== 1'b1) begin
            $display("Test 5 Failed");
            $display("expected myPc: %b, actual myPc: %b", 1'b1, myPc);
            dutpassed = 0;
        end

        // Test 6: Branch if Equal
        regDataA = 32'd1;
        regDataB = 32'b0;
        imm = 16'd12;
        addr = 26'b0;
        pc_next = 0;
        reg_dst = 1'bx;
        alu_src = 1;
        alu_ctrl = 1;
        reg_we = 0;
        reg_in = 1'bx;
        mem_we = 0;
        beq = 1;
        bne = 0;
        pcIn = 32'b0;

        #2
        if (pcRes !== 32'd4) begin
            $display("Test 6.1 Failed");
            $display("expected pcRes: %b, actual pcRes: %b", 32'd4, pcRes);
            dutpassed = 0;
        end
        if (myPc !== 1'b0) begin
            $display("Test 6.1 Failed");
            $display("expected myPc: %b, actual myPc: %b", 0, myPc);
            dutpassed = 0;
        end

        regDataA = 32'd9;
        regDataB = 32'd9;
        imm = 16'b1100110011001100;

        #2
        if (pcRes !== 32'b11111111111111110011001100110100) begin
            $display("Test 6.2 Failed");
            $display("expected pcRes: %b, actual pcRes: %b", 32'b11111111111111110011001100110100, pcRes);
            dutpassed = 0;
        end
        if (myPc !== 1'b1) begin
            $display("Test 6.2 Failed");
            $display("expected myPc: %b, actual myPc: %b", 1, myPc);
            dutpassed = 0;
        end


        // Test 7: Branch if Not Equal
        regDataA = 32'd1;
        regDataB = 32'b0;
        imm = 16'b1111111100000000;
        addr = 26'b0;
        pc_next = 0;
        reg_dst = 1'bx;
        alu_src = 1;
        alu_ctrl = 1;
        reg_we = 0;
        reg_in = 1'bx;
        mem_we = 0;
        beq = 0;
        bne = 1;
        pcIn = 32'b0;

        #2
        if (pcRes !== 32'b11111111111111111111110000000100) begin
            $display("Test 7.1 Failed");
            $display("expected pcRes: %b, actual pcRes: %b", 32'b11111111111111111111110000000100, pcRes);
            dutpassed = 0;
        end
        if (myPc !== 1'b1) begin
            $display("Test 7.1 Failed");
            $display("expected myPc: %b, actual myPc: %b", 0, myPc);
            dutpassed = 0;
        end

        regDataA = 32'd9;
        regDataB = 32'd9;

        #2
        if (pcRes !== 32'd4) begin
            $display("Test 7.2 Failed");
            $display("expected pcRes: %b, actual pcRes: %b", 32'd4, pcRes);
            dutpassed = 0;
        end
        if (myPc !== 1'b0) begin
            $display("Test 7.2 Failed");
            $display("expected myPc: %b, actual myPc: %b", 0, myPc);
            dutpassed = 0;
        end

        // Test 8: XORI
        regDataA = 32'b10110110100101001011010110000101;
        regDataB = 32'b0;
        imm = 16'b1011010011010101;
        addr = 26'b0;
        pc_next = 0;
        reg_dst = 0;
        alu_src = 0;
        alu_ctrl = 2;
        reg_we = 1;
        reg_in = 0;
        mem_we = 0;
        beq = 0;
        bne = 0;
        pcIn = 32'b0;

        #2
        if (pcRes !== 32'd4) begin
            $display("Test 8 Failed");
            $display("expected pcRes: %b, actual pcRes: %b", 32'd4, pcRes);
            dutpassed = 0;
        end
        if (myPc !== 1'b0) begin
            $display("Test 8 Failed");
            $display("expected myPc: %b, actual myPc: %b", 0, myPc);
            dutpassed = 0;
        end
        if (aluRes !== 32'b01001001011010110000000101010000) begin
            $display("Test 8 Failed");
            $display("expected aluRes: %b, actual aluRes: %b", 32'b01001001011010110000000101010000, aluRes);
            dutpassed = 0;
        end

        // Test 9: ADD
        regDataA = 32'd194;
        regDataB = 32'd34;
        pc_next = 0;
        reg_dst = 1;
        alu_src = 1;
        alu_ctrl = 0;
        reg_we = 1;
        reg_in = 0;
        mem_we = 0;
        beq = 0;
        bne = 0;
        pcIn = 32'b0;

        #2
        if (pcRes !== 32'd4) begin
            $display("Test 9 Failed");
            $display("expected pcRes: %b, actual pcRes: %b", 32'd4, pcRes);
            dutpassed = 0;
        end
        if (myPc !== 1'b0) begin
            $display("Test 9 Failed");
            $display("expected myPc: %b, actual myPc: %b", 0, myPc);
            dutpassed = 0;
        end
        if (aluRes !== 32'd228) begin
            $display("Test 9 Failed");
            $display("expected aluRes: %b, actual aluRes: %b", 32'd228, aluRes);
            dutpassed = 0;
        end

        // Test 10: ADD
        regDataA = 32'd194;
        regDataB = 32'd34;
        pc_next = 0;
        reg_dst = 1;
        alu_src = 1;
        alu_ctrl = 1;
        reg_we = 1;
        reg_in = 0;
        mem_we = 0;
        beq = 0;
        bne = 0;
        pcIn = 32'b0;

        #2
        if (pcRes !== 32'd4) begin
            $display("Test 10 Failed");
            $display("expected pcRes: %b, actual pcRes: %b", 32'd4, pcRes);
            dutpassed = 0;
        end
        if (myPc !== 1'b0) begin
            $display("Test 10 Failed");
            $display("expected myPc: %b, actual myPc: %b", 0, myPc);
            dutpassed = 0;
        end
        if (aluRes !== 32'd160) begin
            $display("Test 10 Failed");
            $display("expected aluRes: %b, actual aluRes: %b", 32'd228, aluRes);
            dutpassed = 0;
        end

        // Test 11: SLT
        regDataA = 32'd194;
        regDataB = 32'd34;
        pc_next = 0;
        reg_dst = 1;
        alu_src = 1;
        alu_ctrl = 2'd3;
        reg_we = 1;
        reg_in = 0;
        mem_we = 0;
        beq = 0;
        bne = 0;
        pcIn = 32'b0;

        #2
        if (pcRes !== 32'd4) begin
            $display("Test 11.1 Failed");
            $display("expected pcRes: %b, actual pcRes: %b", 32'd4, pcRes);
            dutpassed = 0;
        end
        if (myPc !== 1'b0) begin
            $display("Test 11.1 Failed");
            $display("expected myPc: %b, actual myPc: %b", 0, myPc);
            dutpassed = 0;
        end
        if (aluRes !== 32'b0) begin
            $display("Test 11.1 Failed");
            $display("expected aluRes: %b, actual aluRes: %b", 32'd228, aluRes);
            dutpassed = 0;
        end

        regDataA = 32'd0;
        regDataB = 32'd34;

        #2
        if (pcRes !== 32'd4) begin
            $display("Test 11.2 Failed");
            $display("expected pcRes: %b, actual pcRes: %b", 32'd4, pcRes);
            dutpassed = 0;
        end
        if (myPc !== 1'b0) begin
            $display("Test 11.2 Failed");
            $display("expected myPc: %b, actual myPc: %b", 0, myPc);
            dutpassed = 0;
        end
        if (aluRes !== 32'b1) begin
            $display("Test 11.2 Failed");
            $display("expected aluRes: %b, actual aluRes: %b", 32'd1, aluRes);
            dutpassed = 0;
        end

        if (dutpassed === 1) begin
            $display("Tests Passed");
        end
        $finish;
    end

endmodule
