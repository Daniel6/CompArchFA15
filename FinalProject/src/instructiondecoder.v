/*
    Very Long Instruction Word Splitter
    Triggered on positive edge of clock signal

    Given a very long instruction word, output each instruction contained in the word
    eg: Given very long instruction word [abcd] where a, b, c, and d are instructions,
        output bus will output [a, b, c, d]

    Parameters:
        cores:      number of cores in CPU, also number of instructions in VLIW
        inst_len:   number of bits needed to contain one instruction
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
    output reg[4:0]     rd,
    output reg[4:0]     shft
    
);
    always @(posedge clk) begin
        op = instruction[31:26];
        rs = instruction[25:21];
        rt = instruction[20:16];
        rd = instruction[15:11];
        shft = instruction[10:6];
        func = instruction[5:0];
        imm = instruction[15:0];
        target = instruction[25:0];
    end
endmodule

module vliwsplitter
#(
    parameter cores = 1
    parameter inst_len = 32;
)
(
    input                                   clk,
    input[inst_len*cores-1:0]               vliw,
    output reg [cores-1:0][inst_len-1:0]    instructions
);
    always @(posedge clk) begin
        for (i = cores; i > 0; i = i - 1) begin
            // Split the vliw into individual instructions
            indexA = inst_len*(i)-1;
            indexB = inst_len*(i-1);
            instruction[i-1] <= vliw[indexA:indexB];
        end
    end
endmodule