#! /bin/bash

args=("$@")
# 引数の数をチェック

if [ $# -lt 2 ]; then
    echo "Over than 2 arguments are necessary." >&2
    exit 1
fi

num=()
# 引数が整数かチェック
for i in $(seq $#); do
    if ! expr "${args[$i-1]}" : "[0-9]*$" >&/dev/null; then
        echo "Only integers can be accepted." >&2
        exit 1
    else
        num+=(${args[$i-1]})
    fi
done

#for m in ${num[@]}; do
#    printf $m
#    printf "\n"
#done

# n個の引数が与えられた時、隣接する全ての要素のGCDをn-1個求める。
# 次に、先に求めたn-1個の全ての隣接する要素のGCDをn-2個求める。
# この操作を繰り返して、最後に一つ残った値が全ての引数のGCDである。
while :
do
    # 後の計算の為に、Bubble Sortで降順に並べ替える
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

    # 隣接する全ての要素のGCDを計算して配列に格納する
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
