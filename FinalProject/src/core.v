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
    output myPc,
    output dataMemAddr
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

    // ALU
    wire [31:0] aluOpA, aluOpB;
    wire aluCarryout, aluZero, aluOverflow;
    wire [2:0] aluCommand;
    ALU alu(.result(dataMemAddr),
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

endmodule
