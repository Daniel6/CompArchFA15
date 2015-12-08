# String Reversal (4 core friendly)
# Given a starting address and the number of characters in the string, reverse the string
# Characters must be stored contiguously

xori $t0, $zero, 60 # base address of string
xori $t1, $zero, 7  # length of string - 1
xori $t2, $zero, 1  # const val = 1
xori $t3, $zero, 7  # const val = 7

add $t3, $zero, $t0 # address 1, set it to point at the first char of the string
add $t5, $t0, $t1   # address 2, set to point to character on other side of string
nop
nop

LOOP:
lw $t4, ($t3) # load character 1 from address 1
lw $t6, ($t5) # load character 2 from address 2
nop
nop

sw $t4, ($t5) # store character 1 in address 2
sw $t6, ($t3) # store character 2 in address 1
add $t3, $t3, $t2 # increment address 1 by 1 to point at next char in string
sub $t5, $t5, $t2 # decrement address 2 by 1

nop
slt $t7, $t3, $t5 # check to see if address 1 is less than address 2
nop
nop

nop
nop
beq $t7, $zero, DONE # if address 1 is not less than address 2, we are done (end case for even length strings)
j LOOP

DONE:
nop
nop
nop
j DONE # infinite loop of nop to prevent overrunning instruction memory