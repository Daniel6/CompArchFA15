/*
    Instruction Decoder
    Triggered on positive edge of clock signal

    Given a 32-bit instruction, output the relevant parts of the instruction as individual outputs.
*/

module instructiondecoder
(
    input               clk,
    input[31:0]         instruction,
    output reg[25:0]    target,
    output reg[15:0]    imm,
    output reg[5:0]     op,
    output reg[5:0]     func,
    output reg[4:0]     rs,
    output reg[4:0]     rt,
    output reg[4:0]     rd

);
    always @(posedge clk) begin
        op = instruction[31:26];
        rs = instruction[25:21];
        rt = instruction[20:16];
        rd = instruction[15:11];
        func = instruction[5:0];
        imm = instruction[15:0];
        target = instruction[25:0];
    end
endmodule
