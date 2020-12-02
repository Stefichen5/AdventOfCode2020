#!/bin/bash

count_letters()
{
	return $(grep -o "${1}" <<< "${2}" | grep -c .)
}

COUNT_VALID="0"
COUNT_INVALID="0"

while IFS= read -r line
do
	#echo "$line"
	MIN="$(echo $line | cut -d'-' -f1)"
	MAX="$(echo $line | cut -d'-' -f2 | cut -d' ' -f1)"
	CHAR="$(echo $line | cut -d' ' -f2 | cut -d':' -f1)"
	STRING="$(echo $line | cut -d':' -f2 | xargs)"

	count_letters "$CHAR" "$STRING"
	NR_OF_NEEDED_LETTERS="$?"

	#echo "min: $MIN, max: $MAX, char: $CHAR, string: $STRING, contains $NR_OF_NEEDED_LETTERS"

	if [ $NR_OF_NEEDED_LETTERS -ge $MIN ] && [ $NR_OF_NEEDED_LETTERS -le $MAX ]
	then
		#echo "$STRING meets criteria"
		COUNT_VALID="$(($COUNT_VALID+1))"
	else
		#echo "$STRING violates criteria"
		COUNT_INVALID="$(($COUNT_INVALID+1))"
		#echo $COUNT
	fi
done < "input.txt"

echo "Done. Found $COUNT_VALID valid and $COUNT_INVALID invalid passwords"
