#! /bin/bash

if [[ $1 > $2 ]]; then
    A=$1
    B=$2
else
    B=$1
    A=$2
fi
Aorg=$A
Borg=$B
i=0
R=$(($A % $B))
while [[ $R > 0 ]]
do
    R=$(($A % $B))
    printf "%d A:%d, B:%d, R:%d\n" $i $A $B $R
    if [[ $R >0 ]]; then
	A=$B
	B=$R
    fi
    
    if [[ $i > 100 ]]; then
	break
    fi
    let i++
done

printf "GCD of %d and %d is %d.\n" $Aorg $Borg $B
