//------------------------------------------------------------------------
// Data Memory
//   Positive edge triggered
//   dataOut always has the value mem[address]
//------------------------------------------------------------------------

module datamemory 
#(
    parameter cores = 1
    // parameter data = "datamemory.dat"
)
(
    input                           clk,
    input [cores-1:0] [31:0]        dataIn,
    input [cores-1:0] [31:0]        address,
    input [cores-1:0]               writeEnable,
    output reg [cores-1:0] [31:0]   dataOut
);

    reg [31:0] memory [2**10-1:0];

    // initial $readmemb(data, memory);

    genvar i;
    generate
        for (i = cores-1; i >= 0; i = i - 1) begin : WRITE
            always @(posedge clk) begin
                // if write enable flag is given, allow it
                if (writeEnable[i]) begin
                    memory[address[i]] <= dataIn[i];
                end
            end 

            // output the values at the addressed memory
            assign dataOut[i] = memory[address[i]];

        end  
    endgenerate

endmodule
