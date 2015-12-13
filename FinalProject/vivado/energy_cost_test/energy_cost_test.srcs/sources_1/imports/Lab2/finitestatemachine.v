module finitestatemachine
(
  input sclk,
  input cs,
  input shiftRegOutP0,
  output reg sr_we,
  output reg addr_we,
  output reg dm_we,
  output reg miso_enable,
  output reg[2:0] state
);
  parameter state_GETTING = 0;
  parameter state_GOT     = 1;
  parameter state_READ_1  = 2;
  parameter state_READ_2  = 3;
  parameter state_READ_3  = 4;
  parameter state_WRITE_1 = 5;
  parameter state_WRITE_2 = 6;
  parameter state_DONE    = 7;
  reg[3:0] count;

  initial begin
    count = 0;
    state = 0;
    miso_enable = 0;
    sr_we = 0;
    addr_we = 0;
    dm_we = 0;
  end

  always @(posedge sclk) begin
    if (cs) begin
      state = state_GETTING;
      count = 0;
    end

    else begin
      if (state == state_GETTING) begin
        if (count == 8) begin
          state = state_GOT;
        end
        else begin
          count = count + 1;
        end
      end
      else if (state == state_GOT) begin
        addr_we = 1;
        count = 0;
        if (shiftRegOutP0 == 0) begin
          state = state_READ_1;
        end
        else begin
          state = state_WRITE_1;
        end
      end
      else if (state == state_READ_1) begin
        state = state_READ_2;
      end
      else if (state == state_READ_2) begin
        sr_we = 1;
        state = state_READ_3;
      end
      else if (state == state_READ_3) begin
        miso_enable = 1;
        if (count == 8) begin
          state = state_DONE;
        end
        else begin
          count = count + 1;
        end
      end
      else if (state == state_WRITE_1) begin
        if (count == 8) begin
          state = state_WRITE_2;
        end
        else begin
          count = count + 1;
        end
      end
      else if (state == state_WRITE_2) begin
        dm_we = 1;
        state = state_DONE;
      end
      else if (state == state_DONE) begin
        count = 0;
        miso_enable = 0;
        sr_we = 0;
        addr_we = 0;
        dm_we = 0;
      end
    end
  end
endmodule
