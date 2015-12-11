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
