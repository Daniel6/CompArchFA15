`define AND and #50
`define NAND nand #50
`define OR or #50
`define NOT not #50

module behavioralMultiplexer(out, address0,address1, in0,in1,in2,in3);
output out;
input address0, address1;
input in0, in1, in2, in3;
wire[3:0] inputs = {in3, in2, in1, in0};
wire[1:0] address = {address1, address0};
assign out = inputs[address];
endmodule

module structuralMultiplexer(out, address0,address1, in0,in1,in2,in3);
output out;
input address0, address1;
input in0, in1, in2, in3;
wire nAddress0, nAddress1;
wire control0, control1, control2, control3;
wire out0, out1, out2, out3, inter0, inter1;
`NOT not0(nAddress0, address0);
`NOT not1(nAddress1, address1);
`AND and0(control0, nAddress0, nAddress1);
`AND and1(control1, address0, nAddress1);
`AND and2(control2, nAddress0, address1);
`AND and3(control3, address0, address1);
`AND and4(out0, control0, in0);
`AND and5(out1, control1, in1);
`AND and6(out2, control2, in2);
`AND and7(out3, control3, in3);
`OR or0(inter0, out0, out1);
`OR or1(inter1, out2, out3);
`OR or2(out, inter0, inter1);
endmodule


module testMultiplexer;
reg address0, address1, in0, in1, in2, in3;
wire test_out, out;
behavioralMultiplexer model (out, address0, address1, in0, in1, in2, in3);
structuralMultiplexer test (test_out, address0, address1, in0, in1, in2, in3);
initial begin
$display("A0 A1 0 1 2 3 | Output | Expected");
address0=0;address1=0;in0=1;in1=0;in2=0;in3=0; #1000 
$display("%b  %b  %b %b %b %b |    %b   | %b", address0, address1, in0, in1, in2, in3, test_out, out);
address0=0;address1=0;in0=0;in1=1;in2=1;in3=1; #1000 
$display("%b  %b  %b %b %b %b |    %b   | %b", address0, address1, in0, in1, in2, in3, test_out, out);
address0=1;address1=0;in0=0;in1=1;in2=0;in3=0; #1000 
$display("%b  %b  %b %b %b %b |    %b   | %b", address0, address1, in0, in1, in2, in3, test_out, out);
address0=1;address1=0;in0=1;in1=0;in2=1;in3=1; #1000 
$display("%b  %b  %b %b %b %b |    %b   | %b", address0, address1, in0, in1, in2, in3, test_out, out);
address0=0;address1=1;in0=0;in1=0;in2=1;in3=0; #1000 
$display("%b  %b  %b %b %b %b |    %b   | %b", address0, address1, in0, in1, in2, in3, test_out, out);
address0=0;address1=1;in0=1;in1=1;in2=0;in3=1; #1000 
$display("%b  %b  %b %b %b %b |    %b   | %b", address0, address1, in0, in1, in2, in3, test_out, out);
address0=1;address1=1;in0=0;in1=0;in2=0;in3=1; #1000 
$display("%b  %b  %b %b %b %b |    %b   | %b", address0, address1, in0, in1, in2, in3, test_out, out);
address0=1;address1=1;in0=1;in1=1;in2=1;in3=0; #1000 
$display("%b  %b  %b %b %b %b |    %b   | %b", address0, address1, in0, in1, in2, in3, test_out, out);
end
endmodule
