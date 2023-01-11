---
title: jupyter使用技巧
date: 2023-01-10 22:36:57
tags: [jupyter]
---

## jupyter识别kernel

jupyter 是借助 kernel 来运行程序的，在创建文件的时候，我们可以选择已经安装的kernel来运行文件。

如：[r-irkernel 1.3.1](https://anaconda.org/conda-forge/r-irkernel)、[ipykernel 6.20.1](https://anaconda.org/conda-forge/ipykernel)。

kernel 可以调用当前环境中安装的解释器（R，python）来执行程序。

```bash
conda install r-base=4.0.1 -y -vv
conda install  r-irkernel -y -vv
# 如果使用 jupyter lab 的话还需要安装 nodejs 和 text-shortcuts 插件
conda install nodejs -y -vv
jupyter labextension install @techrah/text-shortcuts

conda install python=3.11 -y -vv
conda install ipykernel -y -vv
```

## 重启Jupyter

1. 杀死之前运行的 jupyter 进程

```bash
ps -ux | grep jupyter | grep -v grep | awk '{print $2}' | xargs kill -9
```

2. 启动 jupyter：在Linux命令行里执行命令（如果 jupyter 安装在某个虚拟环境中，需要先激活虚拟环境）

```bash
# 如果 jupyter 安装在 conda 的 jupyter 环境中，需要使用下面这条命令激活虚拟环境，然后再运行 jupyter
conda activate jupyter
# 后台运行 jupyter notebook 的方式
nohup jupyter notebook >~/jupyter.log 2>&1 &

# 后台运行 jupyter lab 的方式
nohup jupyter lab >~/jupyterlab.log 2>&1 &
```

### jupyter使用conda的多环境

### 方法1

如果需要在jupyter中使用conda多环境，需要安装nb_conda插件，在jupyter环境下安装即可。

```Shell
conda activate jupyter

conda install nb_conda -y -vv
```

然后重启jupyter，必须重启，否则点击 Conda 栏会报错。

### 方法2

想要使用哪个环境，就在哪个环境安装ipykernel（不需要重启）

```Shell
# 如我想要在jupyter中使用sradownload的环境，其中安装了numpy作为演示
conda activate sradownload

conda install ipykernel -y -vv

# 如果安装 ipykernel 后 jupyter 没有识别到，可以在安装 jupyter 的 conda 环境中执行类似下面的命令
# 这个命令会让 jupyter 识别到虚拟环境 sradownload, 并在jupyter 中显示为 Python [conda env:sradownload]
python -m ipykernel install --user --name sradownload --display-name "Python [conda env:sradownload]"
```



