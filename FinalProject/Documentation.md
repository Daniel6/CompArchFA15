# Structure

# Analysis

## Speed
### What programs run faster
####String Reversal
Reverse the order of chracters in a string of length n stored in memory
1-core: 6 + 9(n/2-1) + 8 cycles
2-core: 3 + 5(n/2) cycles
4-core: 2 + 4(n/2) cycles

Eg: n=8
1-core: 41 cycles (100% speed)
2-core: 23 cycles (178%)
4-core: 18 cycles (228%)

Eg: n=3
1-core: 14 cycles (100% speed)
2-core: 8 cycles  (175%)
4-core: 6 cycles  (233%)

Eg: n=27
1-core: 122 cycles (100% speed)
2-core: 68 cycles  (179%)
4-core: 54 cycles  (226%)

#### Division

Compute integer division with a remainder

1-core: 7 + 4*(a/b)
2-core: 5 + 3*(a/b)
4-core: 4 + 3*(a/b)

Eg. a=5, b=2
1-core: 15 cycles (100% speed)
2-core: 11 cycles (127%)
4-core: 10 cycles (133%)

Eg. a=100, b=1
1-core: 407 cycles (100% speed)
2-core: 305 cycles (125%)
4-core: 304 cycles (125%)

Eg. a=0, b=2
1-core: 7 cycles (100% speed)
2-core: 5 cycles (129%)
4-core: 4 cycles (143%)

### What programs run slower

## Area

## Energy
