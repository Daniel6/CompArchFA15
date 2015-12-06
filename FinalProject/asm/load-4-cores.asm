# Load four words into memory

# load data memory address into registers
xori $t0, 0
xori $t1, 1
xori $t2, 2
xori $t3, 3

# load data from memory
lw $t4, ($t0)
lw $t5, ($t1)
lw $t6, ($t2)
lw $t7, ($t3)