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
