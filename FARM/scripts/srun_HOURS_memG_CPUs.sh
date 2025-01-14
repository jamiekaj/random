#!/bin/bash

usage="$(basename "$0") [-h] -- basic script to queue up an interactive terminal session using srun and the slurm queue manager 

Useage:srun_HOURS_memG_CPUs.sh [hours to run] [GB of memory per node] [cpus]

where:
    -h  show this help text
    -d	debug mode - request 1GB, 1CPU, for 1 hour
    "

while getopts 'hd' option; do
case "$option" in
h) echo "$usage"
	exit
	;;
d) set -- 1 1 1  # Set $1, $2, $3 to 1
        partition="low" # Set partition to low for debug mode
	;;
esac
done

if [[ -z ${1} ]]; then echo "please provide the number of hours to request" ; exit; fi
if [[ -z ${2} ]]; then echo "please provide the amount of RAM in GB to request per node" ; exit; fi
if [[ -z ${3} ]]; then echo "please provide the number of cores to request" ; exit; fi

if [[ -z ${partition} ]]; then # Use med2 if partition isn't set (i.e., -d wasn't used)
  srun -A ctbrowngrp -p med2 -t ${1}:00:00 --mem ${2}G --cpus-per-task=${3} --pty bash
else
  srun -A ctbrowngrp -p low -t ${1}:00:00 --mem ${2}G --cpus-per-task=${3} --pty bash
fi

