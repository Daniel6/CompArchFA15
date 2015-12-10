# Structure

# Analysis

## Speed
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

#### Array Sorting
Use bubble sort to sort the array [14, 12, 13, 5, 9, 11, 3, 7, 10] stored in memory from highest to lowest.

- 1-core: 388 cycles (100% speed)
- 4-core: 297 cycles

### What programs run slower

## Area

## Energy
