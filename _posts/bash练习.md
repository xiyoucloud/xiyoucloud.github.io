---
title: bash练习
date: 2022-12-29 11:25:31
tags: bash
toc: true
---

>适用于 ubuntu 20.04
>ubuntu 20.04 是 “西柚云” 主要使用的操作系统 [西柚云官网](https://www.xiyoucloud.net/aff/VKRWMUHQ)


<iframe src="//player.bilibili.com/player.html?aid=606228531&bvid=BV1y84y1t7Y9&cid=922973653&page=1" style="width:100%;height:500px;min-width:375px;min-height:200px"scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>


## [1.统计文件的行数](https://www.nowcoder.com/practice/205ccba30b264ae697a78f425f276779?tpId=195&tqId=36211&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
wc -l nowcoder.txt | awk '{print $1}'
# 方法 2-1
cat nowcoder.txt | wc -l
# 方法 2-2
wc -l < nowcoder.txt

# 方法 3-1
cat -n nowcoder.txt | awk '{print $1}' | tail -n 1
# 方法 3-2
cat -n nowcoder.txt | tail -n 1 | awk '{print $1}'

# 方法 4
i=0
while read p;
    do
        i=$((i + 1))
done < nowcoder.txt
echo $i
```
<!--more-->

## [2.打印文件的最后5行](https://www.nowcoder.com/practice/ff6f36d357d24ce5a0eb817a0ef85ee2?tpId=195&tqId=36212&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法1
end=$(wc -l < nowcoder.txt)
start=$(( end - 5 + 1))
if [[ $start -lt 1 ]]; then
	start=1
fi	
sed -n "$start,$end p" nowcoder.txt
# 方法 2
tail -n 5 nowcoder.txt
# 方法 3
tac nowcoder.txt | head -n 5 | tac

# 方法 4
awk 'BEGIN {
	s=1
} {
	lines[s]=$0;
	s++
}
END {
    for(i=NR-4; i<=NR; i++) {
        print(lines[i])
	}
}' nowcoder.txt

# 方法 5
function count_lines() {
	number=0
	filename="$1"
    while read p;
        do
            number=$((number + 1))
    	done < $filename
    echo $number
}
# 获取文件的行数
end=`count_lines nowcoder.txt`
start=$((end - 5 + 1))
if [[ $start -lt 1 ]]; then
	start=1
fi	
sed -n "$start,$end p" nowcoder.txt
```

## [3.输出7的倍数](https://www.nowcoder.com/practice/8b85768394304511b0eb887244e51872?tpId=195&tqId=36213&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%25E7%25AF%2587%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
start=0
end=500
step=7
while [ $start -lt $end ]; do
    if !(( $start % $step )); then
         echo $start
         start=$(( start + 1 ))
    else
         start=$(( start + 1 ))
    fi
done

# 方法 2
for num in {0..500..7}; do 
   echo "${num}"
done

# 方法 3
for num in {0..500};do
   [[ "((num%7))" -eq 0 ]] && echo "${num}"
done
```

## [4.输出第5行的内容](https://www.nowcoder.com/practice/1d5978c6136d4252904757b4fa0c9296?tpId=195&tqId=36214&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%25E7%25AF%2587%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
sed -n '5p' nowcoder.txt
# 方法 2 
head -n 5 nowcoder.txt | tail -n 1
# 方法 3 number row
awk '{ if(NR==5) {print($0)} }' nowcoder.txt
```

## [5.打印空行的行号](https://www.nowcoder.com/practice/030fc368e42e44b8b1f8985a8d6ad255?tpId=195&tqId=36215&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%25E7%25AF%2587%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk -n '/^$/ {print NR}' nowcoder.txt
# 方法 2
sed -n '/^$/=' nowcoder.txt

# 方法 3
i=1
while read line; do
	if [[ $line =~ ^$ ]]; then
		echo $i
	fi		
	i=$((i+1))
done<$1
```

## [6.去掉空行](https://www.nowcoder.com/practice/0372acd5725d40669640fd25e9fb7b0f?tpId=195&tqId=36216&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%25E7%25AF%2587%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# sed 只有加了 -i 参数才会修改原文件，否则只会输出修改后的内容，你也可以使用重定向符号（>）将输出重定向到 1 个文件中
# 方法 1
sed -n '/^$/!p' nowcoder.txt
# 方法2
awk -n '{if ($0 != "") print $0}' nowcoder.txt
# 方法 3
awk '!/^$/ {print $0}' nowcoder.txt
# 方法 4
grep -v '^$' nowcoder.txt
```

## [7.打印字母数小于8的单词](https://www.nowcoder.com/practice/bd5b5d4b93a04226a81afbabf0be797d?tpId=195&tqId=36217&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%25E7%25AF%2587%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk -F " " '{for(i=1;i<=NF;i++) { if(length($i) < 8) { print($i) }}}' nowcoder.txt

# 方法 2
words=$(cat nowcoder.txt)
for i in ${words[*]}; do
    if [ ${#i} -lt 8 ]; then
        echo ${i}
    fi
done

# 方法 3
for i in $(cat nowcoder.txt); do
    if [ ${#i} -lt 8 ]; then
        echo ${i}
    fi
done
```

## [8.统计所有进程占用内存百分比的和](https://www.nowcoder.com/practice/fb24140bac154e5b99e44e0cee45dcaf?tpId=195&tqId=36218&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%25E7%25AF%2587%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk '{} {sum += $6} END {print(sum)}' nowcoder.txt

# 方法 2
sum=0
while read p
do
    arr=($p)
    ((sum += arr[5]))
done < nowcoder.txt
echo $sum
```

## [9.统计每个单词出现的个数](https://www.nowcoder.com/practice/ad921ccc0ba041ea93e9fb40bb0f2786?tpId=195&tqId=36219&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%25E7%25AF%2587%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk '{for(i=1;i<=NF;i++) a[$i]+=1}END{for (x in a) print x, a[x]}' nowcoder.txt
```

## [10.第二列是否有重复](https://www.nowcoder.com/practice/61b79ffe88964c7ab7b98ae16dd76492?tpId=195&tqId=36220&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%25E7%25AF%2587%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk '{a[$2]+=1}END{for(x in a){if(a[x]>1) print a[x],x}}' nowcoder.txt
```

## [11.转置文件的内容](https://www.nowcoder.com/practice/2240cd809c8f4d80b3479d7c95bb1e2e?tpId=195&tqId=36221&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%25E7%25AF%2587%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk '{
     for(i=1;i<=NF;i++){
       if(NR==1){
         row[i] = $i;
       }else{
         row[i] = row[i]" "$i;
       }
     }
 }END{
   for(i=1;i<=NF;i++){
     print row[i]
   }
 }
' nowcoder.txt



# 方法 2
declare -a arr1
declare -a arr2

while read line 
do
    arr=($line)
    arr1[${#arr1[@]}]=${arr[0]}
    arr2[${#arr2[@]}]=${arr[1]}
done < nowcoder.txt

echo ${arr1[@]}
echo ${arr2[@]}
```

## [12.打印每一行出现的数字个数](https://www.nowcoder.com/practice/2d2a124f98054292aef71b453e705ca9?tpId=195&tqId=36222&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%25E7%25AF%2587%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk '{for(i=1; i<NF; i++) {if($i >= 1 && $i <= 5) sum+=1}END {print sum}}'
# 方法 2
awk -F "[1,2,3,4,5]" 'BEGIN{sum=0}{print "line"NR \
"number:"(NF-1);sum+=(NF-1)}END{print "sum is "sum}' nowcoder.txt

# 方法 3
let linecount=0
let sum=0
let count=0 
while read line
do
    for (( i=0; i<${#line};i++ ))
    do
        if [[  ${line:$i:1} =~ [1-5] ]]
        then
            (( count = count + 1 ))
        fi
    done
    linecount=$(($linecount+1))
    echo "line$linecount number:$count"
    sum=$(($sum+$count))
    count=0
done<nowcoder.txt
echo "sum is $sum"
```

## [13.去掉所有包含this的句子](https://www.nowcoder.com/practice/2c5a46ef755a4f099368f7588361a8af?tpId=195&tqId=36223&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk '{flag=0;
    for(i=1; i<=NF; i++) {
        if ($i == "this"){
            flag=1;
        }
    } 
    if (flag != 1) {
        print $0;
        flag=0;
    }
}' nowcoder.txt

# 方法 2
grep -v this nowcoder.txt

# 方法 3
sed '/this/d' nowcoder.txt

# 方法 3
awk '$0!~/this/ {print $0}'

# 方法 5
awk '{
     if ($0 !~ /this/) {
         print $0
     }
}'
```

## [14.求平均值](https://www.nowcoder.com/practice/c44b98aeaf9942d3a61548bff306a7de?tpId=195&tqId=36224&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk '{
    if(NR==1) {
        N=$1
    } else {
        sum+=$1
    }
} END {
    printf("%.3f", sum/N)
    }'

# 方法 2 bash xx.sh nowcoder.txt
read loop
sum=0
count=0
for((i=0; i < $loop; ++i)); do
    read temp
    (( sum += temp))
    ((++count))
done
echo "scale=3;$sum/$count" | bc

```

## [15.去掉不需要的单词](https://www.nowcoder.com/practice/838a3acde92c4805a22ac73ca04e503b?tpId=195&tqId=36225&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk '{
    for (i=1; i<=NF; i++) {
        if ($i ~ /.*[bB]+.*/) {
            continue
        } else {
            print $i
        }   
    }
}'
# 方法 2
awk '/!*[B|b]*/ {print $0}'
```

## [16.判断输入的是否为IP地址](https://www.nowcoder.com/practice/ad7b6dbfab2a4267a9991110c57aa64f?tpId=195&tqId=39425&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk '{
    if ($0 ~ /^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[09][0-9]|[1-9][0-9]|[0-9])$/) {
        print("yes");
    } else if ($0 ~ /[[:digit:]].[[:digit:]].[[:digit:]].[[:digit:]]/){
        print("no");
    } else {
        print("error")
    }
}' nowcoder.txt

# 方法 2
awk -F '.' '{
    if (NF == 4) {
        for (i = 1; i < 5; i++) {
            if ($i > 255 || $i < 0) {
                print("no")
                break
            }
        }
        if (i == 5) {
            print("yes")
        } else {
            print("error")
        }
    }
    
}' nowcoder.txt

# 方法 3
IFS='.'
while read line; do
    arr=(${line})
    if [ ${#arr[*]} -ne 4 ]; then
        printf "error\n"
    else
        for ((i = 0; i < ${#arr[*]}; i++)); do
            if [ ${arr[${i}]} -gt 255 ]; then
                printf "no\n"
                break
            fi
            done
        [ $i == 4 ] && printf "yes\n"
    fi
done
```

## [17.将字段逆序输出文件的每行](https://www.nowcoder.com/practice/e33fff83fd384a21ba67f3104fb8d646?tpId=195&tqId=39426&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
awk -F ":" '{
    for(i = NF; i >=1; i--) {
        printf("%s", $i)
        if (i != 1) {
            printf(":")
        }
    }
    print ""
}' nowcoder.txt
```

## [18.域名进行计数排序处理](https://www.nowcoder.com/practice/f076c0a3c1274cbe9d615e0f3fd965f1?tpId=195&tqId=39427&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
awk -F "/" '{
    arr[$3]++
} END {
    for (i in arr) {
        printf("%d %s\n", arr[i], i)
    }
}' | sort -r	

```

## [19.打印等腰三角形](https://www.nowcoder.com/practice/1c55ca2b73a34e80bafd5978810dd8ea?tpId=195&tqId=39428&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
awk 'BEGIN{
    for(n = 1; n <= 5; n++){
        row = "";
        for(i = 1;i <= 5 - n; i++){
            row = row " "
        }
        for(i = 1; i <= n; i++){
            row = row "*" " "
        }
        print row
    }
}'
```

## [20.打印只有一个数字的行](https://www.nowcoder.com/practice/296c2785e64c46b7ae4c76bf190c2072?tpId=195&tqId=39429&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk -F "[0-9]" '{if(NF==2) print $0}' nowcoder.txt
# 方法 2
while read line
do
    let count=0
    for (( i = 0; i < ${#line}; i++))
        do
            [[ ${line:i:1} =~ [0-9] ]] && ((count++))
        done
    if [ $count -eq 1 ];then
        printf "$line\n"
    fi
done < nowcoder.txt
# 方法 3
awk -F "" '{
    for (i = 1; i <= NF; i++) {
        if ($i ~ /[0-9]/) {
            count++
        }
    }
    if (count == 1) {
        print($0)
    }
    count = 0
}'
```

## [21.格式化输出](https://www.nowcoder.com/practice/d91a06bfaff443928065e611b14a0e95?tpId=195&tqId=39430&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk -F "" '{
    k=0
    for (i=NF; i>0; i--) {
        k++
        str = sprintf("%s%s", $i, str)
        if (k%3 == 0 && i>=2 && NF > 3) {
            str = sprintf(",%s", str)
        }
    }
    print(str)
    str=""
}'
# 方法 2
awk 'BEGIN{FS=""}{
    for(i=1;i<=NF;i++) {
    if((NF-i)%3==0 && i!=NF) printf $i",";else printf $i};printf "\n"}' nowcoder.txt 
```

## [22.格式化输出](https://www.nowcoder.com/practice/d91a06bfaff443928065e611b14a0e95?tpId=195&tqId=39430&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk -F ":" '{res[$1] = (res[$1] == "" ? $2 : (res[$1] "\n" $2))
 }END{
     for(k in res){
         print "["k"]"
         print res[k]
     }
}'

# 方法 2
declare -A map
while read line
    do
        arr=(${line/:/ })
		 map["${arr[0]}"]="${map["${arr[0]}"]}${arr[1]}\n"
    done < nowcoder.txt
k=0
for i in ${!map[*]}
    do
        [ $k -eq 0 ] && k=1 && tmp="[$i]\n${map[$i]}" && continue
        printf "[$i]\n${map[$i]}"
    done
printf "$tmp"

# 方法 3
declare -A map
while read line; do
arr=(${line/:/ })
    if [ map["${arr[0]}"] ]; then
        map["${arr[0]}"]=${map["${arr[0]}"]}"\n"${arr[1]}
    else
        map["${arr[0]}"]=${arr[1]}
    fi
done < nowcoder.txt
declare -a tmp
tmp+=$(${!map[*]} | tr ' ' '\n' | sort -n)

for i in $(echo ${!map[*]} | tr ' ' '\n' | sort -n); do
    printf "[$i]"
    printf "${map[$i]}\n"
done
```

## [23.nginx日志分析1-IP统计](https://www.nowcoder.com/practice/3f2f45c74a1b415db17234f9cfd51469?tpId=195&tqId=39432&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk '{
    if(substr($4, 2, 11) == "23/Apr/2020") {
        res[$1]++;
    }
}END {
    for(k in res) {
        print res[k] " " k
    }
}' | sort -nr -k 1 -t " "

# 方法 2
awk '{
    if ($4 ~ /\[23\/Apr\/2020.*/) {
        res[$1]++;
       
    }
}END {
    for(k in res) {
        print res[k] " " k
    }
}' | sort -nr -k 1 -t " "
```

## [24.nginx日志分析2-统计某个时间段的IP](https://www.nowcoder.com/practice/ddbdd73859fa4fd48bbae7dd2e55f4b9?tpId=195&tqId=39433&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk '{
    if ($0 ~ /\[23\/Apr\/2020:2[0-2]/) {
        a[$1]=1
    } 
} END {
    print (length(a))
}'
# 方法 2
grep "23/Apr/2020" | cut -c '-12' | sort -u | wc -l

# 方法 3
declare -A map
while read line
    do
        a=($line)
        [[ ${a[3]} =~ 23/Apr/2020:2[0-2] ]] && ((map["${a[0]}"]=0))
    done < nowcoder.txt
printf "${#map[*]}"
```

## [25.nginx日志分析3-统计访问3次以上的IP](https://www.nowcoder.com/practice/e1846855de79495fbb017b8ddf6ba969?tpId=195&tqId=39434&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk '{
    map[$1]++
} END {
    for (i in map) {
        if (map[i] > 3) {
            printf ("%d %s\n", map[i], i)
        } 
    }
}' nowcoder.txt | sort -rn -k1 -t " "

# 方法 2
declare -A map
while read line; do
    tmp=($line)
        ((map[$tmp[1]]+=1))
done < nowcoder.txt
declare -a tmpArray
tmp=0
index=0
for (j=0; j<=3;j++); do
    for i in ${!map[*]}; do
        if [ ${map[i]} gt tmp ]; then
            tmp=${map[i]}
            index=i
        fi
    done
    tmpArray[index]=tmp
    unset map[index]
    tmp=0
    index=0
done    

# 方法 3
sort -rn -k1 tmp.txt
```

## [26.nginx日志分析4-查询某个IP的详细访问情况](https://www.nowcoder.com/practice/d0d81982176b4d5ebf032dbfb4a850d6?tpId=195&tqId=39435&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk '{
    if ($1 == "192.168.1.22") {
        a[$7]++
    }
} END {
    for (i in a){
        printf("%d %s\n",a[i], i)
    }
}' | sort -r
```

## [27.nginx日志分析5-统计爬虫抓取404的次数](https://www.nowcoder.com/practice/3a3573822a854710a259d89066aad695?tpId=195&tqId=39436&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
while read line
    do
        a=($line)
        [ ${a[8]} == "404" ] && [ ${a[14]} == '+http://www.baidu.com/search/spider.html)"' ] && ((b++))
    done < nowcoder.txt
printf $b

# 方法 2
awk '{
    if ($9 == "404" && $15 ~/baidu/) {
        k++
    }
} END {
    print(k)
}'

# 方法 3
grep "baidu" |grep 404|wc -l
```

## [28.nginx日志分析6-统计每分钟的请求数](https://www.nowcoder.com/practice/9a37600d342c47ed9e9a0fd33c1c189e?tpId=195&tqId=39437&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
awk -F ":" '{
    a[sprintf("%s:%s", $2, $3)]++
} END {
    for (i in a) {
        printf("%d %s\n", a[i], i)
    }
}' | sort -r
```

## [29.netstat练习1-查看各个状态的连接数](https://www.nowcoder.com/practice/f46a302d14e04b149bb50670f255293a?tpId=195&tqId=39438&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
# 方法 1
awk '{
    if ($1 == "tcp") {
        arr[$6]++
    }
} END {
    for (i in arr) {
        printf("%s %d\n", i, arr[i])
    }
}' | sort -nrk2

# 方法 2
declare -A map
while read line
    do
        tmp=($line)
        [ ${tmp[0]} == "tcp" ] && ((map["${tmp[5]}"]++))
    done < nowcoder.txt
function InsertSort(){
    tmp=()
    for ve in ${map[*]}
        do
            tmp[${#tmp[*]}]=$ve
        done
    q=${#tmp[*]}
    for ((i=0;i<$q;i++))
        do
            for ((j=$i+1;j<$q;j++))
                do
                    if [ ${tmp[$i]} -lt ${tmp[$j]} ];then
                        t=${tmp[$i]}
                        tmp[$i]=${tmp[$j]}
                        tmp[$j]=$t
                    fi
                done
        done
}
InsertSort
for ((i=0; i<q; i++))
    do
        for ve in ${!map[*]}
            do
                if [ ${tmp[$i]} -eq ${map[$ve]} ];then
                    printf "$ve ${map[$ve]}\n"
                fi
            done
    done
```

## [30.netstat练习2-查看和3306端口建立的连接](https://www.nowcoder.com/practice/534b95941ffb495b9ba57fbfc3cd723a?tpId=195&tqId=39439&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
awk '{
if($0 ~"3306"){
    if($6=="ESTABLISHED"){
        a[$5]++
    }

}}
END {
for(i in a){
    print a[i],i
}
}' | sed 's/:3306//' | sort -nr -k1
```

## [31.netstat练习3-输出每个IP的连接数](https://www.nowcoder.com/practice/f601fc4f35b5453ba661531051b6ce69?tpId=195&tqId=39440&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
awk '{
    if ($1 == "tcp") {
        split($5, a, ":")
        t[a[1]]++
    }
} END {
    for (i in t){
        printf("%s %d\n", i, t[i])
    }
}' | sort -nrk2
```

## [32.netstat练习4-输出和3306端口建立连接总的各个状态的数目](https://www.nowcoder.com/practice/5ce76fd1513d4eacae68ad3b2aca1fbb?tpId=195&tqId=39441&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
awk '{
    if ($1 == "tcp" && $5 ~ /3306/) {
        if ($6 == "ESTABLISHED") {
            es++
        }
        ans++
        arr[$5]=0
    }
} END {
    printf("TOTAL_IP %d\nESTABLISHED %d\nTOTAL_LINK %d", length(arr), es, ans)
}'
```

## [33.业务分析-提取值](https://www.nowcoder.com/practice/f144e52a3e054426a4d265ff38399748?tpId=195&tqId=39442&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
awk '{
    if ($0 ~ /Server version/) {
        sub(/.*:/, "", $0)
        printf("serverVersion:%s\n", $0)
        next
    }
    if ($0 ~ /Server number/) {
        sub(/.*:/, "", $0)
        printf("serverName:%s\n", $0)
        next
    }
    if ($0 ~ /OS Version/) {
        sub(/.+Name:/, "", $0)
        t=$0
        sub(/,.*/, "", $0)
        sub(/.*:/, "", t)
        printf("osName:%s\nosVersion:%s", $0, t)
        exit
    }
}'
```

## [34.ps分析-统计VSZ,RSS各自总和](https://www.nowcoder.com/practice/7094b5f96e1a4c998ce01baf407beee6?tpId=195&tqId=39443&rp=1&ru=/exam/oj&qru=/exam/oj&sourceUrl=%2Fexam%2Foj%3Fpage%3D1%26tab%3DSHELL%E7%AF%87%26topicId%3D195&difficulty=undefined&judgeStatus=undefined&tags=&title=)

```bash
awk '{
    v += $5
    r += $6
} END {
    printf("MEM TOTAL\nVSZ_SUM:%0.1fM,RSS_SUM:%0.3fM", v/1024, r/1024)
}'
```