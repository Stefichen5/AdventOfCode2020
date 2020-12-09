#!/bin/bash

FILE="input.txt"
LINES=""

while IFS= read -r line
do
	LINES="$LINES $line"
done < "$FILE"

IFS=', ' read -r -a NUMBERS_ARRAY <<< "$LINES"

for (( i=25; i<${#NUMBERS_ARRAY[@]}; i++ ))
do
	POSSIBLE="false"

	for (( j=$(($i-25)); j<$i; j++ ))
	do
		for (( k=$(($j+1)); k<$i; k++ ))
		do
			if [ ${NUMBERS_ARRAY[$i]} -eq $((${NUMBERS_ARRAY[$j]}+${NUMBERS_ARRAY[$k]})) ]
			then
				POSSIBLE="true"
			fi
		done
	done

	if [ "$POSSIBLE" == "false" ]
	then
		echo "found ${NUMBERS_ARRAY[$i]}"
	fi
done
