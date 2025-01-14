#!/bin/bash --login

#SBATCH -t 00-10:00:00
#SBATCH -J dl            
#SBATCH -c 16              
#SBATCH --mem=32G        
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=jknorris@ucdavis.edu
#SBATCH -p med2
#SBATCH -A ctbrowngrp
#SBATCH --output=/home/jknorris/.slurm_output/%x.%j.out

set -e

echo "Job ${SLURM_JOB_NAME}_${SLURM_JOB_ID}.out running on SLURM NODELIST: $SLURM_NODELIST"
echo "$(scontrol show job $SLURM_JOBID)"

:<<NOTES
############################################################################
#notes go here
while read f; do [ ! -s ${f}_1.fastq.gz ] && sbatch -J down_$(basename $f) ~/scripts/fasterqdump.sbatch.sh ${f}; done < accessionlist.txt
#notes end here
############################################################################
NOTES

source ~/.bashrc

############################################################################
#code goes here
if [ ! -s ${1}_1.fastq.gz ]; then
    load_sratoolkit
    fasterq-dump --split-files ${1} -p -e $(nproc)
    load_pigz
    pigz -p $(nproc) -9 ${1}_1.fastq 
    pigz -p $(nproc) -9 ${1}_2.fastq
fi
#code ends here
############################################################################
printf "Time Used: $(squeue -h -j $SLURM_JOBID -o "%M")\nTime Left: $(squeue -h -j $SLURM_JOBID -o "%L")\nTime Requested: $(squeue -h -j $SLURM_JOBID -o "%l")\n"

# Define the fHalloween function
fHalloween() {
    local today=$(date +%j)
    local halloween=$(date -d "2024-10-31" +%j)
    echo $((halloween - today))
}

printf "Days Until Halloween: $(fHalloween)\n"
###########################################################################
exit 0
