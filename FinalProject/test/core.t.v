
//-------------------------------
// Instruction Decoder Test
//-------------------------------

module testCore;

    reg clk;
    reg [31:0] regDataA;
    reg [31:0] regDataB;
    reg [15:0] imm;
    reg [25:0] addr;
    reg [1:0] pc_next;
    reg [1:0] reg_dst;
    reg alu_src;
    reg [2:0] alu_ctrl;
    reg reg_we;
    reg [1:0] reg_in;
    reg mem_we;
    reg beq;
    reg bne;
    reg [31:0] pcIn;
    reg myPc;
    reg [31:0] dataMemAddr;

    reg dutpassed;

    core DUT(.clk(clk),
               .regDataA(regDataA),
               .regDataB(regDataB),
               .imm(imm),
               .addr(addr),
               .pc_next(pc_next),
               .reg_dst(reg_dst),
               .alu_src(alu_src),
               .alu_ctrl(alu_ctrl),
               .reg_we(reg_we),
               .reg_in(reg_in),
               .mem_we(mem_we),
               .beq(beq),
               .bne(bne),
               .pcIn(pcIn),
               .myPc(myPc),
               .dataMemAddr(dataMemAddr));

    initial begin
        $dumpfile("core.vcd"); //dump info to create wave propagation later
        $dumpvars(0, testCore);

        $display("Testing core");

        dutpassed = 1;

        $finish;

    end

endmodule
