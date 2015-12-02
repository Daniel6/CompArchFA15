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
    input                                   clk,
    input[inst_len*cores-1:0]               vliw,
    output reg [cores-1:0] instructions [inst_len-1:0]
);
    always @(posedge clk) begin
        for (i = cores; i > 0; i = i - 1) begin
            // Split the vliw into individual instructions
            indexA = inst_len*(i)-1;
            indexB = inst_len*(i-1);
            instructions[i-1] <= vliw[indexA:indexB];
        end
    end
endmodule
