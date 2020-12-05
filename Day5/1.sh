#!/bin/bash

LINES=""

NR_OF_ROWS="127"
NR_OF_COLS="7"

get_row(){
	HIGH="$NR_OF_ROWS"
	LOW="0"

	for (( i=0; i<${#1}; i++ ))
	do
		CHAR="${1:$i:1}"
		if [ "$CHAR" == "F" ]
		then
			HIGH=$(($HIGH-1-(($HIGH-$LOW)/2)))
		elif [ "$CHAR" == "B" ]
		then
			LOW=$((1+$LOW+(($HIGH-$LOW)/2)))
		else
			echo "encountered unexpected char $CHAR".
			exit
		fi
	done

	if [ $HIGH -ne $LOW ]
	then
		echo "H: $HIGH, L: $LOW"
		exit
	fi

	return $HIGH
}

get_column(){
	HIGH="$NR_OF_COLS"
	LOW="0"

	for (( i=0; i<${#1}; i++ ))
	do
		CHAR="${1:$i:1}"
		if [ "$CHAR" == "L" ]
		then
			HIGH=$(($HIGH-1-(($HIGH-$LOW)/2)))
		elif [ "$CHAR" == "R" ]
		then
			LOW=$((1+$LOW+(($HIGH-$LOW)/2)))
		else
			echo "encountered unexpected char $CHAR".
			exit
		fi
	done

	if [ $HIGH -ne $LOW ]
	then
		echo "H: $HIGH, L: $LOW"
		exit
	fi

	return $LOW
}

HIGHEST_ID="0"

while IFS= read -r line
do
	get_row ${line:0:7}
	ROW="$?"
	get_column ${line:7:3}
	COL="$?"

	SEAT_ID=$(($ROW*8+$COL))

	if [ $SEAT_ID -gt $HIGHEST_ID ]
	then
		HIGHEST_ID=$SEAT_ID
	fi
done < "input.txt"

echo "Highest ID: $HIGHEST_ID"
