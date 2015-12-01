###11/30
We have decided to use the following architecture for our multi-core:
One PC -> 1 Instruction Mem -> 1 Instruction decoder -> 1 shares register file -> 4 cores (ALU, sign extender, shifter) -> 1 shared memory
The register file will have to be expanded to have enough registers for 4 cores to use at the same time. Probably 4x as many as a normal register file.
Memory will support 4 total read or write ops at the same time, lotta memory hazards possible here, up to programmer to watch out for them.

In a perfect world this would be 4x faster than a normal CPU, but in practise probably a lot less than that due to lack of instruction parallelization.

Project in a nutshell: "Strap 4 CPU's together so that they can do 4 things at once or one thing 4x as fast!"
Goal right now: 4 single-cycle execution cores with a shared register file and a shared cache. No multi-threading.

Why we found this interesting: The concept of multi-core CPU's is a proven way of making computers faster overall, it is a popular architecture for modern processors (modern architectures have tons of extra stuff compared to ours of course). It is cool to make our own proof of concept of how real world computers work!