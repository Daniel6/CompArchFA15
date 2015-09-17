vlog -reportprogress 300 -work work hw1.v
vsim -voptargs="+acc" hw1
run 100