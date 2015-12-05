module pcjumper
#(
	parameter cores = 1
)
(
	input [31:0]				pc_plus4,
	input [cores-1:0] [31:0]	core_pcs,
	input [cores-1:0] [31:0]	core_controls,
	output [31:0]				next_pc
);

	wire[cores-1:0] internal_wires[31:0];

	generate
		genvar i;
		for (i = cores; i > 0; i = i -1) begin
			begin : gen1
				if (cores == 1) begin
					// If only one core, act as one multiplexer
					multiplexer mux2(next_pc, core_controls[0], pc_plus4, core_pcs[0]);
				end
				else if (i == cores) begin
					// First multiplexer in chain takes PC+4 as first input
					multiplexer mux2(internal_wires[cores-1], core_controls[cores-1], pc_plus4, core_pcs[cores-1]);
				end
				else if (i == 1) begin
					// Last multiplexer in chain outputs to module output
					multiplexer mux2(next_pc, core_controls[0], internal_wires[1], core_pcs[0]);
				end
				else begin
					// All other multiplexers in chain hook up to each other
					multiplexer mux2(internal_wires[i-1], core_controls[i-1], internal_wires[i], core_pcs[i-1]);
				end
			end
		end
	endgenerate
endmodule