#! /bin/bash

# Test case when there are no arguments.
test_results=()
if [[ $(./GCD.sh) == 1 ]]; then
    test_results+=(1)
else
    test_results+=(0)
fi

# Test case when there are appropriate arguments.
# The expectation is integer aside from 1.
prim_num=($(cat ./prim_num.dat))
base_sel=${#prim_num[@]}
base_index=$(($RANDOM % $base_sel))
base1=${prim_num[$base_index]}
base_index=$(($RANDOM % $base_sel))
base2=${prim_num[$base_index]}
gcd=$(($base1 * $base2))

arg_num=99
mult_max=5

args=()
for ((i=0;i<$arg_num;i++)); do
    mult=$(($RANDOM % $mult_max))+1
    dat=$gcd
    for ((j=0;j<$mult;j++)); do
	index=$(($RANDOM % $base_sel))
	dat=$(($dat * ${prim_num[$index]}))
    done
    args+=($dat)
done

cmd="./GCD.sh "

for m in ${args[@]}; do
    cmd+=$m
    cmd+=" "
done

echo $cmd
ans=$($cmd)

if [[ $gcd == $ans ]]; then
    printf "Test Pass\n"
    printf "Base1 : %d, Base2 : %d, GCD : %d, Ans : %d\n" $base1 $base2 $gcd $ans
    test_results+=(1)
else
    printf "Test Fail\n"
    printf "Base1 : %d, Base2 : %d, GCD : %d, Ans : %d\n" $base1 $base2 $gcd $ans
    test_results+=(0)
fi


