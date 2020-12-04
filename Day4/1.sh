#!/bin/bash

LINES=""

declare -a REQUIRED_FIELDS=("byr" "iyr" "eyr" "hgt" "hcl" "ecl" "pid")

verify_passport(){
	DATA="$1"

	for FIELD in "${REQUIRED_FIELDS[@]}"
	do
		if [[ "$DATA" != *"$FIELD"* ]]
		then
			return 0
		fi
	done

	return 1
}

VALID_PASSPORTS="0"
INVALID_PASSPORTS="0"

while IFS= read -r line
do
	LINES="$LINES $line"
	if [ "$line" == "" ] ; then
		verify_passport "$LINES"
		if [ $? -eq 0 ]
		then
			INVALID_PASSPORTS=$(($INVALID_PASSPORTS+1))
		else
			VALID_PASSPORTS=$(($VALID_PASSPORTS+1))
		fi
		LINES=""
	fi
done < "input.txt"

echo "Valid: $VALID_PASSPORTS"
echo "Invalid: $INVALID_PASSPORTS"
