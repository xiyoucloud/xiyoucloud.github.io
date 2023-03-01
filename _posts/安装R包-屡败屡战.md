---
title: 安装R包-屡败屡战
date: 2023-02-21 22:10:25
tags: [R包, conda, docker]
---

在安装R包的过程中，你可能会遇到很多问题，这篇文章罗列了使用不同安装工具来安装R包的方式，或许当一条路走不通时，可以试试其他路子~:closed_lock_with_key:

<!--more-->

在这篇文章中演示了如何安装R包，感兴趣的同学可以看看 {% post_link 如何安装R包 %}

# 使用R内置的install

这种方式通常用来安装来源于[CRAN](https://cran.r-project.org/)的R包，除此之外 install 还经常用于根据源码来安装R包。

```bash
install.packages(pkgs, lib, repos = getOption("repos"),
                 contriburl = contrib.url(repos, type),
                 method, available = NULL, destdir = NULL,
                 dependencies = NA, type = getOption("pkgType"),
                 configure.args = getOption("configure.args"),
                 configure.vars = getOption("configure.vars"),
                 clean = FALSE, Ncpus = getOption("Ncpus", 1L),
                 verbose = getOption("verbose"),
                 libs_only = FALSE, INSTALL_opts, quiet = FALSE,
                 keep_outputs = FALSE, ...)
# 通常，你只需要指定包名就可以进行安装了，它默认将 R 包安装在 .libPaths() 输出的第一个 libpath 下
install.packages("stringr")
# 根据源码安装R包
install.packages("xx.tar.gz", repos=NULL, type="Source")
```

# 使用R包安装工具

这里说的R包安装工具是指：BiocManager,devtools,remotes。有的 R 包除了发布在CRAN，还发布在其他的平台上。

BiocManager 可以安装发布在 Bioconducter 的 R 包。

devtools 常用于安装来源于 github 的 R 包，remotes 也用于安装来源于 github 的 R 包。

remotes 通常也用于安装来源于 github 的 R 包，两者的区别是 remotes 可以在安装时可以使用 github 代理，这个功能不是 remotes 提供的，它能实现这个功能是因为它在安装 R 包时可以指定 R 包所在 github 仓库的完整链接，而基于链接变形后可以通过 github 代理来下载 R 包。

详情可以参考：{% post_link 如何安装R包 %}

当 R 包发布在 github 时，通常在它的 README.md 文件中说明它应该用 devtools 来安装，这就是我理解的 remotes 和 devtools 的区别。



# 使用renv

renv 本身并不能解决一系列 R 包安装失败的问题，不过使用它可以创建一个独立的 R project，这可以避免安装 R 包过程中的一些R包版本冲突的问题。

详情可以参考 {% post_link renv使用教程 %}

# 使用conda

在安装R包时可能会遇到编译失败的报错，如果你不能设法解决它，可以使用 conda 来安装它。

不过请务必记得在安装 R 包的虚拟环境中安装好对应的 R 版本，并将 conda 安装 R 包的路径添加到 libpath。

下文中以 sf 为例（这个 R 包在编译时可能会报错）。

```bash
# 创建 R 包环境，假设想要在 R 的 4.2.2 版本下使用这个 R 包
conda create -n rpackage r-base=4.2.2 -y -vv
conda activate rpackage
# 安装 R 包
conda install r-sf -y -vv

# 将 R 包的安装路径添加到 libpath 中
.libPaths(.libPaths(), c("/home/txb/envs/rpackage/lib/R/library"))
```

# 使用docker

如果无论如何也安装不上 R 包，且 R 包作者或其他人提供了 R 包的 docker 镜像的话，可以通过运行该镜像的方式在容器中使用 R 包。

# 安装预编译的R包

参考文章：{% post_link 安装预编译的R包 %}

