module cpu
#(
	parameter cores = 1,
	parameter instruction_file = "helloworld"
)
(
	input clk
);
	
	// program counter
	reg [31:0] pc;

	// shared instruction memory
	wire [32*cores-1:0] dataOut;
	instructionmemory #(cores, instruction_file) im(.clk(clk),
												.address(pc),
												.dataOut(dataOut));


	// module to split the vliw into cores number of 32 bit instructions
	wire [cores-1:0] [32-1:0] instructions; 
	vliwsplitter #(cores) splitter (.clk(clk),
									.vliw(dataOut),
									.instructions(instructions));

	
	// generate cores number of controlTable modules (instruciton decoder + control table)
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
										.reg_we(reg_we[i]),
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

	// shared register file
	wire [cores-1:0] [31:0] regDataA;
	wire [cores-1:0] [31:0] regDataB;
	wire [cores-1:0] [31:0] regWriteData;
	registerfile #(cores) regfile ( .clk(clk),
									.write_enable(reg_we),
									.write_address(aw),
									.read_address_1(rs),
									.read_address_2(rt),
									.write_data(regWriteData),
									.read_data_1(regDataA),
									.read_data_2(regDataB));


  	// generate cores number of core modules
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

	// shared data memory
	wire [cores-1:0] [31:0] memDataOut;
	datamemory #(cores) dm (.clk(clk),
							.dataIn(regDataB),
							.address(aluRes),
							.writeEnable(mem_we),
							.dataOut(memDataOut));

	// 3-input mux to choose which data to write to the shared register file
	mux3 regwrite_mux (	.out(regWriteData),
						.address(reg_in),
						.input0(aluRes),
						.input1(memDataOut),
						.input2(pc + 4));

	// mux chain module to chose if the pc should jump or be pc + 4
	pcjumper #(cores) pcjump (	.pc_plus4(pc + 4),
								.core_pcs(pcRes),
								.core_controls(myPc),
								.next_pc(pc));

endmodule
