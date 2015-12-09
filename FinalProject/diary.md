###11/30
We have decided to use the following architecture for our multi-core:
One PC -> 1 Instruction Mem -> 1 Instruction decoder -> 1 shares register file -> 4 cores (ALU, sign extender, shifter) -> 1 shared memory
The register file will have to be expanded to have enough registers for 4 cores to use at the same time. Probably 4x as many as a normal register file.
Memory will support 4 total read or write ops at the same time, lotta memory hazards possible here, up to programmer to watch out for them.

In a perfect world this would be 4x faster than a normal CPU, but in practise probably a lot less than that due to lack of instruction parallelization.

Project in a nutshell: "Strap 4 CPU's together so that they can do 4 things at once or one thing 4x as fast!"
Goal right now: 4 single-cycle execution cores with a shared register file and a shared cache. No multi-threading.

Why we found this interesting: The concept of multi-core CPU's is a proven way of making computers faster overall, it is a popular architecture for modern processors (modern architectures have tons of extra stuff compared to ours of course). It is cool to make our own proof of concept of how real world computers work!

###12/1
Today we made our instruction memory module! We designed it so that each memory address corresponds to one VLIW (2 MIPS instructions so 64-bits). We made a test bench for the module and it looks like it works!
Yay!
We also made a schematic of our planned 4-core processor, there are a lot of wires in here. Our shared register will support 8 simultaneous reads and 4 writes to support each of the cores. The memory module will also support up to 4 read/write ops at once too!
Jumping will be a hazard, so you should only have one jump-type instruction in your VLIW or you can't be sure where you will jump to.
This is because the jump instruction that actually gets through depends on which core is faster, and since they are identical it is kind of random.
Also, when doing jump-and-link instructions, the return address is stored in a static register, so if two jal instruction fired off they would both be trying to write to the same register and who knows what would happen.
In conclusion, dont jump twice at once or undefined behavior will happen and people will get sad.

###12/2
Today we made the VLIW splitter and instruction decoder. It went relatively smoothly.
No architecture changes.
Up next: shared register file

###12/3
Today we made the registerfile. The registerfile is the same as a standard MIPS regfile, but with as many read and write ports as there are cores. The only problems we ran into were syntax related errors when writing in system verilog, but other than that this task was not too daunting. We also made a test module, which was annoying because we also have to test four cores, but so far we've only written tests for one core.

###12/4
Today we sat down and sketched out a schematic for the entire processor, determining the exact placement of muxes and stuff. This also included definig control signals.

###12/5
Today we finished off the 4-core tests for the register file and made some stuff. We made the mux-chain module that will be used to decide what address to jump to when cores get jump instructions. We made some tests for the execution cores and data memory modules and control table. We will be able to integrate all these modules soon.

###12/6
Today we made a cpu module!!! So that means that assuming everything works and we didn't make any typos or have any errors in our logic when designing our cpu, our design/coding phase should be done. In order to test our cpu, we also wrote a bunch of assembly tests and are making an automated test verilog module for our cpu so we don't have to just rely at looking at the waveforms to check if our cpu works. Our next steps will include debugging, assuming we find problems when we run the test script, and then analyzing how the speed of our multi-core cpu compares to the speed of a regular single cycle MIPS cpu.
Our JAL is different than ordinary MIPS JAL, it returns to PC+4 not PC+8.
We worked on a lot of tests today, some of them work now! We were debugging our LW test and found an assembly error, that's good.
We also discovered that we accidentally made a multi-cycle cpu instead of a single cycle one, so we fixed that.
We had fun with jumping. Saying jump by 1 will jump 4 "normal" instructions in MIPS, but since we are saying 4 instructions is 1 instruction, the standard labels will need to be shifted right by 2 (trim overflow).
Eg: A normal MIPS instruction will say jump by 0111. Because our vliw is 4 instructions, we say jump by 0001.

###12/7
Now that we have a working cpu, we have started writing tests. Today we made a test that was basically a bunch of ADD commands that were independent of eachother. It is a simple example of how our cpu can execute programs 4x as fast as a 1-core cpu since ours has 4 cores. We also made a more complex program, string reversal. This one was more interesting because it involved a loop that iterated over the string, flipping characters around. With a 1-core cpu, the loop took a maximum of 10 cycles to execute. With a 2 core cpu, it only took 5 cycles, and with a 4 core cpu it took 4!. It looks like there are diminishing returns on increasing the number of cores, this was expected since there is a limit to instruction parallelism.

###12/8
Today I learned that:
instruction 1 goes to control table 3
instruction 2 goes to control table 2
instruction 3 goes to control table 1
instruction 4 goes to control table 0