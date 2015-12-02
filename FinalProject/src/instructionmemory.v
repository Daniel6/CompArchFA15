//------------------------------------------------------------------------
// Instruction Memory
//   Positive edge triggered
//   dataOut always has the value mem[address]
//------------------------------------------------------------------------

module instructionmemory 
#(
    cores = 1,
    instructions = "one-core-memory.dat"
)
(
    input                       clk,
    input [31:0]                address,
    output reg [32*cores-1:0]   dataOut
)

    reg [32*cores-1:0] memory [2**32-1:0];

    initial $readmemh(instructions, memory);

    always @(posedge clk) begin
        dataOut <= memory[address];
    end

endmodule
