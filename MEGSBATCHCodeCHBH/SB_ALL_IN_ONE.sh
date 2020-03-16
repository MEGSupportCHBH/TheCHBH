#!/bin/bash

# How to use?
# 1. Copy this script to the same folder where your MATLAB script is
# 2. Set parameters (see below)
# 3. Run this script in terminal as: bash SB_RUN_EXAMPLE.sh

# set parameters
declare -a tSubjects=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24) # subjects
f="my_script"	# your MATLAB script name
t="48:00:00" 	# time
m="16GB" 		# memory

# do not change code below this line
fname="$f.sbatch" 
echo "#!/bin/bash" > $fname
echo "#SBATCH --ntasks 1" >> $fname
echo "#SBATCH --time $t" >> $fname
echo "#SBATCH --qos bbdefault" >> $fname
echo "#SBATCH --mem $m" >> $fname
echo "" >> $fname
echo "set -e" >> $fname
echo "" >> $fname
echo "module purge; module load bluebear" >> $fname
echo "module load MATLAB/2018b" >> $fname
echo "" >> $fname
echo "i=\$1" >> $fname
echo "i=\"\${i:1:\${#i}}\"" >> $fname
echo "" >> $fname
echo "matlab -nodisplay -r \"$f(\$i)\"" >> $fname

for i in "${tSubjects[@]}" 
do
	sbatch "$fname" ="$i"
done
