iverilog -g 2005-sv ../src/multiplexer.v ../src/bitSlice.v ../src/fullAdder.v ../src/sltSlice.v ../src/alu.v ../src/core.v core.t.v -o ../bin/core.vvp && vvp ../bin/core.vvp
