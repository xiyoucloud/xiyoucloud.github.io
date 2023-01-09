---
title: '查看文件(cat,head,tail,less,more)'
date: 2022-12-30 16:47:00
tags: 西柚云Linux教程
---
<iframe src="//player.bilibili.com/player.html?aid=690104074&bvid=BV1k24y127zf&cid=888455696&page=1" style="width:100%;height:500px;min-width:375px;min-height:200px"scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>

<!--more-->
> 针对 ubuntu20.04
> ubuntu 20.04 是 “西柚云” 主要使用的操作系统  [西柚云官网](https://www.xiyoucloud.net/aff/VKRWMUHQ)

查看一个文件内容的方式是命令 + 文件路径
这里先构建 1 个文件，方便后面命令演示。
```bash
mkdir -p /tmp/xiyouyun
# 这样可以少打几个字符，这里的 $_ 等价于 /tmp/xiyouyun
cd $_
# 向文件中写入内容, 以下命令会向文件中写入 1000 行 hello,xiyouyun
for i in {1..1000}; do echo "$i hello xiyouyun " >> xiyou.txt; done;
```
## cat

```bash
# 使用 cat 查看文件的全部内容
cat xiyou.txt
# 查看文件时显示行号
cat -b xiyou.txt
# 查看文件时显示隐藏字符
cat -A xiyou.txt
```

## head

```bash
# 从文件的开始部分查看文件内容，默认 10 行
head xiyou.txt
# 查看文件的前 10 行
head -n 10 xiyou.txt
```

## tail

```bash
# 从文件的尾部查看文件内容，默认 10 行
tail xiyou.txt
# 查看文件的后 10 行
tail -n 10 xiyou.txt
# 向 ping.txt 中持续写入内容，可以暂时不管这条命令的含义
ping g.cn > ping.txt &
# 查看文件的尾部，如果文件内容持续增长，则会动态刷新显示
tail -f ping.txt
```

## less

```bash
# 使用 less 查看文件的头部部分，按 Enter 滚动查看后面的行, 按 q 退出查看，按空格支持翻页
# 使用方向键支持上下滚动查看，使用 ?text 支持在当前页搜索
less xiyou.txt
```

## more

```bash
# 使用 more 查看文件的头部部分，more 只支持向下滚动，不能上下滚动，按 q 退出查看
more xiyou.txt
```

## 补充内容：
### **如何快速清空 1 个文件？**

#### 使用重定向

```bash
# 向文件中写入内容, 以下命令会向文件中写入 1000 行 hello,xiyouyun
for i in {1..1000}; do echo "$i hello xiyouyun " >> xiyou.txt; done;
# 清空一个文件
cat /dev/null > xiyou.txt
```

#### 使用 vim	

```bash
# 向文件中写入内容, 以下命令会向文件中写入 1000 行 hello,xiyouyun
for i in {1..1000}; do echo "$i hello xiyouyun " >> xiyou.txt; done;
# 进入 vim 的命令模式，清空 1 个文件分为 3 步：
	# 1. 使用 gg 将光标跳转到文件的第 1 行
	# 2. 使用 d + Shift + g 清空整个文件
	# 3. 使用 Shift + z + z 保存文件
vim xiyou.txt
```

### **如何查看隐藏字符？**

你想要编写一个 bash 脚本（一种能在 linux 系统上执行的程序），但你不会使用 linux 上的编辑器（nano 和 vim），所以你在你自己的 windows 电脑上编辑好后，将文件上传到 linux 上。却发现脚本并不能执行，这是因为在 windows 中使用的换行符和 linux 中使用的换行符是不同的，但是使用 `cat <filename>` 是看不出隐藏的换行符的。此时需要使用 `cat -A <filename>` 查看。如果你想让 windows 上编写的 bash 脚本能够在 linux 上执行怎么办呢？有两种办法:

1. 不要将在 win 上编写的脚本文件上传到 linux，而是复制文件的内容到 linux 的文件中。通常可以用Ctrl + Shift + v 在 linux 中粘贴内容。

2. 将文件上传到 linux 后，借助工具 dos2unix 将文件的格式转化为 linux 使用的格式


```bash
# 这个工具需要使用 apt install dos2unix 安装
# 假设有个 windows 换行格式的文件名为 xiyou.txt，你可以用以下命令将其转化为 linux 换行格式
cat -A xiyou.txt
dos2unix xiyou.txt
# 通过查看文件中的隐藏字符对比两个文件有何变化
cat -A xiyou.txt
```