module bitSlice (
    output out,
    output addCarryout,
    output sltKout, // 1 if this bit pair and all more significant
                    // bit pairs are equal
    output sltAnsOut, // SLT answer, if determined before or within this block
    input a,
    input b,
    input[2:0] s, // function selector
    input addCarryIn,
    input sltKin, // 1 if all more significant bit pairs are equal
    input sltAnsIn, // SLT answer, if determined before this block
    input first // 1 if this is the first bit slice
);

    wire[7:0] results;

    fullAdder adder(results[0], addCarryout, a, b, addCarryIn);
    buf(results[1], results[0]);
    xor(results[2], a, b);
    sltSlice slt(results[3], sltKout, sltAnsOut, sltKin, sltAnsIn, a, b, first);
    and(results[4], a, b);
    not(results[5], results[4]);
    not(results[6], results[7]);
    or(results[7], a, b);

    multiplexer mux(out, s, results);

endmodule
