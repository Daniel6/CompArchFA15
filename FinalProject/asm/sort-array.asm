main:
	#add $t0, $zero, $zero # Copy the base address of your array into $t0
    	lw  $t0, number 
 
   	xori $t7, $zero, 0x0024
    	xori $t6, $zero, 4
    	xori $a2, $zero, 1
    	
    	add $t0, $t0, $t7    # 4 bytes per int * 10 ints = 40 bytes 
    	nop
    	nop
    	nop
                                 
outterLoop:             # Used to determine when we are done iterating over the Array
    add $t1, $zero, $zero     # $t1 holds a flag to determine when the list is sorted
    lw  $a0, number      # Set $a0 to the base address of the Array
    #add $a0, $zero, $zero
    nop
    nop
innerLoop:                  # The inner loop will iterate over the Array checking if a swap is needed
    lw  $t2, 0($a0)         # sets $t0 to the current element in array
    lw  $t3, 4($a0)         # sets $t1 to the next element in array
    nop
    nop
    slt $t5, $t2, $t3       # $t5 = 1 if $t0 < $t1
    nop
    nop
    nop
    beq $t5, $0, continue   # if $t5 = 1, then swap them
    nop
    nop
    nop
    add $t1, $0, $a2          # if we need to swap, we need to check the list again
    sw  $t2, 4($a0)         # store the greater numbers contents in the higher position in array (swap)
    sw  $t3, 0($a0)         # store the lesser numbers contents in the lower position in array (swap)
    nop
continue:
    add $a0, $a0, $t6           # advance the array to start at the next location from last time
    nop
    nop
    nop
    bne  $a0, $t0, innerLoop    # If $a0 != the end of Array, jump back to innerLoop
    nop
    nop
    nop
    bne  $t1, $0, outterLoop    # $t1 = 1, another pass is needed, jump back to outterLoop
    nop
    nop
    nop
    
.data   
Array:      .word   14, 12, 13, 5, 9, 11, 3, 6, 7, 10
number: .word 0x02000
    