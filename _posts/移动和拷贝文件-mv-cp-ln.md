---
title: '移动和拷贝文件(mv,cp,ln)'
date: 2022-12-30 20:36:11
tags: 西柚云Linux教程
---

<iframe src="//player.bilibili.com/player.html?aid=987650109&bvid=BV1nt4y1N7aZ&cid=892727922&page=1" style="width:100%;height:500px;min-width:375px;min-height:200px"scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>

<!--more-->

>适用于 ubuntu 20.04
>ubuntu 20.04 是 “西柚云” 主要使用的操作系统 [西柚云官网](https://www.xiyoucloud.net/aff/VKRWMUHQ)

## 移动和拷贝文件的三个相关概念
1. 拷贝：将文件或目录复制到另一个路径中；
2. 移动：将文件或目录移动到另一个路径中；
3. 链接：链接分为软链接和硬链接，软链接又被称为符号链接，软链接可以对文件和目录创建，硬链接只能对文件创建；软链接链接的是文件路径，硬链接链接的是文件内容。

```bash
# 创建目录用于命令演示
mkdir -p /tmp/xiyouyun
# 切换到 xiyouyun 目录
cd $_

mkdir xiyou-1 xiyou-2
touch {1..9}.txt
```

## cp：拷贝，软硬链接

```bash
# 拷贝文件
cp 1.txt 1-copy.txt
# 拷贝目录
cp -r xiyou-1 xiyou-1-copy
# 软链接, 只能在当前目录对文件建立软链接，不能对目录建立软链接
cp -s 1.txt 1-symbollink.txt 
# 硬链接，只能在当前目录建立硬链接
cp -l 1.txt 1-hardlink.txt

# 用于区分软硬链接的不同
echo "hello" > 1.txt
 ## 可以通过软硬链接查看文件内容
cat 1-symbollink.txt 
cat 1-hardlink.txt
 ## 删除文件后，不能通过软链接查看文件内容
rm 1.txt
cat 1-symbollink.txt 
 ## 可以通过硬链接查看文件内容
cat 1-hardlink.txt
```

## mv：移动文件

```bash
# 将 1.txt 文件移动到 xiyou-1 目录中
mv 1.txt xiyou-1
# 移动文件时，可以在指定路径时指定移动后的文件名，这里移动后文件名变为 22.txt
mv 2.txt xiyou-2/22.txt
# 将 xiyou-1/1.txt 移动到当前目录
mv xiyou-1/1.txt .
# 移动目录
mv xiyou-1 xiyou-2
# 使用 mv 对单个文件重命名
mv 1.txt 11.txt
```

## ln：软硬链接

```bash
# 软链接，建立的软链接可不保存在当前目录
ln -s 3.txt xiyou-2/3-simbollink.txt
# 硬链接，建立的硬链接可不保存在当前目录
ln 3.txt xiyou-2/3-hardlink.txt
```

# 补充内容

## 如何判断一个文件是软链接?

（看箭头，看 ls -l 的输出）判断文件是否是软链接

![请添加图片描述](移动和拷贝文件-mv-cp-ln/0ac50948480041c7919f97cd87c9469b.png)

## 如何判断一个文件是否存在硬链接？

(看引用数，看 ls -l 的信息) 判断文件是否存在硬链接

   ![请添加图片描述](移动和拷贝文件-mv-cp-ln/6eb734f8e28e4d4aaf1ec0aacd8d5a2d.png)

## 修改时备份

修改一个重要配置文件时，一定要做拷贝备份！这样出错时可以恢复文件到未修改的状态。


```bash
echo "xiyou#……&*￥#（" > xiyou.txt
# 做拷贝备份
cp xiyou.txt xiyou.txt.bak
# 清空 1 个文件
cat /dev/null > xiyou.txt
cat xiyou.txt
# 恢复被删除的文件
mv xiyou.txt.bak xiyou.txt
```

## mv可能会导致文件丢失

mv 默认会覆盖目标路径下的同名文件, 这可能会导致文件信息丢失，因此使用 mv 移动文件时，要确保目标路径下没有同名文件

```bash
echo "xiyou#……&*￥#（" > xiyou.txt
cat xiyou.txt
mv 3.txt xiyou.txt
cat xiyou.txt
```