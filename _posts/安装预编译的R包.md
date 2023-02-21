---
title: 安装预编译的R包
date: 2023-02-22 22:32:53
tags: [R包]
---

对于来源于CRAN的包，如果在安装时遇到编译失败的问题，可以尝试安装它的预编译版本。

<!--more-->

## 设置options

```bash
options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"])))
```

## 设置CRAN镜像

```bash
# 以 linux 系统为例
options("repos" = c(CRAN="https://packagemanager.rstudio.com/cran/__linux__/focal/latest"))
```

## 安装R包

{% post_link 如何安装R包 %}