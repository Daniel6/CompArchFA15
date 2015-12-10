# ﻿Multi-Core Processing


## Team members:
- [Daniel Bishop](https://github.com/Daniel6)
- [Isaac Getto](https://github.com/idgetto)
- [Thuc Tran](https://github.com/thuctran289)
- [Jordan Van Duyne](https://github.com/jovanduy)


## Brief Description:
Our multi-core architecture uses Very Long Instruction Words (VLIW) to execute multiple instructions simultaneously. Our planned deliverable will read 4 instructions at a time from a single instruction stream, using one decoder and a shared register file to execute each instruction on its own execution core.

We chose to use a shared register file instead of private registers for each core to maintain register consistency across VLIW’s. For example, storing a result in register $rt in one set of instructions will mean that in any following instruction, $rt will still be the expected value. If the register files were private, the value of $rt would depend on what core the instruction was being executed on. An execution core will be composed of an ALU, sign extender, and logical bit shifter. Our data memory module will support up to 4 total read or write operations simultaneously to support each of the 4 cores.

As a part of our architecture, it is up to the programmer to avoid running into data hazards such as reading and writing to the same memory address in one set of instructions. While this would not break the CPU, it would produce undefined behavior and should be avoided at all costs. Other data hazards would include writing to the same memory address more than once in one VLIW, or attempting to assign a register to a value more than once.

Another consideration would be instruction parallelization. If consecutive instructions are dependent on each other, they cannot be lumped together in one VLIW. The lumping on instructions would fall upon the compiler, as detecting instruction parallelization via hardware is a rather difficult operation.


## References:
- https://www.cs.cmu.edu/~fp/courses/15213-s07/lectures/27-multicore.pdf
- https://en.wikipedia.org/wiki/Multi-core_processor
- http://www.pcmech.com/article/all-about-multi-core-processors-what-they-are-how-they-work-and-where-they-came-from/
- http://superuser.com/questions/214331/what-is-the-difference-between-multicore-and-multiprocessor
- https://en.wikipedia.org/wiki/Very_long_instruction_word


## Deliverables:


### Minimum:
2 single-cycle execution cores with a shared register file and shared memory.


### Planned:
4 single-cycle execution cores with a shared register file and a shared memory.


### Stretch:
4 single-cycle execution cores with a shared register file, private caches, and a shared cache. Create scheduling logic that takes 4 individual MIPS instructions and stitches them together into one of our VLIW instructions, watching out for data hazards.
