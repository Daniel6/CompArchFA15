# Jump to a specific register location

# PC = 0
jal DONE
nop
nop
nop

# PC = 4
nop
nop
nop
nop

# PC = 8
DONE:
nop
nop
nop
nop

# after one clock cycle we should end up at PC = 8