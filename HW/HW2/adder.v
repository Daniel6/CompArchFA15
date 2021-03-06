`define XOR xor #50
`define AND and #50
`define OR or #50

module behavioralFullAdder(sum, carryout, a, b, carryin);
output sum, carryout;
input a, b, carryin;
assign {carryout, sum}=a+b+carryin;
endmodule

module structuralFullAdder(out, carryout, a, b, carryin);
output out, carryout;
input a, b, carryin;
wire AxorB, carryout_condition1, carryout_condition2;
`XOR xor1(AxorB, a, b);
`AND and1(carryout_condition1, AxorB, carryin); // If only one of a and b is high, and carryin is high, then carryout is high
`AND and2(carryout_condition2, a, b); // If both a and b are high, then carryout is high
`OR or1(carryout, carryout_condition1, carryout_condition2);
`XOR xor2(out, AxorB, carryin); // Sum is high only when only one of a or b is high or both are matching values and carryin is high
endmodule

module testFullAdder;
reg a, b, carryin;
wire sum, carryout, test_sum, test_carryout;
behavioralFullAdder model (sum, carryout, a, b, carryin);
structuralFullAdder test (test_sum, test_carryout, a, b, carryin);

initial begin
$display("Cin A B | Sum Cout | Expected");
carryin=0; a=0; b=0; #1000
$display(" %b  %b %b |  %b    %b  | %b  %b ", carryin, a, b, test_sum, test_carryout, sum, carryout);
carryin=0; a=1; b=0; #1000
$display(" %b  %b %b |  %b    %b  | %b  %b ", carryin, a, b, test_sum, test_carryout, sum, carryout);
carryin=0; a=0; b=1; #1000
$display(" %b  %b %b |  %b    %b  | %b  %b ", carryin, a, b, test_sum, test_carryout, sum, carryout);
carryin=0; a=1; b=1; #1000
$display(" %b  %b %b |  %b    %b  | %b  %b ", carryin, a, b, test_sum, test_carryout, sum, carryout);
carryin=1; a=0; b=0; #1000
$display(" %b  %b %b |  %b    %b  | %b  %b ", carryin, a, b, test_sum, test_carryout, sum, carryout);
carryin=1; a=1; b=0; #1000
$display(" %b  %b %b |  %b    %b  | %b  %b ", carryin, a, b, test_sum, test_carryout, sum, carryout);
carryin=1; a=0; b=1; #1000
$display(" %b  %b %b |  %b    %b  | %b  %b ", carryin, a, b, test_sum, test_carryout, sum, carryout);
carryin=1; a=1; b=1; #1000
$display(" %b  %b %b |  %b    %b  | %b  %b ", carryin, a, b, test_sum, test_carryout, sum, carryout);
end
endmodule
