#!/bin/bash

NUMBERS=""

#read all numbers from text file
while IFS= read -r line
do
  NUMBERS="$NUMBERS $line"
done < "input.txt"

#convert string to array
IFS=', ' read -r -a NUMBERS_ARRAY <<< "$NUMBERS"

ARRAY_LEN="${#NUMBERS_ARRAY[@]}"

echo "Array size: $ARRAY_LEN"

#loop over array
for index in "${!NUMBERS_ARRAY[@]}"
do
    A="${NUMBERS_ARRAY[index]}"
    for ((i=$(($index+1)); i<$ARRAY_LEN; i++))
    do
        B=${NUMBERS_ARRAY[i]}
        if [ $(($A+$B)) -eq 2020 ] ; then
            echo "found $A and $B. Result: $(($A*$B))"
        fi
    done
done
