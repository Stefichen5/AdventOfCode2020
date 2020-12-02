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

	CHAR_A="${STRING:$(($MIN-1)):1}"
	CHAR_B="${STRING:$(($MAX-1)):1}"

	if ([ "$CHAR_A" == "$CHAR" ] || [ "$CHAR_B" == "$CHAR" ]) && [ "$CHAR_A" != "$CHAR_B" ]
	then
		COUNT_VALID="$(($COUNT_VALID+1))"
	else
		COUNT_INVALID="$(($COUNT_INVALID+1))"
	fi
done < "input.txt"

echo "Done. Found $COUNT_VALID valid and $COUNT_INVALID invalid passwords"
