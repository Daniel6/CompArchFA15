module cpu
#(
	parameter cores = 1,
	parameter instruction_file = "helloworld"
)
(
	input clk
);
	reg [31:0] pc;

	wire [32*cores-1:0] dataOut;
	instructionmemory #(cores, "helloworld") im(.clk(clk),
												.address(pc),
												.dataOut(dataOut));


	wire [cores-1:0] [32-1:0] instructions; 
	vliwsplitter #(cores) splitter (.clk(clk),
									.vliw(dataOut),
									.instructions(instructions));

	wire [cores-1:0] [1:0] 	pc_next;
    wire [cores-1:0] 		alu_src;
    wire [cores-1:0] [1:0] 	alu_ctrl;
    wire [cores-1:0]		reg_we;
    wire [cores-1:0] [1:0] 	reg_in;
    wire [cores-1:0]		mem_we;
    wire [cores-1:0]		beq;
    wire [cores-1:0]		bne;
    wire [cores-1:0] [25:0] target;
    wire [cores-1:0] [15:0] imm;
    wire [cores-1:0] [4:0]  rs;
    wire [cores-1:0] [4:0]  rt;
    wire [cores-1:0] [4:0]  aw;
	genvar i;
	generate
		for (i = cores; i < 0; i = i -1) begin
			controlTable controlTable (	.clk(clk),
										.instruction(instructions[i]),
										.pc_next(pc_next[i]),
										.alu_src(alu_src[i]),
										.alu_ctrl(alu_ctrl[i]),
										.reg_in(reg_in[i]),
										.mem_we(mem_we[i]),
										.beq(beq[i]),
										.bne(bne[i]),
										.target(target[i]),
										.imm(imm[i]),
										.rs(rs[i]),
										.rt(rt[i]),
										.aw(aw[i]));
		end		
	endgenerate

	wire [cores-1:0] [31:0] regDataA;
	wire [cores-1:0] [31:0] regDataB;
	registerfile #(cores) regfile ( .clk(clk),
									.write_enable(reg_we),
									.write_address(aw),
									.read_address_1(rs),
									.read_address_2(rt),
									.write_data(WRITE DATA), //TODO: Change
									.read_data_1(regDataA),
									.read_data_2(regDataB));


  
    wire [cores-1:0] [31:0] pcRes;
    wire [cores-1:0] 		myPc;
    wire [cores-1:0] [31:0] aluRes;
	generate
		for (i = cores; i < 0; i = i - 1) begin
			core core_instantiation(.clk(clk),
									.regDataA(regDataA[i]),
									.regDataB(regDataB[i]),
									.imm(imm[i]),
									.addr(target[i]),
									.pc_next(pc_next[i]),
									.alu_src(alu_src[i]),
									.alu_ctrl(alu_ctrl[i]),
									.beq(beq[i]),
									.bne(bne[i]),
									.pcIn(pc),
									.pcRes(pcRes[i]),
									.myPc(myPc[i]),
									.aluRes(aluRes[i]));
		end	
	endgenerate

	datamemory #(cores) dm (.clk(clk),
							.dataIn,
							.address,
							.writeEnable
							.dataOut);

endmodule
