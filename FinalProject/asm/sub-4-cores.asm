# Test adding on all four cores simultaneously
#
# When generating machine code, you should group 32 bit instructions into one long
# num_cores * 32 bit instruction.

# load values to be added
xori $t1, $zero, 1
xori $t2, $zero, 2
xori $t3, $zero, 3
nop

# add some values
SUB:
sub $t4, $t3, $t1
sub $t5, $t3, $t2
sub $t6, $t2, $t1
sub $t7, $t1, $t1

# finish the program by looping
# ensure that arbitrary memory is not executed
j SUB
nop
nop
nop