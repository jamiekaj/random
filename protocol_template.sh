#!/bin/bash -i

read -p "Enter Your Description: " description
today=$(date +"%Y-%m-%d")

echo "############

Date: $(date +"%Y_%m_%d")

Description: $description

Background:

Protocol:

############

" >> "${today}_${description// /_}.txt"\
	&& \
	vi "${today}_${description// /_}.txt"
