#! /bin/bash

test_no=1
# Test case when there are no arguments.
test_results=()
err_msg="$(./GCD.sh 2>&1 > /dev/null)"
if [[ $? == 1 && $err_msg =~ ARGERR ]]; then
    printf "$err_msg\n"
    printf "Test%02d Pass\n" $test_no
    test_results+=(1)
else
    printf "Test%02d Fail\n" $test_no
    test_results+=(0)
fi

let test_no++
# Test case when there are non integer arguments.
err_msg="$(./GCD.sh "test" "test" 2>&1 > /dev/null)"
if [[ $? == 1 && $err_msg =~ TYPEERR ]]; then
    printf "$err_msg\n"
    printf "Test%02d Pass\n" $test_no
    test_results+=(1)
else
    printf "Test%02d Fail\n" $test_no
    test_results+=(0)
fi

# GCD.shを検証する関数です。GCD.shに与える引数の個数を、指定できます。
verify(){
prim_num=($(cat ./prim_num.dat))
base_sel=${#prim_num[@]}
base_index=$(($RANDOM % $base_sel))
base1=${prim_num[$base_index]}
base_index=$(($RANDOM % $base_sel))
base2=${prim_num[$base_index]}
gcd=$(($base1 * $base2))

arg_num=$1
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
    printf "Test%02d Pass\n" $test_no
    printf "Base1 : %d, Base2 : %d, GCD : %d, Ans : %d\n" $base1 $base2 $gcd $ans
    test_results+=(1)
else
    printf "Test%02d Fail\n" $test_no
    printf "Base1 : %d, Base2 : %d, GCD : %d, Ans : %d\n" $base1 $base2 $gcd $ans
    test_results+=(0)
fi
}


# Test case when there are appropriate arguments.
# The expectation is integer aside from 1.
# This test case is only 2 arguments.
let test_no++
verify 2

# This test case is 99 arguments.
let test_no++
verify 99

let test_no++
# Test case when there are appropriate number of arguments
# The expectation is 1.
arg_num=99
cmd="./GCD.sh "
for ((i=0;i<$arg_num;i++)); do
    cmd+=${prim_num[$(($RANDOM % $base_sel))]}
    cmd+=" "
done
echo $cmd
ans=$($cmd)
if [[ $ans == 1 ]]; then
    printf "Test%02d Pass\n" $test_no
    printf "GCD : %d, Ans :%d\n" 1 $ans
    test_results+=(1)
else 
    printf "Test%02d Fail\n" $test_no
    printf "GCD : %d, Ans :%d\n" 1 $ans
    test_results+=(0)
fi

cnt=0
for i in ${test_results[@]}; do
    cnt=$(($cnt+$i))
done

if [[ $cnt == $test_no ]]; then
    printf "All(%d) Test cases are Pass\n" $test_no
    exit 0
else
    printf "There are Failed Test cases(%d)\n" $cnt
    exit 1
fi

