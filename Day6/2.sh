#!/bin/bash

parse_answer(){
	IFS=' ' read -ra ARR <<< "$1"

	TOTALS="${ARR[0]}"
	NR_OF_SAME="0"

	for (( i=0; i<${#TOTALS}; i++ ))
	do
		CHAR="${TOTALS:$i:1}"
		EVERYWHERE="true"

		for elem in "${ARR[@]}"
		do
			if [[ "$elem" != *"$CHAR"* ]]
			then
				EVERYWHERE="false"
			fi
		done

		if [ "$EVERYWHERE" == "true" ]
		then
			NR_OF_SAME=$(($NR_OF_SAME+1))
		fi
	done

	return $NR_OF_SAME
}

GROUP_ANSWER=""
TOTAL="0"

while IFS= read -r line
do
	if [ "$line" != "" ]
	then
		GROUP_ANSWER="$GROUP_ANSWER $line"
	else
		parse_answer "$GROUP_ANSWER"
		TOTAL="$(($TOTAL+$?))"
		GROUP_ANSWER=""
	fi
done < "input.txt"

#need to add the last group too
parse_answer "$GROUP_ANSWER"
TOTAL="$(($TOTAL+$?))"

echo "Total: $TOTAL"
