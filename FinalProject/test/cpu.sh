#!/usr/bin/sh
iverilog -W no-portbind -W no-implicit -g 2005-sv -o ../bin/cpu.vvp ../src/pc.v ../src/alu.v ../src/bitSlice.v ../src/controlTable.v ../src/core.v ../src/cpu.v ../src/datamemory.v ../src/fullAdder.v ../src/instructiondecoder.v ../src/instructionmemory.v ../src/multiplexer.v ../src/pcjumper.v ../src/registerfile.v ../src/sltSlice.v ../src/vliwsplitter.v ./cpu_tests/*.t.v && vvp ../bin/cpu.vvp
