#!/bin/bash

declare -a tSubjects=("1" "2" "5") # subject index

for i in "${tSubjects[@]}" 
do
	sbatch SB_ONE.sh i="$i"
done
