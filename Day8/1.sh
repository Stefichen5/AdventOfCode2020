#!/bin/bash

ACC_VAL="0"
PC="1"
DONE="false"
IN_FILE="input.txt"
VISITED_LINES=("0")

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

while [ 1 ]
do
	for elem in "${VISITED_LINES[@]}"
	do
		if [ $elem -eq $PC ]
		then
			echo "ACC: $ACC_VAL"
			exit
		fi
	done
	#find loop
	VISITED_LINES+=("$PC")
	echo $PC >> tmp.txt
	
	line="$(sed "$PC!d" $IN_FILE)"
	INSTRUCTION="$(echo $line | cut -d' ' -f1)"
	ARGUMENT=$(echo $line | cut -d' ' -f2 | xargs)

	if [ "$INSTRUCTION" == "acc" ]
	then
		do_acc "$ARGUMENT"
	elif [ "$INSTRUCTION" == "jmp" ]
	then
		do_jmp "$ARGUMENT"
	elif [ "$INSTRUCTION" == "nop" ]
	then
		do_nop
	fi
done
