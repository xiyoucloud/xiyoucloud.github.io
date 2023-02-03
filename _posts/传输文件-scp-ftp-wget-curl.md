---
title: '传输文件(scp,ftp,wget,curl)'
date: 2022-12-30 20:18:40
tags: 西柚云Linux教程
---

<iframe src="//player.bilibili.com/player.html?aid=517525445&bvid=BV1Ug411i72Z&cid=890693727&page=1" style="width:100%;height:500px;min-width:375px;min-height:200px"scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>

<!--more-->

>适用于 ubuntu 20.04
>ubuntu 20.04 是 “西柚云” 主要使用的操作系统 [西柚云官网](https://www.xiyoucloud.net/aff/VKRWMUHQ)

## scp用于在能够联通的不同的主机下传输文件

scp 与 cp 的区别是，cp 用于在 linux 本机下拷贝文件到其他路径。

scp 的原理其实是使用 ssh 协议登陆到 linux 服务器，然后传输文件

ssh 协议可以使用用户名和密码登陆Linux，也可以使用用户名和密钥来登陆。

**以下的 user，host，port，xx.pem都需要代入具体的值**

```bash
ssh user@host -p port (需要输入密码)
ssh user@host -p port -i xx.pem （使用密钥进行认证）
# 使用 scp 拷贝文件时使用的命令与 ssh 是类似的。
scp -P port user@host:/tmp/xiyou.txt . (将远程主机的 /tmp/xiyou.txt 文件拷贝到本机的当前工作目录，这里"."表示当前目录，需要输入密码)
scp -r -P port user@host:/tmp/ . (复制远程主机上的目录到本机的当前工作目录) 
	    
scp -i xx.pem -P port user@host:/tmp/xiyou.txt . (使用秘钥 xx.pem 的方式认证，不需要输入密码，秘钥需要提前生成)
# 将本地的文件拷贝到远程主机上：
scp -P port user@host:/tmp xiyou.txt
```


​	    

## ftp用于从文件服务器上下载文件

首先要有一台 ftp 服务器，然后你要有这台 ftp 服务器的账号和密码。登陆后你可以使用 cd，ls，pwd 三个基础命令查看系统中文件的位置，使用 get 从 ftp 服务器获取文件，使用 put 将文件上传到 ftp 服务器。使用 quit 退出登陆。出现“500 Illegal PORT command”的报错可以通过输入 passive 来解决报错。
```bash
ftp x.x.x.x
cd
ls
pwd
get 
put
quit
```

[https://wangchujiang.com/linux-command/c/ftp.html](https://wangchujiang.com/linux-command/c/ftp.html) 

## wget用于从网络中下载文件

```bash
# 下载链接中的图片 https://mirrors.tuna.tsinghua.edu.cn/static/img/logo-small-dark.png 并存储为 tuna.png
wget -O tuna.png "https://mirrors.tuna.tsinghua.edu.cn/static/img/logo-small-dark.png"
ls -la | grep tuna.png
# 下载一个文件，不指定文件名
wget https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu/gpg
ls -la | grep gpg
# 查看 wget 其他参数的使用方法
wget --help
# -c 参数支持断点续传，这在传输大文件时十分有用
wget -c -O tuna2.png https://mirrors.tuna.tsinghua.edu.cn/static/img/logo-small-dark.png
```



## curl通常用来在终端中模拟浏览器访问网站

curl 也可以用来下载文件，不过使用体验不如 wget。

```bash
# 使用 curl 下载链接中的文件，并保存为 tuna3.png
curl -o tuna3.png https://mirrors.tuna.tsinghua.edu.cn/static/img/logo-small-dark.png
# 查看 curl 的其他用法
curl --help
```

## rsync

参考链接：https://www.ruanyifeng.com/blog/2020/08/rsync.html

```bash
# 使用 2234 端口，将本地的 source 目录拷贝到远程机的 /destination 目录
rsync -av -e 'ssh -p 2234' source/ user@remote_host:/destination
```

## 补充内容：

### mwget

mwget 是 wget 的升级版，支持多线程，下载速度更快。安装方式如下：

```bash
# 安装编译依赖
sudo apt update
sudo apt install build-essential -y
sudo apt upgrade intltool -y
sudo apt install  libssl-dev -y

# 编译
git clone https://github.com/rayylee/mwget.git
cd mwget
./configure
sudo make && sudo make install

# 查看使用方法
mwget --help

mwget https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu/gpg
```

上文中提到的 ftp 和 scp 在远程传输，我们可以借助工具来实现，如 finalshell，xshell,putty,secretCRT……等工具来实现文件的上传和下载。

这里推荐finalshell，因为它支持 win、mac、linux。官网：[https://www.hostbuf.com/](https://www.hostbuf.com/)