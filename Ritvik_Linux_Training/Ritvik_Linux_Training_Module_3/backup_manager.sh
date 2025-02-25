#!/bin/bash

args=("$@");

declare -a src_files;
declare -a dest_files;
declare -A duplicates;

export BACKUP_COUNT=0
BACKUP_SIZE=0

# insufficient or incorrect args
if [[ ${#args[@]} -ne 3 ]] || [[ -z "${args[0]}" ]] || [[ -z "${args[1]}" ]] || [[ -z "${args[2]}" ]]; then
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


# remove trailing / in source_dir
if [[ ${args[0]:$(( ${#args[0]} - 1 )):1} == '/' ]]; then
	args[0]=${args[0]:0:$((${#args[0]}-1))};
fi

# remove trailing / in backup_dir
if [[ ${args[1]:$(( ${#args[1]} - 1 )):1} == '/' ]]; then
	args[1]=${args[1]:0:$((${#args[1]}-1))};
fi

# check if source directory exists
if [[ ! -d "${args[0]}" ]]; then
	echo "Error: Source directory '${args[0]}' does not exist."
	exit 1
fi

src_files=(${args[0]}/*${args[2]});

# no matching files or no files to backup
if [[ "${#src_files[@]}" -eq 1 ]] && [[ "${src_files[0]}" == "${args[0]}/*${args[2]}" ]]; then
    echo "No matching files to back up."
    echo "Exiting"
		exit 0
fi

# no dest directory - create backup_dir 
if [[ ! -d "${args[1]}" ]]; then
	if ! mkdir -p -- "${args[1]}"; then
		echo "Error : directory creation failed" >&2;
		exit 1
	fi
fi

dest_files=(${args[1]}/*${args[2]});

for file in "${src_files[@]}"; do
	duplicates[$(echo "$file" | awk -F "/" '{print $NF}')]=1;
done

for destf in "${dest_files[@]}"; do
	fname=$(echo "$destf" | awk -F "/" '{print $NF}');
	if [[ ${duplicates["$fname"]} -eq 1 ]]; then
		src_timestamp=$(stat -c %Y "${args[0]}/${fname}");
		dest_timestamp=$(stat -c %Y "${args[1]}/${fname}");
		if [[ "${src_timestamp}" -le "${dest_timestamp}" ]]; then
			duplicates["$fname"]=0; 
		fi
	fi
done

#echo "${!duplicates[@]}"
#echo "${duplicates[@]}"

echo
echo "Files to be backed up"
echo

for fname in "${!duplicates[@]}"; do	
	if [[ "${duplicates[$fname]}" -eq 1 ]]; then
		BACKUP_COUNT=$(( "$BACKUP_COUNT" + 1 ))
		fsize=$(wc -c < "${args[0]}/${fname}");
		BACKUP_SIZE=$(( "$BACKUP_SIZE" + "$fsize" ));
		echo "${fname} of size ${fsize} bytes".
		cp "${args[0]}/${fname}" "${args[1]}/${fname}"
	fi
done

touch backup_report.log
truncate -s 0 backup_report.log;
echo "Total files processed : ${BACKUP_COUNT}" >> backup_report.log;
echo "Total size of files backed up : ${BACKUP_SIZE} bytes" >> backup_report.log ;
echo "Path to the directory that was backed up : ${args[0]}" >> backup_report.log;
echo "Path to the backup directory : ${args[1]}" >> backup_report.log;
mv backup_report.log "${args[1]}";

echo "" >> "${args[1]}/.backup_history.log";
echo "Summary of backup at `date`" >> "${args[1]}/.backup_history.log";
echo "" >> "${args[1]}/.backup_history.log";
cat "${args[1]}/backup_report.log" >> "${args[1]}/.backup_history.log";
echo "" >> "${args[1]}/.backup_history.log";

echo
echo "Report written at ${args[1]}/backup_report.log"
echo "Backup history available at ${args[1]}/.backup_history.log"
echo

exit 0
