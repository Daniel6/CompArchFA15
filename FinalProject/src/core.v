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
    input [31:0] pcIn,
    output [31:0] pcRes,
    output myPc,
    output [31:0] aluRes
);

    // Program Counter
    wire [31:0] pcJump;
    wire [31:0] seImm;
    wire [31:0] pcAddOut;
    assign pcAddOut = pcIn + pcAddMuxOut;
    mux4 pcMux(.out(pcRes),
               .address(pc_next),
               .input0(pcAddOut),
               .input1(pcJump),
               .input2(regDataA));

    // selector for pc
    assign myPc = (branch | pc_next[0] | pc_next[1]);

    // Program Counter Adder
    wire [31:0] pcAddMuxOut;
    mux2 pcAddMux(.out(pcAddMuxOut),
                  .address(branch),
                  .input0(4),
                  .input1(4 * seImm + 4));

    // Concatenator
    assign pcJump = { pcIn[31:28], addr, 2'b00 };

    // Sign Extender
    assign seImm = { { 16 { imm[15] } }, imm };

    // ALU
    wire [31:0] aluOpA, aluOpB;
    wire aluCarryout, aluZero, aluOverflow;
    ALU alu(.result(aluRes),
            .carryout(aluCarryOut),
            .zero(aluZero),
            .overflow(aluOverflow),
            .operandA(aluOpA),
            .operandB(aluOpB),
            .command(alu_ctrl));

    assign aluOpA = regDataA;

    mux2 aluBMux(.out(aluOpB),
                 .address(AluSrc),
                 .input0(seImm),
                 .input1(regDataB));

    // Branch Control
    assign branch = ((beq & aluZero) | (bne & ~aluZero));

endmodule
