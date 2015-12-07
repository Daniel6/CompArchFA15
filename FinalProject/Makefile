SOURCES := $(shell find ./src -name '*.v')

cputest: ./bin/add.vvp ./bin/beq.vvp ./bin/bne.vvp
	vvp ./bin/add.vvp
	vvp ./bin/beq.vvp
	vvp ./bin/bne.vvp

./bin/%.vvp: $(SOURCES) ./test/cpu_tests/%.t.v
	iverilog -g 2005-sv -o $@ $^