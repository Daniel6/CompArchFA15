module core
(
    input clk,
    input [31:0] regDataA,
    input [31:0] regDataB,
    input [15:0] imm,
    input [25:0] addr,
    input [1:0] pc_next,
    input [1:0] reg_dst,
    input alu_src,
    input [1:0] alu_ctrl,
    input reg_we,
    input [1:0] reg_in,
    input mem_we,
    input beq,
    input bne,
    output [31:0] pcIn,
    output myPc
);

    // Program Counter
    assign pcAddOut = pcOut + pcAddMuxOut;
    mux4 pcMux(.out(pcIn),
               .address(pc_next),
               .input0(pcAddOut),
               .input1(pcJump),
               .input2(regDataA));

    // selector for pc
    myPc = (branch | pc_next[0] | pc_next[1]);

    // Program Counter Adder
    wire [31:0] pcAddOut, pcAddMuxOut;
    mux2 pcAddMux(.out(pcAddMuxOut),
                  .address(branch),
                  .input0(4),
                  .input1(4 * seImm + 4));

    // Concatenator
    wire [31:0] pcJump;
    assign pcJump = { pcOut[31:28], addr, 2'b00 };

    // Sign Extender
    wire [31:0] seImm;
    assign seImm = { { 16 { imm16Out[15] } }, imm16Out };



    wire [4:0] ra = 5'd31;

    mux4 regWriteAddrMux(.out(regWriteAddr),
                         .address(RegDst),
                         .input0(rtOut),
                         .input1(rdOut),
                         .input2(ra));

    assign regAddrA = rsOut;
    assign regAddrB = rtOut;

    mux4 regDataWriteMux(.out(regDataIn),
                         .address(RegIn),
                         .input0(aluResult),
                         .input1(dataMemOut),
                         .input2(pcAddOut));

    // ALU
    wire [31:0] aluResult, aluOpA, aluOpB;
    wire aluCarryout, aluZero, aluOverflow;
    wire [2:0] aluCommand;
    ALU alu(.result(aluResult),
            .carryout(aluCarryOut),
            .zero(aluZero),
            .overflow(aluOverflow),
            .operandA(aluOpA),
            .operandB(aluOpB),
            .command(AluCtrl));

    assign aluOpA = regDataA;

    mux2 aluBMux(.out(aluOpB),
                 .address(AluSrc),
                 .input0(seImm),
                 .input1(regDataB));

    // Branch Control
    wire branch;
    assign branch = ((BEQ & aluZero) | (BNE & ~aluZero));

    // Data Memory
    wire [31:0] dataMemDataOut, dataMemAddr, dataMemDataIn;
    datamemory dataMem(.clk(clkOut),
                       .dataOut(dataMemOut),
                       .address(dataMemAddr),
                       .writeEnable(MemWe),
                       .dataIn(dataMemDataIn));

    assign dataMemAddr = aluResult;
    assign dataMemDataIn = regDataB;

    // Control Table
    controlTable controls(.clk(clkOut),
                          .op(opOut),
                          .funct(functOut),
                          .pc_next(PcNext),
                          .reg_dst(RegDst),
                          .alu_src(AluSrc),
                          .alu_ctrl(AluCtrl),
                          .reg_we(RegWe),
                          .reg_in(RegIn),
                          .mem_we(MemWe),
                          .beq(BEQ),
                          .bne(BNE));

    initial begin
        $dumpfile("cpu.vcd"); //dump info to create wave propagation later
        $dumpvars(0, cpu);

        #10;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        // check our result registers!
        #20
        $display("regA: %d, at address: %h", regDataA, regAddrA);
        #20
        $display("regA: %d, at address: %h", regDataA, regAddrA);
        #20
        $display("regA: %d, at address: %h", regDataA, regAddrA);
        #20
        $display("regA: %d, at address: %h", regDataA, regAddrA);
        #20
        $display("regA: %d, at address: %h", regDataA, regAddrA);
        #20
        $display("regA: %d, at address: %h", regDataA, regAddrA);
        #20
        $display("regA: %d, at address: %h", regDataA, regAddrA);
        #20
        $display("regA: %d, at address: %h", regDataA, regAddrA);
        $finish;
    end

endmodule
