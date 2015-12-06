# Branch Equal

# load registers
# PC = 0
xori $t0, 0
xori $t1, 0
nop
nop

# PC = 4
beq $t0, $t1, END
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

