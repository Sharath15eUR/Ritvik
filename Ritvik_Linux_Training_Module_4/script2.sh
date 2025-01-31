#!/bin/bash

if [[ $# -lt 2 ]]; then
	echo "Insufficient arguments";
	echo 
	echo "Usage: $0 <input_file> <output_file> <debug>"
	echo "	input_file : the input file for the script"
	echo "	output_file: the file where the output is to be stored"
	echo "	debug (optional) : if 1, logs the progess of the script to the terminal"
	echo 
	exit 0
fi

file=$1;
outfile=$2;
debug=$3

totlines=$(wc -l $file | awk '{print $1}');
currlines=0;

while read line; do
	
	if [[ $debug -eq 1 ]]; then
		echo "Progress : ${currlines} done of ${totlines}"
	fi
	
	if [[ "$line" =~ frame.time\": ]] || [[ $line =~ wlan.fc.type\": ]] || [[ $line =~ wlan.fc.subtype\": ]] ; then
		echo "$line" >> $outfile;
	fi
	currlines=$(($currlines+1))
done < $file;
