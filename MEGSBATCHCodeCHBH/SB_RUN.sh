#!/bin/bash

# set parameters
declare -a tSubjects=(1 2 5) # subject index
f="my_script"	# your MATLAB function name
t="12:00:00" 	# time
m="16GB" 			# memory

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
