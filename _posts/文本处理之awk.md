---
title: 文本处理之awk
date: 2022-12-30 21:51:33
tags: 西柚云Linux教程
---

<iframe src="//player.bilibili.com/player.html?aid=262900730&bvid=BV1KY411Z7nc&cid=901859829&page=1" style="width:100%;height:500px;min-width:375px;min-height:200px"scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>

<!--more-->


>适用于 ubuntu 20.04
>ubuntu 20.04 是 “西柚云” 主要使用的操作系统 [西柚云官网](https://www.xiyoucloud.net/aff/VKRWMUHQ)

## awk

awk 是个Linux系统自带的处理文本文件的程序，其原理是逐行处理文本内容，适合处理每行格式相同的文本文件。如：csv 格式的文件

```bash
ps -ef > xiyou.txt
awk '{print $1}' xiyou.txt
```

**awk [参数] '条件 {代码}' filename** 条件可以省略，默认处理所有行。只处理符合条件的行。

参数：

- F 指定分割符，不指定默认为空格
- v 定义变量或修改 awk 代码中内置的变量

awk 默认以空格作为分隔符，也可通过 F 参数指定特殊的符号为分隔符。

代码中的特殊变量：

- $0: 当前处理行的文本内容
- $1 使用分隔符分割后的第 1 列的内容
- $2 使用分隔符分割后的第 2 列的内容，以此类推
- NF 使用分隔符分割后的最后 1 列的序号
- NF-1 使用分隔符分割后的倒数第 2 列的序号
- NR 当前的处理行的序号
- OFS awk 中代码 print 时的分隔符，默认值为 1 个空格
- FILENAME 文件名

```bash
# 打印文件的每一行第 1 列和第 2 列
awk '{print($1, $2)}' xiyou.txt
echo $PATH | awk -F ':' '{print $NF}'

# 只处理匹配正则表达式的行，即只处理以 txb 开头的行
awk '/^txb/ {
	print("txb 用户运行的进程的 pid: ", $2)
}' xiyou.txt

# 处理不匹配正则表达式的行
awk '!/^txb/ {
	print("非txb 用户运行的进程的 pid: ", $2)
}' xiyou.txt

# 所有用户的进程 id
awk '(!/^txb/ || /^txb/) && !/^UID/ {
	print( $1, "用户运行的进程的 pid: ", $2)
}' xiyou.txt

# 在代码中使用 if，在代码中使用双引号，awk 能够处理比较字符串
awk -v OFS='#' '{
if($1 == "root" && $2 > 1) {
	print("root 用户运行的进程的 pid: ", $2)}
}' xiyou.txt
```

### 补充内容

| 关系运算符 | 含义                              |
| ---------- | --------------------------------- |
| >          | 大于 m > n                        |
| <          | 小于 m < n                        |
| \>=        | 大于等于 m \>=n                   |
| \<=        | 小于等于 m \<=n                   |
| \=\=       | 等于 m \=\= n                     |
| \!=        | 不等于 m \!= n                    |
| ~          | 正则匹配符号，text ~ /正则表达式/ |
| \!=        | 不匹配正则，text !~ /正则表达式/  |

| 逻辑运算符 | 含义                                            |
| ---------- | ----------------------------------------------- |
| a \|\| b   | a 条件为真，或 b 条件为真，则整个表达式的值为真 |
| a && b     | a 条件为真，且 b 条件为真，则整个表达式的值为真 |
| ！a        | 若 a 条件为真，则整个表达式的值为假             |