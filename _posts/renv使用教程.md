---
title: renv使用教程
date: 2023-02-14 09:53:28
tags: [R包]
---

## 介绍

官网介绍：https://rstudio.github.io/renv/

renv 能够帮助我们创建一个私有包仓库，你也可以认为它是为 R 创建一个私有的 libpath。在这个 libpath 下安装的 R 包不受其他 libpath 的影响，在项目中使用 R 包也并不会受到其他 libpath 的干扰。

<!--more-->

```bash
# 在 R 的交互环境下输入以下命令查看 libpath
.libPaths()
```

renv 的好处:

1. **构建了一个独立的 R 包 libpath**；

2. 下载 R 包有缓存，安装失败后再次安装会使用上次已经下载的缓存，而不用再次下载；

3. 可以导出项目中使用的R包和版本；

4. 可以根据导出的 R 包镜像；

## 安装

```bash
if (!require("renv", quietly = TRUE)) {
  install.packages("renv")
}
```

## 使用

### 1.创建项目目录，项目目录不能为家目录，目录名可以自定义

```bash
dir.create("~/SCP_env", recursive = TRUE)
```

### 2.初始化项目，这一步会在项目目录中生成文件

如果你使用 rstudio-server 的话，下面的命令应该在 rstudio-server 的 "Console" 中执行，这样它会自动刷新 rstudio-server 并自动创建 R project。

```bash
# 项目名可以自定义
renv::init(project = "~/SCP_env", bare = TRUE, restart = TRUE)
```

### 3.激活项目进行使用

```bash
renv::activate(project = "~/SCP_env")
```

激活项目后，可以查看此时的 libpath，之后安装的 R 包都会保存在 libpath 对应的目录中。

```bash
.libPaths()
```

## 如何安装R包

{% post_link 如何安装R包 %}

# renv高级功能

## 1.导出指定libpath下的R包信息到lockfile中

```bash
# 这 3 个参数都有默认值，不用一一赋值
renv::snapshot(project, library, lockfile)

# 示例：将 SCP_env 项目下的多个 libpath 下的 R 包信息导出到 ~/SCP.lock 文件中
renv::snapshot(project="~/SCP_env", lockfile="~/SCP.lock")
# 示例：将 /home/txb/SCP_env/renv/library/R-4.2/x86_64-conda-linux-gnu 目录下的 R 包信息导出到 ~/SCP.lock 文件中
renv::snapshot(library="/home/txb/SCP_env/renv/library/R-4.2/x86_64-conda-linux-gnu", lockfile="~/SCP.lock")
# 示例：将 SCP_env 项目下的多个 libpath 下的 R 包信息导出到项目下 renv.lock 文件中
renv::snapshot(project="~/SCP_env")
```

## 2.根据lockfile将R包安装到某个libpath中

```bash
# 这 3 个参数都有默认值，不用一一赋值
renv::restore(project, library, lockfile)

# 示例：根据 lockfile 中记录的 R 包信息将 R 包安装在某个 libpath 中
renv::restore(library="/home/txb/test", lockfile="~/test.lock")
```

但项目不总是可重现的，详情可见官方解释：https://rstudio.github.io/renv/articles/renv.html#caveats

出现这种情况时需要手动处理某些安装失败的 R 包。（移除？使用其他方式安装？……）

restore 和 snapshot 的更多用法可以阅读他们的源码获得，以下是它们可以接收的参数以及默认参数。

```bash
restore(project = NULL, ..., library = NULL, lockfile = NULL, 
    packages = NULL, exclude = NULL, rebuild = FALSE, repos = NULL, 
    clean = FALSE, prompt = interactive())
    
snapshot(project = NULL, ..., library = NULL, lockfile = paths$lockfile(project = project)
```

## 3.禁用R包缓存，这样在安装R包时会从网上重新下载

通常来说这个设置是不需要的，如果 R 包有更新的版本，renv 会自动下载更新的版本来替换本地缓存。

```bash
renv::settings$use.cache(FALSE)
```

## 4.身份验证

[https://rstudio.github.io/renv/articles/renv.html#authentication](https://rstudio.github.io/renv/articles/renv.html#authentication)

## 5.设置不同项目之间共享R包缓存

[https://rstudio.github.io/renv/articles/renv.html#cache-location](https://rstudio.github.io/renv/articles/renv.html#cache-location)

关于renv的更多信息请查看官方介绍：[https://rstudio.github.io/renv/articles/renv.html](https://rstudio.github.io/renv/articles/renv.html)



