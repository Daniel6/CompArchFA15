# Compute XORI on four cores simultaneously

# load some values
START:
xori $t1, $zero, 1
xori $t2, $zero, 2
xori $t3, $t1, 3
xori $t4, $t2, 4

# and again
j START
nop
nop
nop

