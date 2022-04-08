---
title: Yarn
date: 2022-04-08 10:32:25
tags:
    - yarn
categories: 
  - Big Data
---

YARN is an open source Apache project that stands for “Yet Another Resource Negotiator”. It is a Hadoop cluster manager that is responsible for allocating resources (such as cpu, memory, disk and network), for scheduling & monitoring jobs across the Hadoop cluster.

YARN是Apache的一个开源项目，它的意思是“另一个资源协商者”。它是一个Hadoop集群管理器，负责分配资源(如cpu、内存、磁盘和网络)，用于跨Hadoop集群调度和监控作业。

<center>
        <img src="./Yarn/yarn_logo.png", width=80%>
</center>
<!-- more -->

# What is yarn
YARN是Apache的一个开源项目，它的意思是“另一个资源协商者”。它是一个Hadoop集群管理器，负责分配资源(如cpu、内存、磁盘和网络)，用于跨Hadoop集群调度和监控作业。

早期版本的Hadoop只支持在Hadoop集群上运行MapReduce任务;然而，YARN的出现也使得在Hadoop集群上运行其他大数据解决方案框架成为可能，比如Spark、Flink、Samza等。

YARN支持不同类型的工作负载，如流处理、批处理、图形处理和迭代处理。

# Yarn's Architecture
Apache YARN由两个主要组件组成:资源管理器和节点管理器。资源管理器每个集群一个，而节点管理器守护进程运行在所有工作节点上。

<center>
        <img src="./Yarn/yarn_architecture.jpg", width=80%,>
</center>

1. 资源管理器(Resource Manager)是一个守护进程，负责在集群中分配资源。它有两个主要组件，即**调度程序和应用程序管理器**。调度器负责根据内存和cpu需求跨集群调度应用程序。每个集群只有一个资源管理器。

2. 应用程序管理器(APP Manager)接受作业并创建特定的应用程序主程序，并在出现故障时重新启动它们。**Application Master负责处理Application的整个生命周期**，从资源协商、跟踪和监控作业状态开始。

3. 节点管理器(Node Manager)是运行在所有工作节点上的守护进程，在**机器级别管理资源**。节点管理器定义节点上可用的资源，并跟踪其使用情况。它还跟踪节点的运行状况，如果**发现不正常，则将其通信给资源管理器**。Node Manager与资源管理器通信，发送关于报告使用情况的定期报告，并与应用程序主机协调生成用于任务执行的JVM。

# Yarn Scheduler
YARN 支持三种调度策略，即 FIFO、Capacity 和 Fair Scheduling，它们决定了传入作业的调度或优先级。

## FIFO Scheduler
在 FIFO 调度器策略中，应用程序以“先进先出”的方式提供服务，但如果集群在多个用户之间共享，此策略可能会导致作业匮乏。所以，这个策略在共享集群中并不是最优的。默认情况下，YARN 始终设置为 FIFO 策略。

## Capacity Scheduler:
在容量调度程序中，不同的组织共享他们的 Hadoop 集群以最大限度地利用集群。尽管组织正在共享他们的集群，但容量调度程序可确保每个组织都获得所需的容量。

容量调度器(Capacity Scheduler)提供容量保证、弹性、基于资源的调度、优先级调度、多租户等等。我们必须在 conf/yarn-site.xml 文件中设置以下属性以在 YARN 中启用容量调度程序。

## Fair Scheduler:
公平调度策略(Fair Scheduler)确保所有正在运行的作业获得大致相等的资源份额（内存或 CPU）。

作业被划分为队列，资源在这些队列之间平均共享。它始终保证队列的最小份额，如果队列为空，则将多余的资源分配给在其他队列中运行的作业。我们还可以定义一组应用于提交的应用程序的规则，以便应用程序进入适当的队列以进行进一步处理.

# High Availability
在 Hadoop 2.4 之后，资源管理器以 Active/StandBy 模式工作，以提供容错和高可用性。

Standby Resource Manager始终跟踪活动资源管理器中发生的所有更改，并可以在出现故障时替换其位置。资源管理器与zookeeper密切合作，记录其状态，并决定在出现故障时哪个资源管理器应该处于活动状态。

<center>
        <img src="./Yarn/active_standby.png", width=80%>
</center>

故障转移从active mode 到 standby mode 可以手动进行，也可以自动进行。

## 手动转换与failover
当自动 *failover* 没有开启时，管理员需要手动将RM的状态转为Active。为了完成failover，首先需要将Active-RM 转换为Standby，然后将Standby-RM 转换为Active。这些均可以通过 *yarn rmadmin* 命令完成。

## 自动failover
RMs可以配置一个内置的，基于 Zookeeper 的ActiveStandbyElector，用于决定哪个RM应该是Active的。当Active RM 出现故障下线，或者无法响应了，另一个RM会被自动推选为Active，并接管之后的工作。需要注意的是，这里没有必要像 HDFS HA 那样运行一个额外的ZKFC守护进程，因为ActiveStandbyElector 内置于RM，担任failure detector以及leader elector的角色，可以替代ZKFC守护进程

# Reference

[1. What is YARN? How Does it Work and Support Big Data Framework?](aegissofttech.com/articles/what-is-yarn-in-big-data.html)

[2. YARN High Availablity](https://www.cnblogs.com/zackstang/p/10812523.html)

[3. Apache Hadoop YARN](https://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-site/YARN.html)