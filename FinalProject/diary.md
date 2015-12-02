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