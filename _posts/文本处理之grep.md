---
title: 文本处理之grep
date: 2022-12-30 21:35:18
tags: 西柚云Linux教程
---

<iframe src="//player.bilibili.com/player.html?aid=945376710&bvid=BV1HW4y1W7je&cid=899825524&page=1" style="width:100%;height:500px;min-width:375px;min-height:200px"scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>

<!--more-->

>适用于 ubuntu 20.04
>ubuntu 20.04 是 “西柚云” 主要使用的操作系统 [西柚云官网](https://www.xiyoucloud.net/aff/VKRWMUHQ)

## 管道

文本通常保存在文件中，使用 linux 命令可以将文件读取文件内容到标准输出中，然后使用管道符（|）将文本”流“向另一个命令的输入。管道符（|）的作用可以顾名思义，输出到标准输出的文本可以通过管道“流”向其他命令，这些命令可以对这些输入的文本进行处理。

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
# 查看 xiyou.txt 文件的内容，并过滤出包含 xiyou 的行
cat xiyou.txt | grep xiyou
grep xiyou xiyou.txt
```

## grep使用方法

grep 不支持（\\+字母 表示一类字符的正则表达式），如：\s,\S,\d,\D,\w,\W 但这无伤大雅,我们可以用另一种模式来代替它们。

| 模式 1 | 模式 2       |
| ------ | ------------ |
| \s     | " "+         |
| \d     | [0-9]+       |
| \w     | [a-zA-Z0-9]+ |

grep [参数] [模式] 文件

- i 忽略字符的大小写
- v 显示不能被模式匹配的行
- n 输出匹配行的行号
- o 只输出匹配内容，默认是输出包含有匹配内容的行
- E 对正则表达式提供更好的支持,支持这些符号（+,?,|,"()","{}"），建议每次使用正则表达式时都加上，这样就不用记住加上 E 参数后会提供哪些特殊符号的支持了。
- A 显示匹配项和匹配项的后 n 行
- B 显示匹配项和匹配项的前 n 行
- C 显示匹配项和匹配项的前后 n 行

```bash
# 以数字开头的行
grep -nE '^[0-9]' xiyou.txt
# 以 u. 结尾的行
grep -nE 'u\.$' xiyou.txt
# 以 x 或 X 开头的行
grep -nE '^(x|X)' xiyou.txt
grep -niE '^x' xiyou.txt
# 全是数字的行
grep -nE '^[0-9]+$' xiyou.txt
# 输出文件的空行和行号
grep -nE '^$' xiyou.txt 
# 包含大写字母的行
grep -E '[A-Z]' xiyou.txt
# 输出包含 xiyou 的行，并只输出匹配内容
grep -onE 'xiyou.*' xiyou.txt
# 输出不包含 xiyou 的行
grep -vnE 'xiyou' xiyou.txt
# 输出不包含大写字母的行
grep -nE '[^A-Z]' xiyou.txt

# 使用分组匹配,可以使用 \1 引用前面匹配的分组内容
grep -nE '(xi..u).* \1' xiyou.txt
# 匹配以 952 开头，后面跟着的 7 的数量最少 2 个，最多 5 个的行
grep -nE '^9527{2,5}$' xiyou.txt
# 匹配以 952 开头，后面跟着 0 个 或 1 个 7 的行
grep -nE '^9527?$' xiyou.txt
# 显示匹配项的前后 1 行
grep -C 5 -nE '^9527?$' xiyou.txt
```

​    

# 补充内容

| 模式        | 含义                                 |
| ----------- | ------------------------------------ |
| abc         | abc                                  |
| 123         | 123                                  |
| [a-z]       | 匹配小写英文字母                     |
| [0-9]       | 匹配数字                             |
| [a-zA-Z0-9] | 匹配字母和数字                       |
| [^a-z]      | 不匹配字母                           |
| .           | 匹配任意单个字符                     |
| ^           | 匹配开头                             |
| $           | 匹配结尾                             |
| (a\|b)      | 匹配字母 a 或 b                      |
| +           | 匹配前一个匹配项1次或多次            |
| ？          | 匹配前一个匹配项0次或1次             |
| *           | 匹配前一个匹配项任意次               |
| {n}         | 匹配前一个匹配项至少 n 次            |
| {m,n}       | 匹配前一个匹配项最少 m 次，最多 n 次 |



