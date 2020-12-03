#!/bin/bash

do_slope() {
	NR_OF_TREES="0"
	X_STEP="$1"
	Y_STEP="$2"

	Y_SKIP="0"

	for ((index_y = 0 ; index_y < ${#LINES_ARRAY[@]} ; index_y+=$Y_STEP ))
	do
		CHAR="$(expr substr ${LINES_ARRAY[$index_y]} $CUR_X 1)"

		if [ "$CHAR" == "#" ]
		then
			NR_OF_TREES="$(($NR_OF_TREES+1))"
		fi

		CUR_X="$((($CUR_X+$X_STEP)%$(($LINE_LENGTH+1))))"
		if [ $CUR_X -le $X_STEP ]
		then
			CUR_X="$(($CUR_X+1))"
		fi
	done

	echo $NR_OF_TREES

	return $NR_OF_TREES
}

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

NR_OF_TREES_PATH_1="$(do_slope 1 1)"
echo "Path 1/1 found $NR_OF_TREES_PATH_1"
NR_OF_TREES_PATH_2="$(do_slope 3 1)"
echo "Path 3/1 found $NR_OF_TREES_PATH_2"
NR_OF_TREES_PATH_3="$(do_slope 5 1)"
echo "Path 5/1 found $NR_OF_TREES_PATH_3"
NR_OF_TREES_PATH_4="$(do_slope 7 1)"
echo "Path 7/1 found $NR_OF_TREES_PATH_4"
NR_OF_TREES_PATH_5="$(do_slope 1 2)"
echo "Path 1/2 found $NR_OF_TREES_PATH_5"

NR_TOTAL="$(($NR_OF_TREES_PATH_1*$NR_OF_TREES_PATH_2*$NR_OF_TREES_PATH_3*$NR_OF_TREES_PATH_4*$NR_OF_TREES_PATH_5))"

echo "Reached the bottom. Encountered $NR_TOTAL trees."
