#!/bin/bash
#SBATCH --ntasks 1
#SBATCH --time 12:00:00
#SBATCH --qos bbdefault
#SBATCH --mem 50G

set -e

module purge; module load bluebear # this line is required
module load MATLAB/2018b

i=$1
i="${i:2:8}"

matlab -nodisplay -r "my_script($i)"
