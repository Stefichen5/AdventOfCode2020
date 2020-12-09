#!/bin/bash

FILE="input.txt"
LINES=""
INVALID_NUMBER=""

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
				STREAK=""
			fi
		done
	done

	if [ "$POSSIBLE" == "false" ]
	then
		INVALID_NUMBER="${NUMBERS_ARRAY[$i]}"
		i="${#NUMBERS_ARRAY[@]}"
	fi
done

for (( i=0; i<${#NUMBERS_ARRAY[@]}; i++ ))
do
	TMP="${NUMBERS_ARRAY[$i]}"
	LIST="${NUMBERS_ARRAY[$i]}"
	for (( j=$(($i+1)); j<${#NUMBERS_ARRAY[@]}; j++ ))
	do
		TMP=$(($TMP+${NUMBERS_ARRAY[$j]}))
		LIST="$LIST ${NUMBERS_ARRAY[$j]}"

		if [ $TMP -eq $INVALID_NUMBER ]
		then
			LIST="$(echo ${LIST[@]} | tr ' ' '\n' | sort | tr '\n' ' ')"
			IFS=', ' read -r -a LIST <<< "$LIST"
			echo "Result: $((${LIST[0]}+${LIST[-1]}))"
			exit
		elif [ $TMP -gt $INVALID_NUMBER ]
		then
			#echo "too large"
			break
		fi
	done
done
