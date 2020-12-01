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
ARRAY_LEN=$(($ARRAY_LEN-1))

echo "Array size: $ARRAY_LEN"

#loop over array
for index in "${!NUMBERS_ARRAY[@]}"
do
    A="${NUMBERS_ARRAY[index]}"
    for ((i=$(($index+1)); i<$ARRAY_LEN; i++))
    do
        B=${NUMBERS_ARRAY[i]}
        for ((j=$(($i+1)); j<$ARRAY_LEN; j++))
        do
            C=${NUMBERS_ARRAY[j]}
            if [ $(($A+$B+$C)) -eq 2020 ] ; then
                echo "found $A, $B and $C. Result: $(($A*$B*$C))"
            fi
        done
    done
done
