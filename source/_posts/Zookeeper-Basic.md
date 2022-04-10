---
title: Zookeeper Basic
date: 2022-04-10 00:59:56
tags:
- Zookeeper
categories:
- Big Data
---
ZooKeeper是一个分布式、开源的分布式应用协调服务。它公开了一组简单的原语，分布式应用程序可以在此基础上构建，以实现同步、配置维护、组和命名等更高级别的服务。它的设计是易于编程的，并使用了一个数据模型，其样式类似于熟悉的文件系统的目录树结构。它在Java中运行，并且有Java和C的绑定。

众所周知，协调服务很难做好。它们特别容易出现竞争条件和死锁等错误。ZooKeeper背后的动机是为了减轻分布式应用从头开始实现协调服务的责任。

<center>
        <img src="./Zookeeper-Basic/Apache_ZooKeeper_logo.svg.png" width=80%>
</center>

<!--more-->