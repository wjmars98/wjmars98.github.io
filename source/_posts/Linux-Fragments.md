---
title: Linux Fragments
date: 2022-04-08 12:48:08
tags:
- linux

categories:
- Basic
---
This article is used to record some knowledge fragments when using linux.

<center>
        <img src="Linux-Fragments/linux-logo.png" width=80%>
</center>

<!-- more -->

# bin 和 sbin 的区别

/bin目录（binary）是二进制执行文件目录，主要用于具体应用

/sbin目录（system binary）是系统管理员专用的二进制代码存放目录，主要用于系统管理

bin是binary的缩写，是可执行的二进制文件。/bin里面一般是基本的，大家都要用的工具；sbin里面的s是system的意思，是供system administrator使用的工具。

> 在hadoop中，/bin 目录存放对Hadoop相关服务（HDFS, YARN）进行操作的脚本；/sbin 目录存放启动或停止Hadoop相关服务的脚本

# export的用法
export命令用于设置或显示环境变量。

在shell中执行程序时，shell会提供一组环境变量。export可新增，修改或删除环境变量，供后续执行的程序使用。

```shell
export [-fnp][变量名称]=[变量设置值]
 
参数说明：
 
-f 　代表[变量名称]中为函数名称。
-n 　删除指定的变量。变量实际上并未删除，只是不会输出到后续指令的执行环境中。
-p 　列出所有的shell赋予程序的环境变量

# example

# 将/tmp/hello的路径加入到PATH，从而可以在任何地方直接使用hello命令。
export PATH=$PATH:/tmp/hello
```

export设置环境变量是暂时的，只在本次登录中有效，可修改如下文件来使命令长久有效

 1. 修改profile文件：

 2. 修改自己home路径下的 ~/.bashrc 或 ~/.bash_profile ~/.zshrc文件：


