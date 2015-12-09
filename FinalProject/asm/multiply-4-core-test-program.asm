MAIN:
	xori $a0, 3
	xori $a1, 2
	nop
	jal MULTIPLY
	
	add $s0, $v1, $zero
	xori $s1, $v1, 6
	xori $s2, $v1, 7
	# exit program
	xori $v0, 10
	
END2: 
	nop
	nop
	nop
	j END2 
MULTIPLY:
	xori $t7, 0
	xori $t6, 1
	xori $t5, 12
	nop
	
	sub $t7, $t7, $t5
	nop
	nop
	nop
	
	add $sp, $sp, $t7	
	nop
	nop
	nop
	
	nop
	sw $ra, 8($sp)
	sw $a0, 4($sp)
	sw $a1, 0($sp)
	
	nop
	add $t3, $zero, $t6 # t3 is 1
	add $t1, $a1, $zero # t1 is a1
	add $v1, $v1, $zero # v0 = 0 
	
	nop
	nop
	nop
	jal MULT
	
	lw $ra, 8($sp)
	lw $a0, 4($sp)
	lw $a1, 0($sp)
	nop
	
	nop
	nop
	add $sp, $sp, $t5
	jr $ra
	
	
	MULT:
		add $v1, $v1, $a0 # v0 += a
		nop
		nop
		nop
		
		sub $t1, $t1, $t3 # b--
		nop
		nop
		nop
		
		slt $t2, $t1, $t3 # return t1 < 1 
		nop
		nop
		nop
		
		bne $t2, $zero, END # if t1 < 1, GOTO END, else, MULT
		nop
		nop
		nop
		
		j MULT
		nop
		nop
		nop
		
	END:
		nop
		nop
		nop
		jr $ra
		