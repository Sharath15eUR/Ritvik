#!/bin/bash

args=("$@");

declare -a src_files;
declare -A duplicates;

BACKUP_COUNT=0
BACKUP_SIZE=0

if [[ ${#args[@]} -ne 3 ]]; then
	echo
	echo "Incorrect arguments";
	echo 
	echo "Required : 3" 
	echo "Provided : ${#args[@]}"
	echo
	echo "Usage : ./backup_manager.sh source_dir backup_dir extension"
	echo
	echo "	source_dir : A directory containing files to back up."
	echo "	backup_dir : The destination where files will be backed up."
	echo "	extension  : A specific file extension to filter (e.g., .txt)"
	echo
	exit 1
fi

# add . to extension if does not exist
if [[ ${args[2]:0:1} != "." ]]; then
	args[2]=".${args[2]}";
fi

src_files=(${args[0]}/*${args[2]});

# no matching files
if [[ "${#src_files[@]}" -eq 0 ]]; then
	echo "No matching files to back up."
	echo "Exiting"
	exit 0
fi

# no dest directory - create and copy all
if [[ ! -d "${args[1]}" ]]; then
	
	# mkdir "${args[1]}";

	if ! mkdir -p -- "${args[1]}"; then
		exit 1
	fi

	BACKUP_COUNT="${#src_files[@]}"

	echo
	echo "Files to be backed up"
	echo

	for file in ${src_files[@]}; do
		cp "$file" "${args[1]}";
		size=$(wc -c < "${file}");
		BACKUP_SIZE=$(( "$BACKUP_SIZE" + "$size" ));
		echo "$(echo "${file}" | awk -F "/" '{print $NF}') of size ${size} bytes".
	done

	touch report.log
	truncate -s 0 report.log;
	echo "Total files processed : ${BACKUP_COUNT}" >> report.log;
	echo "Total size of files backed up : ${BACKUP_SIZE} bytes" >> report.log ;
	echo "Path to the backup directory : ${args[1]}" >> report.log;
	mv report.log "${args[1]}";
	exit 0

fi

for file in ${src_files[@]}; do
	duplicates[$(echo "$file" | awk -F "/" '{print $NF}')]=1;
done



# for file in ${src_files[@]}; do
#	echo $file;
# done
# echo "Total files : ${#src_files[@]}"
