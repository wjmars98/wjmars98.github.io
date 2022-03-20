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
- Mysql
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
## 1.4 集群资源规划
该项目出于学习目的，比较腾讯云、阿里云、华为云等云服务，选择租用腾讯云的高性能云服务器,由于我们选择同一子网下的三台机器，所以我们只需使用节点的内网ip即可，并且保证了数据传输速度。  
<img src="./Ripple-The-News-Real-Time-Heat-Analysis-Platform/cloud_machine.png" width=600 >
三台服务器相关资源的部署规划如图所示:
<img src="./Ripple-The-News-Real-Time-Heat-Analysis-Platform/cluster_resources.png" width=600 >

