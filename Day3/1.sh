#!/bin/bash

LINES=""

while IFS= read -r line
do
	LINES="$LINES $line"
done < "input.txt"

IFS=', ' read -r -a LINES_ARRAY <<< "$LINES"

#1 line is how long?
LINE_LENGTH="$(echo "${LINES_ARRAY[0]}" | wc -c)"
LINE_LENGTH="$(($LINE_LENGTH-1))"

#we don't have 0
CUR_X="1"

NR_OF_TREES="0"

for index_y in "${!LINES_ARRAY[@]}"
do
	CHAR="$(expr substr ${LINES_ARRAY[$index_y]} $CUR_X 1)"
	
	if [ "$CHAR" == "#" ]
	then
		NR_OF_TREES="$(($NR_OF_TREES+1))"
	fi

	CUR_X="$((($CUR_X+3)%$(($LINE_LENGTH+1))))"
	if [ $CUR_X -le 2 ]
	then
		CUR_X="$(($CUR_X+1))"
	fi
done

echo "Reached the bottom. Encountered $NR_OF_TREES trees."
