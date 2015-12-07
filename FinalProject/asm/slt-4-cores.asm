# SLT

# load registers
xori $t0, $zero, 0
xori $t1, $zero, 1
xori $t2, $zero, 2
xori $t3, $zero, 3

# execute slt
EXEC:
slt $t4, $t0, $t1
slt $t5, $t3, $t3
slt $t6, $t2, $t1
slt $t7, $t2, $t0

j EXEC
nop
nop
nop
