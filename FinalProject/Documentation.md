# Structure


# Analysis

## Performance
### What programs run faster
#### String Reversal
Reverse the order of characters in a string of length n stored in memory

- 1-core: 								6 + 9(n/2-1) + 8 cycles
- 2-core: 								3 + 5(n/2) cycles
- 4-core: 								2 + 4(n/2) cycles
- 4-core (w/ multi-core optimization): 	3 + 3(n/2) cycles or 4 cycles if string is 1 char or less

Eg: n=8

- 1-core: 							 41 cycles (100% speed)
- 2-core: 							 23 cycles (178%)
- 4-core: 							 18 cycles (228%)
- 4-core (w/ multi-core optimization): 15 cycles (273%)

Eg: n=3

- 1-core: 							 14 cycles (100% speed)
- 2-core: 							 8 cycles  (175%)
- 4-core: 							 6 cycles  (233%)
- 4-core (w/ multi-core optimization): 4 cycles  (350%)

Eg: n=27
- 1-core: 							 122 cycles (100% speed)
- 2-core: 							 68 cycles  (179%)
- 4-core: 							 54 cycles  (226%)
- 4-core (w/ multi-core optimization): 42 cycles  (286%)

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

#### Array Sorting
Use bubble sort to sort the array [14, 12, 13, 5, 9, 11, 3, 7, 10] stored in memory from highest to lowest.

- 1-core: 388 cycles (100% speed)
- 4-core: 297 cycles

#### Multiply
Multiplies two variables in memory.

- 1-Core: 34 Cycles
- 4-Core: 17 Cycles

#### Linear Search
Searches for a list for a given number. Stores the index of where the number was found.

- 1-Core: 5 + 4*(N/2) cycles on average
- 2-Core: 4 + 2*(N/2) cycles on average
- 4-Core: 3 + 2*(N/8) cycles on average

Eg. Search for 5 in list of 1-10
- 1-Core: 23 cycles
- 2-Core: 14 cycles
- 4-Core: 7 cycles

### What programs run slower

## Area

## Energy

# Testing Strategy

## Unit Tests

## CPU Instruction Tests

## Analysis Testings
