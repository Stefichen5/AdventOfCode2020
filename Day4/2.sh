#!/bin/bash

LINES=""

declare -a REQUIRED_FIELDS=("byr" "iyr" "eyr" "hgt" "hcl" "ecl" "pid")

verify_passport(){
	DATA="$1"
	IFS=', ' read -r -a DATA_ARRAY <<< "$DATA"

	#check if required fields are present
	for FIELD in "${REQUIRED_FIELDS[@]}"
	do
		if [[ "$DATA" != *"$FIELD"* ]]
		then
			return 0
		fi
	done

	#check if required fields are valid
	for FIELD in "${DATA_ARRAY[@]}"
	do
		DATA_FIELD="$(echo $FIELD | cut -d':' -f2)"
		case "$FIELD" in
			*byr*)
				if [ $DATA_FIELD -lt 1920 ] || [ $DATA_FIELD -gt 2002 ]
				then
					return 0
				fi
			;;
			*iyr*)
				if [ $DATA_FIELD -lt 2010 ] || [ $DATA_FIELD -gt 2020 ]
				then
					return 0
				fi
			;;
			*eyr*)
				if [ $DATA_FIELD -lt 2020 ] || [ $DATA_FIELD -gt 2030 ]
				then
					return 0
				fi
			;;
			*hgt*)
				if [[ "$DATA_FIELD" == *"cm" ]]
				then
					DATA_FIELD="$(echo $DATA_FIELD | cut -d 'c' -f1)"
					if [ $DATA_FIELD -lt 150 ] || [ $DATA_FIELD  -gt 193 ]
					then
						return 0
					fi
				else
					DATA_FIELD="$(echo $DATA_FIELD | cut -d 'i' -f1)"
					if [ $DATA_FIELD -lt 59 ] || [ $DATA_FIELD  -gt 76 ]
					then
						return 0
					fi					
				fi
			;;
			*hcl*)
				if [ $(echo "$DATA_FIELD" | cut -c1-1) != "#" ]
				then
					return 0
				fi

				DATA_FIELD="$(echo $DATA_FIELD | cut -d '#' -f2)"
				if [ ${#DATA_FIELD} -ne 6 ]
				then
					return 0
				fi

				if [[ "$DATA_FIELD" =~ [^a-z0-9\ ] ]]
				then
					return 0
				fi
			;;
			*ecl*)
				if [ "$DATA_FIELD" != "amb" ] && [ "$DATA_FIELD" != "blu" ] && [ "$DATA_FIELD" != "brn" ] && [ "$DATA_FIELD" != "gry" ] && [ "$DATA_FIELD" != "grn" ] && [ "$DATA_FIELD" != "hzl" ] && [ "$DATA_FIELD" != "oth" ]
				then
					return 0
				fi
			;;
			*pid*)
				if [[ "$DATA_FIELD" =~ [^0-9\ ] ]]
				then
					return 0
				fi

				if [ ${#DATA_FIELD} -ne 9 ]
				then
					return 0
				fi
			;;
		esac
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
