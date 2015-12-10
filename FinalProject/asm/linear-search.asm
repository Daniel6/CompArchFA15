# Linear Search

# Search for memory location holding 50
xori $a0, $zero, 5

# Set index to zero
xori $t9, $zero, 0

# increment value
xori $k1, $zero, 3

# Set result address to 0
xori $v0, $zero, 0

SEARCH:
	lw $t1, 0($t9)
	lw $t2, 1($t9)
	lw $t3, 2($t9)
	add $t9, $t9, $k1 # increment memory address
	
	j SEARCH
	beq $t1, $a0, FOUND_0
	beq $t2, $a0, FOUND_1
	beq $t3, $a0, FOUND_2


FOUND_0:
	sub $t9, $t9, $k1
	nop
	nop
	nop
	
	add $v0, $t9, $zero
	j DONE
	nop
	nop
	
FOUND_1:
	sub $t9, $t9, $k1
	xori $s1, $zero, 1
	nop
	nop
	
	add $v0, $t9, $s1
	j DONE
	nop
	nop
	
FOUND_2:
	sub $t9, $t9, $k1
	xori $s1, $zero, 2
	nop
	nop
	
	add $v0, $t9, $s1
	j DONE
	nop
	nop
	
DONE:
	j DONE
	nop
	nop
	nop
