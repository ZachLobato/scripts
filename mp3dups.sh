#!/bin/bash

# Search all subdirectories of the current subdirectory.

# If there are two (or more) files with identical file contents both named
# .mp3, print the path to each of them.

# To do this efficiently, you may want to use md5sum.

#create a variable for the names of the mp3 files
mpthrees=$(find . -name "*.mp3")

#touch temp
tempVar=""



while read i
	do
		mdfive=$(md5sum "$i")
		#printf "%s %s\n" "$mdfive" "$CWD" >> temp
		tempVar="$tempVar $mdfive $CWD"$'\n'
	done <<< "$mpthrees"

temp2Var=$(echo "$tempVar" | sort)

#rm temp

l=0
lastLine=""
current="CURRENT"
last="LAST"

while read k
	do
		current=$(printf "%s\n" "$k" | awk {'print $1'})

		if [[ $last == $current ]] && [ $l -gt 0 ]
			then
				printf "%s\n" "$k" | awk '{$1=""; print $0}' | sed -e 's/^[ \t]*//;s/[ \t]*$//'
			else
				if [[ $l -gt 0 ]]; then
					printf "\n"
				fi
				l=0
		fi

		if [[ $last == $current ]] && [ $l -eq 0 ]
			then
				l=1
				printf "%s\n" "$lastLine" | awk '{$1=""; print $0}' | sed -e 's/^[ \t]*//;s/[ \t]*$//'
				printf "%s\n" "$k" | awk '{$1=""; print $0}' |  sed -e 's/^[ \t]*//;s/[ \t]*$//'

		fi

		last=$(printf "%s\n" "$k" | awk {'print $1'})
		lastLine="$k"

	done <<< "$temp2Var"

#rm temp2
