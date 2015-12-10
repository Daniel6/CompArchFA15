# String Reversal (4 core friendly)
# Given a starting address and the number of characters in the string, reverse the string
# Characters must be stored contiguously

xori $t0, $zero, 0 # base address of string                                         0
xori $t1, $zero, 7  # length of string - 1                                           
xori $s1, $zero, 1  # const val = 1                                                  
xori $s3, $zero, 3  # const val = 3                                  					     

add $t3, $zero, $t0 # address 1, set it to point at the first char of the string     4
add $t5, $t0, $t1   # address 2, set to point to character on other side of string   
slt $t4, $t1, $s3   # check if word length is less than 3
slt $t7, $t1, $s1   # check if word length is 1

beq $t4, $zero, LONGWORD # if word is 4 characters or more execute a different loop of commands 8
beq $t7, $s1, DONE       # if word is 1 or less characters long, do nothing
lw $t6, ($t5) # load character 2 from address 2
lw $t4, ($t3) # load character 1 from address 1 

SHORTWORD:  										     
sw $t4, ($t5) # store character 1 in address 2                                       12
sw $t6, ($t3) # store character 2 in address 1                                       
j DONE
nop

LONGWORD:	
sw $t4, ($t5) # store character 1 in address 2a                                      16
sw $t6, ($t3) # store character 2 in address 1a
add $t1, $t3, $s1 # increment address 1b by 1
sub $t2, $t5, $s1 # decrement address 2b by 1

lw $t4, ($t1) #   								     20
lw $t6, ($t2)
slt $t7, $t1, $t2
add $t3, $t1, $zero

sub $t5, $t2, $zero #								     24
nop
nop
beq $t7, $s1, LONGWORD

DONE:
nop #										     28
nop
nop
j DONE # infinite loop of nop to prevent overrunning instruction memory
