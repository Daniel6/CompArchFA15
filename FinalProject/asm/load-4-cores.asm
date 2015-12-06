# Load four words into memory

# load data memory address into registers
xori $t0, $zero, 0
xori $t1, $zero, 1
xori $t2, $zero, 2
xori $t3, $zero, 3

# load data from memory
lw $t4, ($t0)
lw $t5, ($t1)
lw $t6, ($t2)
lw $t7, ($t3)
