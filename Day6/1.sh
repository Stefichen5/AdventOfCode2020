#!/bin/bash

parse_answer(){
	UNIQUE="$(echo $1 | grep -o . | sort | tr -d "\n" | tr -s 'a-z')"
	
	return ${#UNIQUE}
}

GROUP_ANSWER=""
TOTAL="0"

while IFS= read -r line
do
	if [ "$line" != "" ]
	then
		GROUP_ANSWER="$GROUP_ANSWER$line"
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
