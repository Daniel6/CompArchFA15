module ALU (
    input [1:0] command,
    input [31:0] operandA,
    input [31:0] operandB,
    output reg [31:0] result,
    output carryout,
    output zero,
    output overflow
);
    assign carryout = 0;
    assign overflow = 0;
    assign zero = (result==0); //Zero is true if ALUOut is 0; goes anywhere
    always @(command, operandA, operandB) //reevaluate if these change
    case (command)
    0: result <= operandA + operandB; // add
    1: result <= operandA - operandB; // sub
    2: result <= operandA ^ operandB; // xor
    3: result <= operandA < operandB ? 1:0; // slt
    default: result <= 0; //default to 0, should not happen;
    endcase
endmodule