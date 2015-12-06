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

module vliwsplitter
#(
    parameter cores = 1,
    parameter inst_len = 32
)
(
    input clk,
    input [inst_len*cores-1:0]               vliw,
    output reg  [cores-1:0] [inst_len-1:0] instructions
);

    genvar i;
    generate
        for (i = cores; i > 0; i = i - 1) begin : SPLIT
            // Split the vliw into individual instructions
            always @(vliw) begin
                instructions[i-1] <= vliw[inst_len*i-1:inst_len*(i-1)];
            end
        end
    endgenerate
endmodule
