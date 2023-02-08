---
title: singularity/apptainer使用教程
date: 2023-01-20 12:25:50
tags: [singularity, apptainer]
---

## 安装

```bash
# 安装 singularity
conda create -n singularity
conda activate singularity
conda install -c conda-forge singularity

# 安装 apptainer
conda create -n apptainer
conda activate apptainer
conda install -c conda-forge apptainer
```

<!--more-->

**Apptainer**是一个相对较新的容器软件，相对于 docker 来说，它不需要 root 权限，因此更符合科研应用的场景（因为共享服务器中普通用户通常不会有root权限）。

Apptainer 的旧版本被称为 Singularity，关于它们之间的兼容性以及从 singularity 迁移到 apptainer 可以参考这个链接：https://apptainer.org/docs/user/main/singularity_compatibility.html

通常来说，singularity 可以用 apptainer 命令代替（如果你安装了 apptainer）。

Singularity官方文档：https://github.com/apptainer/singularity

Apptainer官方文档：https://github.com/apptainer/apptainer

|                    | Docker                                                       | Apptainer（使用Singularity的话，将命令中的apptainer替换为singularity） |
| ------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 镜像               | 有                                                           | 无（Apptainer没有镜像的概念，用户创建和运行的都是一个个容器） |
| 获取镜像（容器）   | `docker pull busybox:latest`                                 | `apptainer pull ./busybox.sif docker://busybox:latest`或者`apptainer build ./busybox.sif docker://busybox:latest` |
| 容器               | 有                                                           | 有（Apptainer容器有两种存在形式：SIF和sandbox。SIF只读，主要用来执行用户程序；sandbox可修改，可用来开发和创建新容器） |
| 查看运行的容器     | `docker ps`                                                  | `apptainer instance list`                                    |
| 运行容器           | `docker run busybox ping www.baidu.com`                      | `apptainer exec busybox.sif ping www.baidu.com`              |
| 挂载目录           | `-v host_path:container_path`                                | `-B`或者`--bind`                                             |
| 交互式运行容器     | `docker run -it busybox`                                     | `apptainer shell busybox.sif`                                |
| 自定义镜像（容器） | [Dockerfile文件](https://www.runoob.com/docker/docker-dockerfile.html) | [Definition Files](https://docs.sylabs.io/guides/3.7/user-guide/definition_files.html) |

## 拉取镜像

```bash
apptainer pull docker://ubuntu:22.04
# 拉取镜像之后指定镜像在本地保存的文件名称
apptainer build ubuntu22.sif  docker://ubuntu:22.04
```

## 转化镜像格式

*.sif文件是 apptainer 使用的镜像格式。

```bash
# 将tar包格式的docker镜像转化为sif格式
singularity build hello_world.sif docker-archive://hello_world.tar
```

## 在容器中执行命令

```bash
# 方式1：进入到容器，然后再终端中执行命令
apptainer shell ubuntu22.sif
# 方式2：在容器中执行 pwd 命令
apptainer exec ubuntu22.sif "pwd"
```

## 运行容器

[Apptainer](https://apptainer.org/docs/user/main/definition_files.html#runscript)容器内部包含运行脚本。这些是构建容器是作者自定义的脚本，用于定义容器在运行时应执行的操作。runscript 可以用 [run](https://apptainer.org/docs/user/main/cli/apptainer_run.html) 命令触发，或者简单地通过调用容器就像它是一个可执行文件一样。

```bash
# 方式 1
apptainer run ubuntu22.sif 
# 方式 2
./ubuntu22.sif
```

## 映射

默认情况下，Apptainer 会在运行时将`/home/$USER`、 `/tmp`和绑定`$PWD`到您的容器中。当然 apptainer 也提供了其他参数可以在宿主机和容器中进行映射。详情可以参考这个链接：https://apptainer.org/docs/user/main/bind_paths_and_mounts.html

## 构建容器

构建容器有两种方式，一种是根据原有的镜像进行更改。

一种是根据镜像定义文件 xx.def 定义镜像的构建流程。构建 xx.def 的语法规则可以参考这个链接：https://apptainer.org/docs/user/latest/definition_files.html

apptainer镜像文件默认只可以复制和验证，如果想要自己构建镜像，需要一种可写的镜像格式，此时需要以沙箱的模式运行镜像。

```bash
# 此命令在当前工作目录中创建一个名为ubuntu/整个 Ubuntu 操作系统和一些 Apptainer 元数据的目录。
apptainer build --sandbox ubuntu/ docker://ubuntu

# 运行容器，并在其中对镜像进行修改（如安装软件）
apptainer shell --fakeroot -w ./ubuntu
```

文件内容示例 lolcow.def：

```yml
BootStrap: docker
From: ubuntu:20.04

%post
    apt-get -y update
    apt-get -y install cowsay lolcat

%environment
    export LC_ALL=C
    export PATH=/usr/games:$PATH

%runscript
    date | cowsay | lolcat

%labels
    Author Alice
```

根据文件内容构建镜像：

```bash
apptainer build lolcow.sif lolcow.def
```

## apptainer容器内后台运行程序

### 准备文件

```bash
cd ~
mkdir pyscenic
cd pyscenic
wget https://ghproxy.com/https://raw.githubusercontent.com/aertslab/scenic-nf/master/example/expr_mat.tsv
wget https://ghproxy.com/https://raw.githubusercontent.com/aertslab/scenic-nf/master/example/allTFs_hg38.txt
```

我们先来看看如何使用 apptainer 或 docker 在**前台**运行 pyscenic容器。

### 示例1（使用 apptainer 运行 pyscenic）：

```bash
apptainer run -B $PWD:/data/ pyscenic_0.10.0.sif pyscenic grn --num_workers 5 --output /data/expr_mat.adjacencies.apptainer.tsv /data/expr_mat.tsv /data/allTFs_hg38.txt
```

### 示例2（使用 docker运行 pyscenic 的命令）：

```bash
docker run -it --rm -v $PWD:/data aertslab/pyscenic:0.10.0 pyscenic grn --num_workers 5 -o /data/expr_mat.adjacencies.docker.tsv /data/expr_mat.tsv /data/allTFs_hg38.txt
```

参考以上两个示例，我们可以写出在容器内部后台执行命令的方式。

首先运行一个容器，然后进入到容器内部，将对应的命令使用 nohup 挂起运行。

如果你想了解如何让程序后台运行的方式可以参考这个链接：{% post_link 进程的后台运行-bg-fg-nohup %}

```bash
# 进入容器让命令后台运行
singularity instance start pyscenic_0.10.0.sif pyscenic
## 查看运行中的容器
singularity instance list
## 进入容器内部
singularity shell instance://pyscenic
## 后台执行命令
nohup pyscenic grn --num_workers 16 -o $PWD/expr_mat.adjacencies.docker.tsv $PWD/expr_mat.tsv $PWD/allTFs_hg38.txt &
```

## 在容器中安装和使用软件

在沙箱容器中安装的软件只能在容器中使用。

```bash
# 构建沙箱环境的保存目录
apptainer build --sandbox ubuntu/ ubuntu22.sif
# 进入到容器中
apptainer shell --fakeroot -w ./ubuntu

# 安装软件并使用，容器内用户拥有 root 权限
apt update
apt install r-base
# 在容器中运行软件
R
```











