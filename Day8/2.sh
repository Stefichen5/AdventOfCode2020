#!/bin/bash

ACC_VAL="0"
PC="1"
DONE="false"
IN_FILE="input.txt"
VISITED_LINES=("0")
LAST_PC="0"
TOTAL_LINES="$(wc -l $IN_FILE | cut -d' ' -f1)"

do_acc(){
	ACC_VAL=$(($ACC_VAL$1))

	PC=$(($PC+1))
}

do_jmp(){
	PC=$(($PC$1))
}

do_nop(){
	PC=$(($PC+1))
}

try_again_with_overwrite(){
	while [ 1 ]
	do
		#find loop
		for elem in "${VISITED_LINES[@]}"
		do
			if [ $elem -eq $PC ]
			then
				echo "Overwrite $1 not successful"
				return
			fi
		done
		VISITED_LINES+=("$PC")
	
		line="$(sed "$PC!d" $IN_FILE)"
		INSTRUCTION="$(echo $line | cut -d' ' -f1)"
		ARGUMENT=$(echo $line | cut -d' ' -f2 | xargs)

		if [ $1 -eq $PC ]
		then
			echo "found overwrite"
			if [ "$INSTRUCTION" == "jmp" ]
			then
				INSTRUCTION="nop"
			else
				INSTRUCTION="jmp"
			fi
		fi

		if [ "$INSTRUCTION" == "acc" ]
		then
			do_acc "$ARGUMENT"
		elif [ "$INSTRUCTION" == "jmp" ]
		then
			do_jmp "$ARGUMENT"
		elif [ "$INSTRUCTION" == "nop" ]
		then
			do_nop "$ARGUMENT"
		fi

		if [ $PC -gt $TOTAL_LINES ]
		then
			echo "Overwrite $1 was successful."
			echo "ACC (Answer): $ACC_VAL"
			exit
		fi
	done
}

while [ 1 ]
do
	for elem in "${VISITED_LINES[@]}"
	do
		if [ $elem -eq $PC ]
		then
			for elem in ${JMPS_NOPS[@]}
			do
				VISITED_LINES=("0")
				PC="1"
				ACC_VAL="0"
				try_again_with_overwrite "$elem"
			done
			exit
		fi
	done
	#find loop
	VISITED_LINES+=("$PC")
	
	line="$(sed "$PC!d" $IN_FILE)"
	INSTRUCTION="$(echo $line | cut -d' ' -f1)"
	ARGUMENT=$(echo $line | cut -d' ' -f2 | xargs)

	if [ "$INSTRUCTION" == "acc" ]
	then
		do_acc "$ARGUMENT"
	elif [ "$INSTRUCTION" == "jmp" ]
	then
		JMPS_NOPS+=("$PC")
		do_jmp "$ARGUMENT"
	elif [ "$INSTRUCTION" == "nop" ]
	then
		JMPS_NOPS+=($PC)
		do_nop "$ARGUMENT"
	fi

done
