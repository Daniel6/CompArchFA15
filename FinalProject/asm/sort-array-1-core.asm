main:
	#add $t0, $zero, $zero # Copy the base address of your array into $t0
    	lw  $t0, number 
    	   
   	xori $t7, $zero, 0x0024
    	xori $t6, $zero, 4
    	xori $a2, $zero, 1
    	add $t0, $t0, $t7    # 4 bytes per int * 10 ints = 40 bytes 
                                 
outterLoop:             # Used to determine when we are done iterating over the Array
    add $t1, $zero, $zero     # $t1 holds a flag to determine when the list is sorted
    lw  $a0, number      # Set $a0 to the base address of the Array
    #add $a0, $zero, $zero
innerLoop:                  # The inner loop will iterate over the Array checking if a swap is needed
    lw  $t2, 0($a0)         # sets $t0 to the current element in array
    lw  $t3, 4($a0)         # sets $t1 to the next element in array
    slt $t5, $t2, $t3       # $t5 = 1 if $t0 < $t1
    beq $t5, $0, continue   # if $t5 = 1, then swap them
    add $t1, $0, $a2          # if we need to swap, we need to check the list again
    sw  $t2, 4($a0)         # store the greater numbers contents in the higher position in array (swap)
    sw  $t3, 0($a0)         # store the lesser numbers contents in the lower position in array (swap)
continue:
    add $a0, $a0, $t6           # advance the array to start at the next location from last time
    bne  $a0, $t0, innerLoop    # If $a0 != the end of Array, jump back to innerLoop
    bne  $t1, $0, outterLoop    # $t1 = 1, another pass is needed, jump back to outterLoop
    
.data   
Array:      .word   14, 12, 13, 5, 9, 11, 3, 6, 7, 10
number: .word 0x02000
    