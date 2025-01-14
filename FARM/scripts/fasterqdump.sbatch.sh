#!/bin/bash --login
#SBATCH -t 00-10:00:00
#SBATCH -J dl            
#SBATCH -c 16              
#SBATCH --mem=16G        
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
#notes goes here
while read f; do [ ! -s ${f}_1.fastq.gz ] && sbatch -J down_$(basename $f) ~/scripts/fasterqdump.sbatch.sh ${f}; done < accessionlist.txt
#notes ends here
############################################################################
NOTES
############################################################################
#code goes here
if [[ ! -s ${1}_1.fastq.gz ] || [ ! -s [ ! -s ${1}_2.fastq.gz ]]; then
	load_sratoolkit 
		fasterq-dump --split-files ${1} -p -e $(nproc)
	load_pigz 
		pigz -p $(nproc) -9 ${1}_1.fastq 
		pigz -p $(nproc) -9 ${1}_2.fastq
fi
#code ends here
############################################################################
printf "Time Used: $(squeue -h -j $SLURM_JOBID -o "%M")\nTime Left: $(squeue -h -j $SLURM_JOBID -o "%L")\nTime Requested: $(squeue -h -j $SLURM_JOBID -o "%l")\nDays Until Halloween: $(fHalloween)"
###########################################################################
exit 0 
