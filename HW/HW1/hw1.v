module hw1test;
initial begin
$display("Hello World");
end
endmodule

module hw1;
reg A;
reg B;
wire nA;
wire nB;
wire AandB;
wire AorB;
wire output_1;
wire output_2;
wire output_3;
wire output_4;
and and1(AandB, A, B);
not AandBinv(output_1, AandB);
not Ainv(nA, A);
not Binv(nB, B);
or or1(output_2, nA, nB);
or or2(AorB, A, B);
not notAorB(output_3, AorB);
and and2(output_4, nA, nB);
initial begin
$display("A B | ~A ~B | ~(AB) | ~A+~B | ~(A+B) | ~A~B ");
A=0;B=0; #1
$display("%b %b |  %b  %b |   %b   |   %b   |   %b    |   %b ", A, B, nA, nB, output_1, output_2, output_3, output_4);
A=0;B=1; #1
$display("%b %b |  %b  %b |   %b   |   %b   |   %b    |   %b ", A, B, nA, nB, output_1, output_2, output_3, output_4);
A=1;B=0; #1
$display("%b %b |  %b  %b |   %b   |   %b   |   %b    |   %b ", A, B, nA, nB, output_1, output_2, output_3, output_4);
A=1;B=1; #1
$display("%b %b |  %b  %b |   %b   |   %b   |   %b    |   %b ", A, B, nA, nB, output_1, output_2, output_3, output_4);
end
endmodule
