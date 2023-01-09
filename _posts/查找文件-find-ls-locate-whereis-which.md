---
title: '查找文件(find,ls,locate,whereis,which)'
date: 2022-12-30 16:58:37
tags: 西柚云Linux教程
---
<iframe src="//player.bilibili.com/player.html?aid=220016762&bvid=BV1M841187rx&cid=889543162&page=1" style="width:100%;height:500px;min-width:375px;min-height:200px"scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>
<!--more-->

> 针对 ubuntu20.04
> ubuntu 20.04 是 “西柚云” 主要使用的操作系统  [西柚云官网](https://www.xiyoucloud.net/aff/VKRWMUHQ)

## 文件的属性

文件的属性有：文件的大小（size），文件的名称（name），文件的类型（type），文件的路径（path），文件的修改日期（modify_time）……我们可以根据文件的属性，在系统中查找符合筛选条件的文件。

## ls 列出指定路径下的文件信息

ls 配合 grep 可以通过文件名筛选文件

```bash
# 筛选路径 /etc/apt 目录下文件名中包含 list 的文件，这里的 “| grep list” 的原理可以先不管 
ls /etc/apt | grep list
```

## find 可以对文件的属性进行筛选

find 命令可以对几乎所有的文件属性进行筛选，**在 linux 系统中 \* 可以匹配路径中的任意字符**
这里只列举几个常用的例子，更多的文件属性筛选可以查看文档：[https://wangchujiang.com/linux-command/c/find.html](https://wangchujiang.com/linux-command/c/find.html)

```bash
  # 列出 /tmp 目录下的所有文件和目录
  find /tmp
  # 列出 /etc/apt 目录下文件或目录名以 list 或 d 结尾的文件
  find /etc/apt "*.list -o *.d"
  # 在前一条命令的基础上筛选文件类型为“文件”的
  find /etc/apt "*.list -o *.d" -type f
  # 筛选文件类型为“目录”
  find /etc/apt "*.list -o *.d" -type d
  # 默认会搜索路径下的所有子目录，通过 maxdepth 可以让它只搜索当前搜索到第 1 层子目录就不再继续往下搜索了
  find /etc/apt "*.list -o *.d" -maxdepth 1 -type f
```

## locate 查找系统中的文件

locate 命令来自于 mlocate 软件，需要使用命令 `apt install mlocate`安装，其用于**快速**定位软件的位置，支持正则表达式。

```bash
# 找到系统中 python 文件的位置
locate *.py
# 列出系统中所有的文件名以 .R 结尾的文件
locate *.R
```

## whereis 定位系统中二进制文件的位置

```bash
# 定位系统 R 可执行程序的位置
whereis R
# 定位系统中 python 可执行程序的位置
whereis python
```

## which 查找命令的绝对路径

这在系统中安装了多个版本的软件时十分实用。如在 conda 环境中通常安装了多个 python 环境，可以使用这种方式定位到当前使用 python 命令使用的是哪个路径下的 python。

```bash
# 查看执行 python 命令时，使用的是哪个路径下的程序
which python
# 查看执行 R 命令时，使用的是哪个路径下的程序
which R
```

## 扩展内容

### find 常用操作

```bash
# 删除修改时间超过 1 天的文件（保留最近 24 小时的文件）
find . -type f -mtime 1 -exec  rm -rf {} \;

# 筛选当前目录下大于 10MB 的文件
find . -size +10M

# find 查找目录时跳过 tmp 目录
find . -path "/tmp" -prune -o -type f -name *.bam -print
```