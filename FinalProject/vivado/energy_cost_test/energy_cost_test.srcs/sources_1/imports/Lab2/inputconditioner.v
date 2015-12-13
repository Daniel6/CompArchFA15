//------------------------------------------------------------------------
// Input Conditioner
//    1) Synchronizes input to clock domain
//    2) Debounces input
//    3) Creates pulses at edge transitions
//------------------------------------------------------------------------
module inputconditioner
(
  input clk,               // Clock domain to synchronize input to
  input noisysignal,       // (Potentially) noisy input signal
  output reg conditioned,  // Conditioned output signal
  output reg positiveedge, // 1 clk pulse at rising edge of conditioned
  output reg negativeedge  // 1 clk pulse at falling edge of conditioned
);
  parameter counterwidth = 3; // Counter size, in bits, >= log2(waittime)
  parameter waittime = 3;     // Debounce delay, in clock cycles (actual delay is n+2)
  reg[counterwidth - 1:0] counter = 0;
  reg synchronizer0 = 0;
  reg synchronizer1 = 0;

  initial begin
    conditioned = 0;
    negativeedge = 0;
    positiveedge = 0;
  end

  always @(posedge clk) begin
    if (conditioned == synchronizer1) begin
      counter <= 0;
      positiveedge <= 0;
      negativeedge <= 0;
    end
    else begin
      counter = counter+1;
      positiveedge <= 0;
      negativeedge <= 0;
    end
    if (conditioned != synchronizer1) begin
    if (counter == waittime) begin
      counter <= 0;
      conditioned <= synchronizer1;

      if (synchronizer1) begin
        positiveedge <= 1;
      end
      else begin
        negativeedge <= 1;
      end
    end
    end

    synchronizer0 <= noisysignal;
    synchronizer1 <= synchronizer0;
    
  end
endmodule
