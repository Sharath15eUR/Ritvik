#!/bin/bash



show_help() {
	cat << EOF

	Usage: $0 [OPTIONS]
		Search for a keyword in a file or directory.

	Options:
		-d <directory>    Directory to search recursively.
		-f <file>         File to search.
		-k <keyword>      Keyword to search for.
		--help            Show this help message and exit.


	Examples:
		$0 -d /path/to/dir -k "pattern"
		$0 -f /path/to/file -k "pattern"
		$0 -d /path/to/dir -f /path/to/file -k "pattern"

EOF
}


recursive_search(){
	local path="${1%/}";
	local pattern=$2;
	if [[ ! -e "$path" ]];then
		echo "Specified path $path does not exist";
		echo "`date` - Specified path $path does not exist" >> error.log
		exit 1
	fi

	if [[ -f "$path" ]]; then
		if [[ $path == *"$pattern"* ]]; then
			echo "match for $pattern found in filename $path";
		fi
		grep -q -e "$pattern" "$path";
		if [[ "$?" -eq 0 ]]; then
			echo "match for $pattern found in file $path" | tee -a output.log;
		fi
	elif [[ -d $path ]]; then
		local -a contents=("$path"/*);
		for content in "${contents[@]}"; do
			recursive_search "$content" "$pattern";
		done
	fi
}

search_file(){
	local path=$1;
	local pattern=$2;
	if [[ ! -f $path ]];then
		echo "Specified file $path does not exist"
		echo "`date` - Specified file $path does not exist" >> error.log
		exit 1
	fi

	if grep -q -e "$pattern" <<< echo "$path"; then
		echo "match for $pattern found in file $path" | tee -a output.log;
		exit 0;
	fi
}

if [[ $# -eq 0 ]]; then
	echo "No arguments provided"
	echo "`date` - No arguments provided" >> error.log
	show_help
	exit 1;
fi

for arg in "$@"; do
	case $arg in
		--help) 
			show_help;
			exit 0;
			;;
	esac
done

while getopts ":d:k:f:" opt; do
    case "$opt" in
        d) directory="$OPTARG";;
        k) keyword="$OPTARG";;
        f) searchfile="$OPTARG";;
        :|\?)
            echo "Invalid arguments"
	    echo "`date` - Invalid arguments" >> error.log
	    show_help
            exit 1
            ;;
    esac
done

if [[ -z "$directory" && -z "$searchfile" ]]; then
    echo "Either provide a search directory or a search file"
    echo "`date` - Either provide a search directory or a search file" >> error.log;
    exit 1
fi

if [[ -z "$keyword" ]]; then
    echo "Keyword to search cannot be empty" 
    echo "`date` - Keyword to search cannot be empty" >> error.log; 
    exit 1

fi


echo -e "\n$(date)\n$0 $@\n" >> output.log

if [[ -n "$directory" ]]; then
    recursive_search "$directory" "$keyword"
fi

if [[ -n "$searchfile" ]]; then
    search_file "$searchfile" "$keyword"
fi

exit 0
