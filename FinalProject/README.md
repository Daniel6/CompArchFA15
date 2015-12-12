# Multi-Core Processor using VLIW

## Overview

We have designed and written, in verilog, a MIPS single cycle pseudo multi-core processor utilizing VLIW. Our goal is that our processor can run programs quicker than the standard MIPS single cycle processor.

For more information, please see our [project abstract](https://github.com/Daniel6/CompArchFA15/blob/master/FinalProject/Project%20Abstract.md "ProjectAbstract.md").

## Requirements

### System verilog

Install iverilog version 10.0

#### On Linux:
- install from git: http://iverilog.wikia.com/wiki/Installation_Guide
  - use "Obtaining Source From git" and "Compiling on Linux/Unix"

#### On a Mac:
- install using [Homebrew](http://brew.sh/ "Homebrew"): `brew install icarus-verilog`
- the most updated version of iverilog installed with Homebrew should be fine (if there are problems make sure to run `brew upgrade` and `brew update` in terminal)


## How to run
make 

## Documentation

For a description of our processor's structure and analysis of our architecture, please see our [Documentation.md](https://github.com/Daniel6/CompArchFA15/blob/master/FinalProject/Documentation.md "Documentation.md").

## Open-ended Development
Feel free to build on top of our progress, some interesting areas for further development would be:
* MIPS -> our custom VLIW compiler
* Replace our single-cycle architecture with a pipelined system
* Expansion of valid instructions (currently only supporting J, JR, JAL, BEQ, BNE, ADD, SUB, XORI, LW, SW, SLT)
* Multiple levels of data memory. Currently all cores read/write to one memory, modern CPU's use multiple levels, giving each core its own private memory and mirroring changes to a larger shared memory. You would also want to implement "cache invalidation" if implementing this architecture.

### 'Gotchas'
We made some silly mistakes that were rather annoying to fix, so we wrote them down here to help future developers!

1. Make sure all registers are clocked. We accidentally left ours unclocked which meant that doing something like "add $t1, $t1, $t2" would enter an infinite loop and hang the whole CPU.
2. Our architecture allows the execution of multiple instructions at once. This includes jumps and branches. The way things are currently set up, executing 4 jumps at once will result in only the 4th jump actually doing anything. This also works for branches, where they act as sort of an "if-else if" chain. Mis-ordering your jumps/branches can cause some havoc in your program flow.