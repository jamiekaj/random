#!/bin/bash --login
#SBATCH -t 00-01:00:00
#SBATCH -J TEMP             
#SBATCH -c 1               
#SBATCH --mem=1G        
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=jknorris@ucdavis.edu
#SBATCH -p med2
#SBATCH -A ctbrowngrp
#SBATCH --output=/home/jknorris/.slurm_output/%j/%x.txt

set -e  # Exit immediately on error
source ~/.bashrc

# Capture start time for accurate runtime calculation
start_time=$(date +%s)

# Job information logging
echo "Job ${SLURM_JOB_NAME}_${SLURM_JOB_ID}.out running on SLURM NODELIST: $SLURM_NODELIST"
echo "$(scontrol show job $SLURM_JOBID)"

# Define nproc explicitly for better control and portability
nproc=$(nproc)

:<< 'NOTES'
############################################################################
#notes goes here
for f in *; do
	[ ! -s ${f}.lock ] && sbatch -J $(basename $f) script.sh $f
done
#notes ends here
############################################################################
NOTES

# Capture start time for accurate runtime calculation
start_time=$(date +%s)

############################################################################
#code goes here

main() {

}

main "$@"
#code ends here
############################################################################

# Calculate and log elapsed time
end_time=$(date +%s)
elapsed=$((end_time - start_time))
echo "Elapsed time: $(printf '%dh:%dm:%ds\n' $(($elapsed/3600)) $(($elapsed%3600/60)) $(($elapsed%60)))"

printf "Time Used: $(squeue -h -j $SLURM_JOBID -o "%M")\nTime Left: $(squeue -h -j $SLURM_JOBID -o "%L")\nTime Requested: $(squeue -h -j $SLURM_JOBID -o "%l")\nDays Until Halloween: $(fHalloween)"

# Create lock file to indicate successful completion
touch "${f}.lock"

exit 0
