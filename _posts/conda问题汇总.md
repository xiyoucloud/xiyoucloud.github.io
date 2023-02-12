---
title: conda问题汇总
date: 2023-02-03 23:02:50
tags: [conda, 报错]
---

这篇文章汇总了使用 conda 过程中一些常见的问题。

<!--more-->

## 安装过程慢

conda 安装过程慢有很多种可能，这里列举一下常用的几种可能：

1. 未配置国内镜像源，或软件所在软件源国内无镜像，如：`conda install -c hcc aspera-cli`
2. 安装时指定了官方软件源，如：`conda install -c bioconda sra-tools`；
3. 待安装软件所需依赖与当前环境（这里的环境不仅仅指当前虚拟环境）中的软件包冲突过多，conda 需要大量计算分析来解决软件依赖；
4. 国内软件源无法访问，详情可见 {% post_link conda镜像源汇总 %}

对于第 1 种可能，如果未配置镜像源，可参考 {% post_link conda镜像源汇总 %} 配置国内镜像源。

conda-forge，bioconda，main，这几个软件源在国内是有镜像的。

如果软件所在软件源并无国内镜像，可以开启代理后再进行软件安装、或者耐心等待、或者选择其他安装方式。

对于第 2 种可能，如果所指定的软件源在国内有镜像，可指定为国内镜像源。如若该软件源没有对应的国内镜像源就只能开启代理后再进行软件安装、或者耐心等待、或者选择其他安装方式。

```bash
# 下载时指定北外的 bioconda 镜像源为最高优先级
conda install -c 'https://mirrors.bfsu.edu.cn/anaconda/cloud/bioconda' sra-tools
# 如果你已经配置好国内镜像源，可以在下载时不指定镜像源，默认从配置的镜像源中搜索下载
conda install sra-tools
```

对于第 3 种可能，如果待安装的软件必须安装在当前**虚拟环境**，那就只能耐心等待 conda 处理好环境依赖了，不过出现这种情况时，没有绝对的处理方式，你也可以修改当前环境中的软件版本来减少环境依赖的冲突。最简单的方式是新创建一个虚拟环境，在其中安装最少的依赖，然后再安装待安装的软件。

```bash
# 创建一个全新的虚拟环境
conda create -n new_enviroment -y -vv
conda activate new_enviroment
# 安装待安装软件
conda install xxx
```

不过有些软件需要在创建一个全新的虚拟环境后，再在这个虚拟环境中安装一个软件依赖，这样才能顺利安装这个软件。这样说起来有点抽象，我们假设需要安装的软件是一个 R 包，那么我们就需要创建一个环境后再安装好指定版本 r-base，然后再安装 R 包。同理，如果我们需要安装的软件是一个 python 包，我们就需要在创建一个环境后在安装好指定版本的 python，然后再安装 python 包。

```bash
# 示例 1
conda create -n rpackage r-base==4.0.5 -y -vv
conda activate rpackage
conda install bioconductor-monocle==2.18.0 -y -vv

# 示例 2
# 使用 conda 创建虚拟环境，并指定 python 的版本为 3.7
conda create -n CellPhoneDB python=3.7 -y -vv
conda activate CellPhoneDB 
# 安装 CellPhoneDB，这个包目前使用 conda 安装会有问题，所以用 python 的包管理工具 pip 来安装
# 不过总体的思路与示例 1 是一致的
pip install CellPhoneDB -i https://pypi.douban.com/simple/
```

## 换源后不生效

清除软件搜索使用的本地索引，然后再次执行下载。

```bash
conda clean -i
```



*暂时遇到的问题以及解决方式就这些，有遇到其他常见问题的小伙伴欢迎给我反馈，我会补充到文档中，让它帮助到更多的人，感谢大家的支持！​*









