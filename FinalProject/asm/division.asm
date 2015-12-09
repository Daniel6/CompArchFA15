#-------------------------------------------------------
# Divide
#
# This function divides opA by opB.
#
# The result of the integer division is put in
# register $v0 and the remainder is put in register $v1.
#
# The operand values can be changed in the .data section.
#--------------------------------------------------------

# Load operands into registers
xori $t1, $zero, 1
xori $a0, $zero, 5
xori $a1, $zero, 2
nop

# Setup result registers
add $v0, $zero, $zero
add $v1, $zero, $a0
nop
nop

LOOP_START:

    slt $t2, $v1, $a1
    nop
    nop
    nop
    
    bne $t2, $zero, DONE
    nop
    nop
    nop

    sub $v1, $v1, $a1
    add $v0, $v0, $t1 # increment result
    nop
    nop

j LOOP_START
nop
nop
nop

DONE:
j DONE
nop
nop
nop

# cyles = 1 + 1 + 3 * (a/b)

# a = 5, b = 2, cycles = 8
