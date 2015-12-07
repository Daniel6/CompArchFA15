# Test adding on all four cores simultaneously
# This program is designed to showcase our processor's benefits over a single core CPU
# These instructions are grouping in to sets of 4 independent instructions to allow maximum parallelization
#
# When generating machine code, you should group 32 bit instructions into one long
# num_cores * 32 bit instruction.

# load values to be added
xori $t1, $zero, 1
xori $t2, $zero, 2
xori $t3, $zero, 3
nop

# add some values
add $t4, $t3, $t1
add $t5, $t2, $t3
add $t6, $t1, $t2
add $t7, $t1, $t1

# add some more values
add $t3, $t4, $t1
add $t2, $t5, $t4
add $t6, $t4, $t5
add $t7, $t1, $t5

# add even more values
add $t1, $t3, $t4
add $t5, $t2, $t3
add $t7, $t2, $t2
add $t6, $t4, $t3

# finish the program by looping
# ensure that arbitrary memory is not executed
END:
nop
nop
nop
nop

j END
nop
nop
nop