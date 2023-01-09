---
title: '压缩文件(tar,zip,7z,rar,gzip,bzip2)'
date: 2022-12-30 20:26:51
tags: 西柚云Linux教程
---

<iframe src="//player.bilibili.com/player.html?aid=520131164&bvid=BV11M411k7mA&cid=891610656&page=1"style="width:100%;height:500px;min-width:375px;min-height:200px" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>

<!--more-->
>适用于 ubuntu 20.04
>ubuntu 20.04 是 “西柚云” 主要使用的操作系统 [西柚云官网](https://www.xiyoucloud.net/aff/VKRWMUHQ)

**打包**是将一个或多个文件的数据信息收集到1个文件中
**压缩**是使用另一种数据格式存储文件，使得压缩后的文件占用存储空间更小。
**解压缩**是从压缩后的文件中还原被压缩的文件
```bash
# 创建文件和目录用于练习压缩与解压缩
mkdir -p /tmp/xiyouyun
touch {1..9}.txt
mkdir {1..9}
```

## tar用于压缩文件和目录，保留压缩前的文件

```bash
# 仅打包文件，但并不压缩 create an archive
tar -cf xiyou.tar 1 1.txt
# 从打包文件中提取出文件, extract from an archive
tar -xf xiyou.tar
# 打包文件，并通过 gzip 对文件进行压缩，v 参数用于在压缩时显示详情，z 指定压缩工具为 gzip
tar -czvf xiyou.tar.gz 1 1.txt
# 解压文件到 xiyou 目录，该目录需要提前创建
mkdir xiyou
tar -xzvf xiyou.tar.gz -C xiyou

# 使用 bzip2 的方式进行压缩与解压缩
tar -cjvf xiyou.tar.bz2 1 1.txt
tar -xjvf xiyou.tar.bz2 -C xiyou

# 不解压文件，只查看压缩包中的内容
tar -tf xiyou.tar.gz
```

## zip/unzip：可用于压缩文件和目录，保留压缩前的文件

```bash
# 压缩目录时要添加 -r 参数，这样才能将目录下的所有文件添加到压缩包中
zip -r xiyou2.zip 2 2.txt
# 将文件解压缩到目录中, 目录会自动被创建
unzip -d xiyou2 xiyou2.zip
# 不解压文件，仅查看压缩文件中的文件信息
unzip -l xiyou2.zip
```

## 7z：开源免费，支持压缩文件和目录

**sudo apt install p7zip-full**

```bash
# 压缩，r 表示递归操作目录下的所有子文件
7za a -r xiyouyun.7z /tmp/xiyouyun/*
# 解压缩
7za x -r xiyouyun.7z
```

## rar：winrar在Linux中的替代品

使用 **sudo apt install rar unrar** 安装软件，rar 默认收费，且不支持 linux，这里使用的是第三方开发的 linux 包，使用第3方软件可能会有未知的错误（可能性极小），详情可查看 [rar官网](https://www.rarlab.com/rar_add.htm)

```bash
# 将当前目录下的所有文件名以 txt 结尾的文件压缩到 all.rar 中
rar a all *.txt
# 解压 rar 文件
unrar e all.rar
```

## bzip2只能压缩文件，不能压缩目录

bzip2不保留压缩前的文件，文件压缩后被保存为xx.bz2

```bash
# 将文件压缩为 2.txt.bz2，原文件将会消失
bzip2 2.txt
# 解压缩
bzip2 -d 2.txt.bz2
```

## gzip只能压缩文件，不能压缩目录, 

gzip不保留压缩前的文件，文件压缩后被保存为 xx.gz

```bash
# 压缩文件
gzip 3.txt
# 解压缩文件
gzip -d 3.txt.gz
```

# 补充内容
## **解压缩注意事项：**

在使用 tar 解压文件时，本地如果存在和压缩包中同名的文件，会直接被覆盖不会有任何提示，因此建议使用 tar 解压时指定一个空目录，将文件解压缩到空目录中。
```bash
mkdir xiyou
tar -xzvf xiyou.tar.gz -C xiyou
```
## **分卷压缩：**

在很多应用场景中都存在数据大小的限制，如：“单次上传文件大小不能超过1GB”。这个时候就可以用到分卷压缩了。它可以将 1 个大文件压缩并按照规定大小划分成多卷，如将10GB的文件压缩后划分为10卷，每卷1GB，之后也能通过命令将10个卷重新组合成1个大文件。

```bash
# 这个命令会向 xiyou.txt 文件写入 1000000 行数据, 大约 22MB
for i in {1..1000000}; do echo "$i hello xiyouyun " >> xiyou.txt; done;
du -sh xiyou.txt
```
```bash
# 分卷压缩，每卷为1MB
tar zcf - xiyou.txt |split -d -b 1m - xiyou.tar.gz
# 分卷解压缩，因为压缩是使用的是 gzip，所以解压时也用 gzip
# 这里先删除xiyou.txt 文件，测试解压缩后是否能够还原 xiyou.txt
rm xiyou.txt
cat xiyou.tar.gz0* | tar zx
tail xiyou.txt
```