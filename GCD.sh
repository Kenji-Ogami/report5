#! /bin/bash

num=("$@")
if [ ${#num[@]} -lt 3 ]; then
    echo "Over 2 arguments are necessary."
    exit 0
fi

pre=${#num[@]}-1
unset num[$pre]
num=(${num[@]})

while :
do
    max=${#num[@]}
    for ((i=0;i<$max-1;i++)); do
        for ((j=0;j<$max-1-$i;j++)); do
	    if [[ ${num[$j]} < ${num[$j+1]} ]]; then
		tmp=${num[$j+1]}
		num[$j+1]=${num[$j]}
		num[$j]=$tmp
	    fi
	done
    done

    GCD=()
    for ((i=0;i<$max-1;i++)); do
	A=${num[$i]}
	B=${num[$i+1]}
	Aorg=$A
	Borg=$B
	while :
	do
	    R=$(($A % $B))
	    if [ $R == 0 ]; then
		GCD+=($B)
		break
	    else
		A=$B
		B=$R
	    fi
	done
    done

    if [[ ${#GCD[@]} == 1 ]]; then
	break
    fi
    num=(${GCD[@]})
done

echo ${GCD[0]}
