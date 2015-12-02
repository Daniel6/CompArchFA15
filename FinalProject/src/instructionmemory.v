//------------------------------------------------------------------------
// Instruction Memory
//   Positive edge triggered
//   dataOut always has the value mem[address]
//------------------------------------------------------------------------

module instructionmemory 
#(
    parameter cores = 1,
    parameter instructions = "one-core-memory.dat"
)
(
    input                       clk,
    input [31:0]                address,
    output reg [32*cores-1:0]   dataOut
);

    reg [32*cores-1:0] memory [2**10-1:0];

    initial $readmemh(instructions, memory);

    always @(posedge clk) begin
        dataOut <= memory[address];
    end

endmodule
