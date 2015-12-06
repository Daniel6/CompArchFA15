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

    initial $readmemb(instructions, memory);
    // integer i;
    // initial begin
    //     for (i = 0; i < 8; i = i + 1) begin
    //         $display("%b", memory[i]);
    //     end
    // end

    always @(address) begin
        $display("ADDRESS %b", address>>2);
        dataOut <= memory[address>>2];
    end

endmodule
