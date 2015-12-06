# Jump to a specific register location

# PC = 0
xori $t0, 12
nop
nop
nop

# PC = 4
j DONE
nop
nop
nop

# PC = 8
nop
nop
nop
nop

# PC = 12
DONE:
nop
nop
nop
nop

# after two clock cycles we should end up at PC = 12