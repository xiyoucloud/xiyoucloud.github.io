---
title: ping和github代理
date: 2022-12-30 21:56:50
tags: 西柚云Linux教程
---

<iframe src="//player.bilibili.com/player.html?aid=263073831&bvid=BV1JY411d77K&cid=903013242&page=1"style="width:100%;height:500px;min-width:375px;min-height:200px" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>

<!--more-->



>适用于 ubuntu 20.04
>ubuntu 20.04 是 “西柚云” 主要使用的操作系统 [西柚云官网](https://www.xiyoucloud.net/aff/VKRWMUHQ)

## 网络的联通性

说到联通性，自然至少涉及到两个对象，比如说主机A和主机B是联通的。那么我们怎么判断我们当前使用的电脑和某个ip或域名对应的主机是否联通呢？

好了，这里提到了 ip 和域名，那么他们是什么关系呢？

通常来说，网络上的两台主机能够通过 ip 来进行通信，ip 的形式如：x.x.x.x，其中 x 是一个[0,255]区间的数字。

但是 4 个数字并不如一些有意义的字符好记。如: www.baidu.com，github.com。

所以，你也可以使用域名替换掉ip与主机通信。通常来说，在公网中会有 DNS 服务器将域名解析成 ip，这样就能通过访问域名的方式来访问主机啦。你也可以在本地配置域名和 ip 的映射关系。

linux 本地配置域名和 ip 映射的文件在 /etc/hosts 中，因为 Linux 中没有浏览器，我这里使用 windows 来演示一下，原理是一样的。

```bash
pint www.baidu.com
http://14.215.177.38
http://www.baidu.com
```

## ping

```bash
# 1 个不能访问的链接
wget  https://raw.githubusercontent.com/qiime2/environment-files/master/2018.8/release/qiime2-2018.8-py35-linux-conda.yml

# 使用 github 代理访问
wget https://ghproxy.com/https://raw.githubusercontent.com/qiime2/environment-files/master/2018.8/release/qiime2-2018.8-py35-linux-conda.yml

# 这个就是这个链接对应的域名
ping raw.githubusercontent.com
```

## 127.0.0.1 和 localhost

127.0.0.1 是本机的 ip 地址，localhost 是它对应的域名

当然本机还有一个对外的 ip 地址，不过如果不是公网 ip 的话，对于其他和本机不属于一个局域网的主机来说没有实际意义，如 192.168.0.1，很多路由器的 ip 地址是这个，登陆它能够对路由器进行设置。但对于不跟路由器在同一个局域网的主机，是不能通过这个 ip 登陆它的。

## 依赖网络连通性的 linux 命令

```bash
ssh
ftp / sftp
wget 
curl 
```

# 补充内容

## github 代理

每个代理使用的方法不一样，可以访问他们的官网查看使用方法。

[https://hub.yzuu.cf/](https://hub.yzuu.cf/)
[https://hub.njuu.cf/](https://hub.njuu.cf/)
[https://ghproxy.com/](https://ghproxy.com/)
[https://github.moeyy.xyz/](https://github.moeyy.xyz/)
[https://kgithub.com/](https://kgithub.com/)
[https://gitclone.com/](https://gitclone.com/)

