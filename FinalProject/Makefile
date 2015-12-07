SOURCES := $(shell find ./src -name '*.v')

cputest: ./bin/add.vvp ./bin/beq.vvp ./bin/bne.vvp ./bin/j.vvp ./bin/jal.vvp ./bin/jr.vvp ./bin/lw.vvp ./bin/slt.vvp ./bin/sub.vvp ./bin/sw.vvp ./bin/xori.vvp ./bin/multi-core-adding.vvp
	vvp ./bin/add.vvp
	vvp ./bin/beq.vvp
	vvp ./bin/bne.vvp
	vvp ./bin/j.vvp
	vvp ./bin/jal.vvp
	vvp ./bin/jr.vvp
	vvp ./bin/lw.vvp
	vvp ./bin/slt.vvp
	vvp ./bin/sub.vvp
	vvp ./bin/sw.vvp
	vvp ./bin/xori.vvp
	vvp ./bin/multi-core-adding.vvp

./bin/%.vvp: $(SOURCES) ./test/cpu_tests/%.t.v
	iverilog -g 2005-sv -o $@ $^