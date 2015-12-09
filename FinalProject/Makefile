SOURCES := $(shell find ./src -type f -name '*.v')
CPU_TEST_DIR := ./test/cpu_tests
BIN := ./bin
WAVEFORMS := ./waveforms
TEST_EXT := t.v
VVP := $(patsubst $(CPU_TEST_DIR)/%.$(TEST_EXT),./bin/%.vvp,$(shell find $(CPU_TEST_DIR) -name '*.$(TEST_EXT)'))
RUNS := $(patsubst ./bin/%.vvp,./bin/%.run,$(VVP))

cputest: $(RUNS)

$(BIN)/%.run: $(BIN)/%.vvp
	mkdir -p $(WAVEFORMS)
	vvp $<

$(BIN)/%.vvp: $(SOURCES) $(CPU_TEST_DIR)/%.t.v
	mkdir -p $(BIN)
	iverilog -g 2005-sv -o $@ $^

clean:
	find $(BIN) $(WAVEFORMS) -type f -name '*' -exec rm {} \;

.PHONY: clean

.SECONDARY: $(VVP)
