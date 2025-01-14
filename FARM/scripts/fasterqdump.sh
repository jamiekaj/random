#! /bin/bash

usage="$(basename "$0") [-h] -- basic script to use fasterq-dump to download paired data and then compress them with PIGZ

Useage:fasterqdump.sh [SRA RUN ID]

where:
    -h  show this help text
	    "

while getopts 'h' option; do
case "$option" in
h) echo "$usage"
exit
;;
esac
done

if [[ -z ${1} ]]; then echo "add an SRA run ID - this is a helpful website:https://trace.ncbi.nlm.nih.gov/Traces/study/" ; exit; fi

if ! command -v fasterq-dump &> /dev/null
then module load sratoolkit/3.0.0
fi

if ! command -v pigz &> /dev/null 
then module load pigz/2.8 
fi

while read f
do [ ! -f ${1}_1.fastq.gz ] && fasterq-dump --split-files -p -e $(nproc) ${1}; pigz -p $(nproc) -9 ${1}_1.fastq && pigz -p $(nproc) -9 ${1}_2.fastq
done
