module registerfile
#(
    parameter cores = 1
)
(
  output [cores-1:0] read_data_1 [31:0],
  output [cores-1:0] read_data_2 [31:0],
  input [cores-1:0] write_data [31:0],
  input [cores-1:0] read_address_1 [4:0],
  input [cores-1:0] read_address_2 [4:0],
  input [cores-1:0] write_address [4:0],
  input write_enable [cores-1:0],
  input clk
);
  reg [31:0] registers[31:0];
  initial begin
    registers[5'd0] = 32'b0;     // $zero
    registers[5'd29] = 32'h3ffc; // $sp
  end

  genvar i;
  generate
    for (i = cores; i > 0; i = i - 1) begin : WRITE
      always @(posedge clk) begin
        // if write enable flag is given and
        // the register to write to is not
        // the constant $zero, allow it
        if (write_enable[i] && (write_address[i] > 0)) begin
          registers[write_address[i]] = write_data[i];
        end
      end
    end
  endgenerate

  // output the values at the addressed registers
  generate
    for (i = cores; i > 0; i = i - 1) begin : READ
      assign read_data_1[i] = registers[read_address_1[i]];
      assign read_data_2[i] = registers[read_address_2[i]];
    end
  endgenerate
endmodule
