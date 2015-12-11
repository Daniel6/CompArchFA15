# Structure


# Analysis

## Performance
### What programs run faster
#### String Reversal
Reverse the order of characters in a string of length n stored in memory

- 1-core: 								6 + 9(n/2-1) + 8 cycles
- 2-core: 								3 + 5(n/2) cycles
- 4-core: 								2 + 4(n/2) cycles
- 4-core (w/ multi-core optimization): 	3 + 3(n/2) cycles or 4 cycles if string is 1 char or less

Eg: n=8

- 1-core: 							 41 cycles (100% speed)
- 2-core: 							 23 cycles (178%)
- 4-core: 							 18 cycles (228%)
- 4-core (w/ multi-core optimization): 15 cycles (273%)

Eg: n=3

- 1-core: 							 14 cycles (100% speed)
- 2-core: 							 8 cycles  (175%)
- 4-core: 							 6 cycles  (233%)
- 4-core (w/ multi-core optimization): 4 cycles  (350%)

Eg: n=27
- 1-core: 							 122 cycles (100% speed)
- 2-core: 							 68 cycles  (179%)
- 4-core: 							 54 cycles  (226%)
- 4-core (w/ multi-core optimization): 42 cycles  (286%)

#### Division

Compute integer division with a remainder

1-core: 7 + 4*(a/b)
2-core: 5 + 3*(a/b)
4-core: 4 + 3*(a/b)

Eg. a=5, b=2
1-core: 15 cycles (100% speed)
2-core: 11 cycles (127%)
4-core: 10 cycles (133%)

Eg. a=100, b=1
1-core: 407 cycles (100% speed)
2-core: 305 cycles (125%)
4-core: 304 cycles (125%)

Eg. a=0, b=2
1-core: 7 cycles (100% speed)
2-core: 5 cycles (129%)
4-core: 4 cycles (143%)

#### Array Sorting
Use bubble sort to sort the array [14, 12, 13, 5, 9, 11, 3, 7, 10] stored in memory from highest to lowest.

- 1-core: 388 cycles (100% speed)
- 4-core: 297 cycles

### Multiply
Multiplies two variables in memory.

- 1-Core: 34 Cycles
- 4-Core: 17 Cycles

### What programs run slower

## Area

In order for our CPU to have higher performance, we had to have the tradeoff of having a larger area than a typical single-cycle MIPS CPU.

We based our area calculations off of the size of fundamental gates, with AND, OR, and XOR being comprised of their negative counterparts and a NOT gate.

### Fundamental gates

| Gate (N inputs each) | Cost per |
| -------------------- | ---      |
| NOT                  | 1        |
| NAND                 | 2N       |
| NOR                  | 2N       |
| XNOR                 | 2N       |
| AND                  | 2N+1     |
| OR                   | 2N+1     |
| XOR                  | 2N+1     |

### Program Counter

The program counter (PC) holds a 32 bit address that signifies the location in the instruction memory of the current instruction. At the positive edge of each clock cycle, the input is propagated through as the new output. We estimate that the program counter requires the following subcomponents.

| Subcomponent | Quantity | Unit Size | Total Size |
|:------------:|:--------:|:---------:|:----------:|
| Positive Edge Triggered DFF  |    32    |     13     |    416     |
|              |          |           |    416    |

### Adder

In order to increment the program counter after each cycle, an adder is used. This adder must be able to handle unsigned 32 bit additions. The table below shows the estimated cost.

| Subcomponent     | Quantity | Unit Size | Total Size |
|:----------------:|:--------:|:---------:|:----------:|
| 1 Bit Full Adder |    32    |    15     |    480     |
|                  |          |           |    480     |

### Instruction Memory

The instruction memory stores program operations. Each instruction requires 32N bits of space, where N is the number of cores in our CPU. Based on the input address supplied, a corresponding instruction will be output at the positive edge of each clock cycle. We estimate the size of this component as follows.

//TODO: Change

| Subcomponent            | Quantity | Unit Size | Total Size |
|:-----------------------:|:--------:|:---------:|:----------:|
| D Flip Flop with Enable |  32,768  |    11     |   360,448  |
| 1024 Option Mux         |  32      |  34,813   |  1,113,002 |
|                         |          |           |  1,473,450 |

### VLIW Splitter

The VLIW splitter takes the 32N bit instruction and splits it into N different 32 bit instructions, with the Nth instruction being sent to the Nth core. This component only uses wires, no gates.

### Instruction Decoder

The instruction decoder breaks up the 32 bit instruction into its individual parts. This is done simply with wires and requires no gates.

### Sign Extender

The sign extender converts a signed 16 bit immediate into a signed 32 bit number. This is simply done by wiring the most significant bit of the 16 bit number to the top 16 bits of the 32 bit instruction. The rest of the bits are wired to the same location in the new number. This requires no gates.

### Concatenator

The concatenator merges three values into a single 32 bit value. This is simply done by wiring the inputs into the output. This requires no gates.

### Register File

//TODO: Change ports

The register file is similar to the instruction memory. The registers support writing to one of the 32 locations at a time and reading from two different address simultaneously. The estimated size is as follows.

| Subcomponent            | Quantity | Unit Size | Total Size |
|:-----------------------:|:--------:|:---------:|:----------:|
| D Flip Flop with Enable |  1024    |    11     |   11,264   |
| 32 Option Mux           |  64      |  605      |  38,693    |
|                         |          |           |  49,957    |


### Data Memory

The data memory is exactly the same as the instruction memory, except that it holds data values rather than instructions. The sizing is the same.

| Subcomponent            | Quantity | Unit Size | Total Size |
|:-----------------------:|:--------:|:---------:|:----------:|
| D Flip Flop with Enable |  32,768  |    11     |   360,448  |
| 1024 Option Mux         |  32      |  34,813   |  1,113,002 |
|                         |          |           |  1,473,450 |


### ALU

The ALU allows the CPU to compute mathematical operations. This component operates on 32 bit operands. The table below describes its size.

| Subcomponent | Quantity | Unit Size | Total Size |
|:------------:|:--------:|:---------:|:----------:|
| Bit Slice    |  32      |    197    |   6,304     |
| NOT Gate     |  5       |    1      |   5        |
| XNOR Gate    |  2       |    2      |   4        |
| AND Gate     |  11      |    3      |   33       |
| OR Gate      |  1       |    3      |   3        |
| NOR Gate     |  32      |    2      |   64       |
|              |          |           |  6,413      |


### Additional Components

The following components are used within the cpu, outside of any other subcomponent.

| Subcomponent | Quantity | Unit Size | Total Size |
|:------------:|:--------:|:---------:|:----------:|
| AND Gate     |  11      |    3      |   33       |
| OR Gate      |  1       |    3      |   3        |
|              |          |           |  36        |

#### Total

The grand total size is calculated in the following table.

| Subcomponent       | Quantity | Unit Size    | Total Size  |
|:------------------:|:--------:|:------------:|:-----------:|
| Adder              |  1       |    480       |   480       |
| Program Counter    |  1       |    288       |   288       |
| Instruction Memory |  1       |   1,473,450  |   1,473,450 |
| Registers          |  1       |    49,957    |   49,957    |
| Data Memory        |  1       |    1,473,450 |   1,473,450 |
| ALU                |  1       |    6,413     |   6,413     |
| AND Gate           |  11      |    3         |   33        |
| OR Gate            |  1       |    3         |   3         |
|                    |          |              |   3,004,074 |

## Energy

# Testing Strategy

## Unit Tests

## CPU Instruction Tests

## Analysis Testings
