---
title: Ripple--The News Real Time Heat Analysis Platform
date: 2022-03-20 02:38:36
tags:
- Hadoop
- Zookepper
- Flume
- Kafka
- Hive
- Hbase
- Spark
- Hue
categories: 
  - Private Projects
---
Ripple 该平台实现对当前新闻网舆论热点事件的实时可视化分析，主要在[B站:新闻网大数据实时分析可视化系统](https://www.bilibili.com/video/BV1mK411T7WY?p=1)这一项目基础进行进一步改造，使用框架组件包括：Hadoop、Zookeeper、Flume、Kafka、Hive、HBase、Cloudera HUE、Spark、Echart等。

本文主要Ripple项目的业务分析、技术造型、集群规划、安装部署、整合集成与开发和可视化设计等部分组成。项目目标为充分理解搭建过程中涉及的大数据组件，提升个人相关开发能力。

<!-- more -->
# 1. 项目需求分析、架构设计、数据流程设计
## 1.1 需求分析
1. 捕获用户浏览的日志信息(TB)
2. 实时分析前20名流量最高的新闻话题
3. 实时统计当前线上已曝光的新闻话题
4. 统计哪些时段用户浏览量最高
5. 报表

## 1.2 架构设计
<img src="./Ripple-The-News-Real-Time-Heat-Analysis-Platform/project_structure.png" width=600 >

## 1.3 数据流程
<img src="./Ripple-The-News-Real-Time-Heat-Analysis-Platform/data_flow.png" width=600 >

# 2. 环境配置
## 2.1 集群资源规划
该项目出于学习目的，比较腾讯云、阿里云、华为云等云服务，选择租用腾讯云的高性能云服务器,由于我们选择同一子网下的三台机器，所以我们只需使用节点的内网ip即可，并且保证了数据传输速度。  
<img src="./Ripple-The-News-Real-Time-Heat-Analysis-Platform/cloud_machine.png" width=600 >

三台服务器相关资源的部署规划如图所示:
<img src="./Ripple-The-News-Real-Time-Heat-Analysis-Platform/cluster_resources.png" width=600 >

<br>

为了方便三台云服务器间的数据传输与登录，需要设计三台云服务器间的ssh免密登录，其原理为将每台主机authorized_keys文件里面包含的主机（ssh密钥），该主机都能无密码登录，所以只要每台主机的authorized_keys文件里面都放入其他主机（需要无密码登录的主机）的ssh密钥即可,参考[Hadoop集群配置免密SSH登录方法](https://www.cnblogs.com/shireenlee4testing/p/10366061.html)。

完成ssh免密登录之后，由于ip地址相对难以记忆，通过修改/etc/hosts中的映射关系，这样能够方便再服务期间传输文件
```shell
# 利用如下指令,在hosts末尾中添加ip映射
vi /etc/hosts
```
<img src="./Ripple-The-News-Real-Time-Heat-Analysis-Platform/ssh.png" width=400 >

<br>


## 2.2 Hadoop 搭建

首先，根据教程，再/opt文件夹下文件树为：
```shell
|-- opt # 主要文件夹
|   |-- data # 存放数据
|   |-- modules # haddop
|   |-- softwares # 相关软件下载包
|   |-- tool # 工具插件
|
```
在[A.hadoop资源下载](https://archive.apache.org/dist)中，-> hadoop -> core ->   hadoop-2.6.5.tar.gz，下载相关资源，并下载在software，最终解压至/opt/modules/，重命名为hadoop。

下载相关jdk也安装在/opt/modules中，配置/etc/profile环境变量。对于hadoop，有几个关键文件需要配置:

### 2.2.1 core-site.xml
路径: /opt/modules/hadoop/etc/hadoop

功能:  配置集群全局参数属性，用于定义系统级别的参数，如HDFS URL 、Hadoop的临时目录等

<img src="./Ripple-The-News-Real-Time-Heat-Analysis-Platform/core-site.png" width=400 >


### 2.2.2 hdfs-site.xml
路径: /opt/modules/hadoop/etc/hadoop/hdfs-site.xml

功能: 配置HDFS组件的属性，如名称节点和数据节点的存放位置、文件副本的个数、文件的读取权限等

<img src="./Ripple-The-News-Real-Time-Heat-Analysis-Platform/hdfs-site.png" width=400 >


### 2.2.3 mapred-site.xml
路径: /opt/modules/hadoop/etc/hadoop/mapred-site.xml

功能：配置map-reduce组件的属性，包括JobHistory Server 和应用程序参数两部分，如reduce任务的默认个数、任务所能够使用内存的默认上下限等

<img src="./Ripple-The-News-Real-Time-Heat-Analysis-Platform/mapred-site.png" width=400 >


### 2.2.4 yarn-site.xml
路径: /opt/modules/hadoop/etc/hadoop/yarn-site.xml

功能: 集群资源管理系统参数，配置ResourceManager ，nodeManager的通信端口，web监控端口等

<img src="./Ripple-The-News-Real-Time-Heat-Analysis-Platform/yarn-site.png" width=400 >

### 2.2.5 hadoop-env.xml
路径: /opt/modules/hadoop/etc/hadoop/haddop-env.sh

功能: hadoop运行环境,用来定义hadoop运行环境相关的配置信息

<img src="./Ripple-The-News-Real-Time-Heat-Analysis-Platform/hadoop-env.png" width=400 >

## 2.3 启动集群

**未完待续 | To be continued**


# 附录A：Problem

# 附录B：参考网站
1. [B站:新闻网大数据实时分析可视化系统](https://www.bilibili.com/video/BV1mK411T7WY?p=1)
2. [Hadoop官方文档](https://hadoop.apache.org/docs/r2.6.5/)
3. [A.hadoop资源下载](https://archive.apache.org/dist)
4. [B.hadoop资源下载](http://archive.cloudera.com/cdh5)



