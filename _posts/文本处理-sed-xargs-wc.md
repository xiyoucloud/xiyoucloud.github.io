---
title: '文本处理(sed,xargs,wc)'
date: 2022-12-30 21:44:59
tags: 西柚云Linux教程
---

<iframe src="//player.bilibili.com/player.html?aid=220445497&bvid=BV1X841177rm&cid=900840633&page=1" style="width:100%;height:500px;min-width:375px;min-height:200px"scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>

<!--more-->

>适用于 ubuntu 20.04
>ubuntu 20.04 是 “西柚云” 主要使用的操作系统 [西柚云官网](https://www.xiyoucloud.net/aff/VKRWMUHQ)

## sed

sed 可以对文件中的文本内容进行过滤和修改，它的原理是逐行读入文本内容，根据模式匹配符合条件的文本，然后做操作。

```bash
# 向 xiyou.txt 文件写入多行内容
cat > xiyou.txt << EOF
x
y
XIYOU.
xiyou.
952
9527
9527777
95277777777777777777777
9527xiyou.

 xiyoucloud. xiyou.
xiyouyun or xiyoucloud
xiyouyun to be xiyouyun
EOF
```

sed [参数] [内置命令] 文件路径

参数：

- n 取消默认的 sed 输出，sed 默认会输出处理后的文本信息
- i 将做的修改写入文件，默认在终端展示修改效果而不写入文件，设计到修改文件的操作都要使用这个参数
- e 一次性做多次编辑
- r 对正则表达式提供更好的支持

内置命令：

- a append 在某行的后面追加内容
- i insert 在某行的前面插入内容
- d delete 删除符合条件的行
- p print 打印符合条件的行
- s/模式/替换文本：将模式匹配到的字符替换为其他字符

范围：默认全文，指定某行，指定范围行，匹配行

```bash
# 输出文件的从第2行到第5行的内容
sed -n '1 p' xiyou.txt
sed -n '2,5 p' xiyou.txt
sed -n '1~2 p' xiyou.txt
# 输出包含有 xiyou 的行（过滤）
sed -n '/xiyou/ p' xiyou.txt

# 增加文件内容（2种方式）
sed -i '1 a 在第 1 行的后面增加的文本内容' xiyou.txt
sed -i '1 i 在第 1 行的前面增加的文本内容' xiyou.txt
sed -i 'a ---------------' xiyou.txt
# 删除文件内容,删除第 1 行到第 3 行的内容
sed -i '1,3 d' xiyou.txt
# 替换匹配模式, g表示全部替换，默认只替换匹配到的第 1 个
sed -i 's/xiyou/西柚/g' xiyou.txt
# 一次性做两次替换
sed -i -e 's/9/九/g' -e 's/5/五/g' xiyou.txt
```

# 补充内容

## xargs：一个用于传递参数的命令

xargs 会将标准输入的文本内容聚合后通过 echo 输出。多行内容会被输出为 1 行内容。因此通常用来构造单行命令。

```bash
# <<< 可以给 xargs 提供标准输入
xargs <<< "1 2 3 4"
cat xiyou.txt | xargs

# n 指定每行最多输出指定个数的参数
cat xiyou.txt | xargs -n 3
# I 可以指定一个符号用于参数的替换
cat xiyou.txt | xargs -I {} echo "hello, {}" 

# 删除目录下所有的 txt 文件，-0 表示以 \0 做分隔符
find . -type f -name "*.txt" -print0 | xargs -0 rm -f
# 将当前目录下的以 py 结尾的文件移到 xiyou 目录中
mkdir xiyou && touch {1..9}.py && ls
ls *.py | xargs -I {} mv {} xiyou
# 打包当前目录下所有的 png 文件
touch {1..100}.png
find . -type f -name "*.png" -print | xargs tar -czvf images.tar.gz
```

## wc：统计文本内容 

```bash
# 统计文件中的文本信息(行数，单词数，字节数，文件名)
wc xiyou.txt
# 统计文件中文本的行数
wc -l xiyou.txt
# 统计文件名以 txt 结尾的文本的行数
wc -l *.txt

# 统计目录下的文件大小小于10M 的文件的文本内容信息（）
find . -type f -size -10M | xargs wc ;
```