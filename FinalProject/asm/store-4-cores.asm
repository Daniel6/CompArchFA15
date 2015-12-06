# Store four words into memory

# load data memory address into registers
xori $t0, $zero, 0
xori $t1, $zero, 1
xori $t2, $zero, 2
xori $t3, $zero, 3

# store data into memory
sw $t3, ($t0)
sw $t2, ($t1)
sw $t1, ($t2)
sw $t0, ($t3)
