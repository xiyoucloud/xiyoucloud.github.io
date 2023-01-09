---
title: '进程的后台运行(bg,fg,jobs,nohup,&)'
date: 2022-12-30 21:08:40
tags: 西柚云Linux教程
---
<iframe src="//player.bilibili.com/player.html?aid=520271004&bvid=BV1tM411C7ke&cid=897743562&page=1"style="width:100%;height:500px;min-width:375px;min-height:200px" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>

<!--more-->


>适用于 ubuntu 20.04
>ubuntu 20.04 是 “西柚云” 主要使用的操作系统 [西柚云官网](https://www.xiyoucloud.net/aff/VKRWMUHQ)

## 让进程后台运行的方式

## 1.&

```bash
sleep 10086 &
```

## 2.ctrl + z 和bg搭配

```bash
sleep 10010
# 按 ctrl + z
# 在终端输入 bg
bg 
```

## 3.使用 nohup 的方式后台运行进程

```bash
nohup sleep 1111 &
```

## 查看后台运行的进程（jobs）

```bash
jobs -l
```

## 将后台运行的进程转到前台运行（fg）

可以根据后台运行的进程编号将对应的进程转到前台来运行，编号可通过 jobs 命令查看

```bash
# 查看进程编号
jobs
# 将 1 号后台运行的进程转到前台运行
fg 1

# 不指定编号，默认将编号最大的进程转到前台运行
fg
```



# 补充内容

## **后台运行的进程在终端关闭后还能继续运行吗？**

分情况，使用上文中的方式 1 和方式 2 运行的后台进程会在终端关闭后被杀死。

而使用 nohup 运行的后台进程在终端关闭后而主机还在运行的情况下继续运行。

下面我们来介绍一下原理:

假设我们通过 SSH 协议连接到一台 Linux 主机，连接后我们可以在当前的终端执行命令。

```bash
# 我们以上述的 3 种方式运行后台进程
 ## &
sleep 10010 &
 ## ctrl + z, bg
sleep 10086
 ## nohup
nohup sleep 111111 &
```

## **进程的组织结构：**

Linux 中进程的组织结构就像一棵树

```bash
ps -ef | grep <username>
pstree -anph | grep sshd -A 5

# 一般来说，父进程被杀死后，子进程也会被杀死，但使用 nohup 方式运行的后台进程会在 sshd 进程被杀死后将
# 进程托管给 linux 的 init 进程，这样这个进程就会继续运行了。

ps -ef | grep sleep
```

使用 & 和 （ctrl + z，bg）方式运行的进程在终端关闭后就被杀死了，而使用 nohup 后台运行的进程在终端关闭后还运行在机器中。这是因为通常终端与 Linux 服务器是通过 SSH 协议连接的，每次连接都会建立一个 sshd 进程，在这个终端下运行的所有进程都会作为这个 sshd 进程的子进程。终端关闭后 sshd 进程就结束了，于是它的子进程也就被杀死了。

使用 nohup 运行的后台进程会在终端关闭后将进程托管到 Linux 的 init 进程，这个进程是一直在服务器中运行的，所以该进程的子进程不会因为父进程被杀死而结束。

## **运行进程时记录日志：**

在让进程后台运行时，我们通常需要记录日志，用于了解进程的运行情况。

比如运行 jupyter notebook 时，我们通常将日志输入到文件中

```bash
nohup jupyter notebook 1>jupyter.log 2>&1 &
```

这里的 2 表示的是错误输出，1 表示的是标准输出，标准输出会输出到终端。上述的 `2>&1` 会将标准错误输出重定向标准输出（终端），`1>jupyter.log`会将标准输出中的内容重定向到 jupyter.log 文件中，这样进程输出的日志信息就全都记录在 jupyter.log 文件中了，查看 jupyter.log 文件中的内容，就能知道进程的运行状态了。