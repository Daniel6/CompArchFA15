iverilog -g 2005-sv -o ../bin/core.vvp ../src/multiplexer.v ../src/bitSlice.v ../src/fullAdder.v ../src/sltSlice.v ../src/alu.v ../src/core.v core.t.v  && vvp ../bin/core.vvp
