# Branch Not Equal

# load registers
# PC = 0
xori $t0, 0
xori $t1, 1
nop
nop

# PC = 4
bne $t0, $t1, END
nop
nop
nop

# PC = 8
nop
nop
nop
nop

# PC = 12
END:
nop
nop
nop
nop

