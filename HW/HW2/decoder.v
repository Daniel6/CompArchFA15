`define NOR nor #50
`define AND and #50
`define NOT not #50

module behavioralDecoder(out0,out1,out2,out3, address0,address1, enable);
output out0, out1, out2, out3;
input address0, address1;
input enable;
assign {out3,out2,out1,out0}=enable<<{address1,address0};
endmodule

module structuralDecoder(out0,out1,out2,out3, address0,address1, enable);
output out0, out1, out2, out3;
input address0, address1;
input enable;
wire neitherA0norA1, nAddress0, nAddress1, onlyAddress0, onlyAddress1, both;
`NOR nor1(neitherA0norA1, address0, address1);
`AND and1(out0, neitherA0norA1, enable);
`NOT not1 (nAddress0, address0);
`NOT not2 (nAddress1, address1);
`AND and2(onlyAddress0, address0, nAddress1);
`AND and3(onlyAddress1, address1, nAddress0);
`AND and4(out1, onlyAddress0, enable);
`AND and5(out2, onlyAddress1, enable);
`AND and6(both, address0, address1);
`AND and7(out3, both, enable);
endmodule

module testDecoder; 
reg addr0, addr1;
reg enable;
wire out0, out1, out2, out3;
wire test0, test1, test2, test3;
behavioralDecoder decoder (out0,out1,out2,out3,addr0,addr1,enable);
structuralDecoder test (test0,test1,test2,test3,addr0,addr1,enable); // Swap after testing

initial begin
$display("En A0 A1| O0 O1 O2 O3 | Expected Output");
enable=0;addr0=0;addr1=0; #1000 
$display("%b  %b  %b |  %b  %b  %b  %b  | %b  %b  %b  %b", enable, addr0, addr1, test0, test1, test2, test3, out0, out1, out2, out3);
enable=0;addr0=1;addr1=0; #1000
$display("%b  %b  %b |  %b  %b  %b  %b  | %b  %b  %b  %b", enable, addr0, addr1, test0, test1, test2, test3, out0, out1, out2, out3);
enable=0;addr0=0;addr1=1; #1000 
$display("%b  %b  %b |  %b  %b  %b  %b  | %b  %b  %b  %b", enable, addr0, addr1, test0, test1, test2, test3, out0, out1, out2, out3);
enable=0;addr0=1;addr1=1; #1000 
$display("%b  %b  %b |  %b  %b  %b  %b  | %b  %b  %b  %b", enable, addr0, addr1, test0, test1, test2, test3, out0, out1, out2, out3);
enable=1;addr0=0;addr1=0; #1000 
$display("%b  %b  %b |  %b  %b  %b  %b  | %b  %b  %b  %b", enable, addr0, addr1, test0, test1, test2, test3, out0, out1, out2, out3);
enable=1;addr0=1;addr1=0; #1000 
$display("%b  %b  %b |  %b  %b  %b  %b  | %b  %b  %b  %b", enable, addr0, addr1, test0, test1, test2, test3, out0, out1, out2, out3);
enable=1;addr0=0;addr1=1; #1000 
$display("%b  %b  %b |  %b  %b  %b  %b  | %b  %b  %b  %b", enable, addr0, addr1, test0, test1, test2, test3, out0, out1, out2, out3);
enable=1;addr0=1;addr1=1; #1000 
$display("%b  %b  %b |  %b  %b  %b  %b  | %b  %b  %b  %b", enable, addr0, addr1, test0, test1, test2, test3, out0, out1, out2, out3);
end
endmodule
