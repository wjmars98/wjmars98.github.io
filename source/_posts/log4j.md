---
title: Log4j
date: 2022-04-13 17:31:40
tags:
- Log4j
categories:
- Basic
---

Apache Log4j是一个基于Java的日志记录工具

<center>
        <img src="./log4j/log4j_logo.jpg" src=80%>
</center>

<!--more-->

Log4j是一种非常流行的日志框架。

Log4j是一个组件化设计的日志系统，它的架构大致如下：

<center>
                <img src="log4j/log4j_structure.jpg", width=80%>
</center>

# log4j 结构 

## appender

使用Log4j输出一条日志时，Log4j自动通过不同的Appender把同一条日志输出到不同的目的地。例如：

console：输出到屏幕；
file：输出到文件；
socket：通过网络输出到远程计算机；
jdbc：输出到数据库

## filter

通过Filter来过滤哪些log需要被输出，哪些log不需要被输出。

其中，存在8个日志级别，优先级从高到低依次为：OFF、FATAL、ERROR、WARN、INFO、DEBUG、TRACE、 ALL。

## layout
通过Layout来格式化日志信息，例如，自动添加日期、时间、方法名称等信息。

# log4j 使用
上述结构虽然复杂，但我们在实际使用的时候，并不需要关心Log4j的API，而是通过配置文件来配置它。

## log4j 配置
以xml配置为例，使用Log4j的时候，我们把一个log4j2.xml的文件放到classpath下就可以让Log4j读取配置文件并按照我们的配置来输出日志。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration>
	<Properties>
        <!-- 定义日志格式 -->
		<Property name="log.pattern">%d{MM-dd HH:mm:ss.SSS} [%t] %-5level %logger{36}%n%msg%n%n</Property>
        <!-- 定义文件名变量 -->
		<Property name="file.err.filename">log/err.log</Property>
		<Property name="file.err.pattern">log/err.%i.log.gz</Property>
	</Properties>
    <!-- 定义Appender，即目的地 -->
	<Appenders>
        <!-- 定义输出到屏幕 -->
		<Console name="console" target="SYSTEM_OUT">
            <!-- 日志格式引用上面定义的log.pattern -->
			<PatternLayout pattern="${log.pattern}" />
		</Console>
        <!-- 定义输出到文件,文件名引用上面定义的file.err.filename -->
		<RollingFile name="err" bufferedIO="true" fileName="${file.err.filename}" filePattern="${file.err.pattern}">
			<PatternLayout pattern="${log.pattern}" />
			<Policies>
                <!-- 根据文件大小自动切割日志 -->
				<SizeBasedTriggeringPolicy size="1 MB" />
			</Policies>
            <!-- 保留最近10份 -->
			<DefaultRolloverStrategy max="10" />
		</RollingFile>
	</Appenders>
	<Loggers>
		<Root level="info">
            <!-- 对info级别的日志，输出到console -->
			<AppenderRef ref="console" level="info" />
            <!-- 对error级别的日志，输出到err，即上面定义的RollingFile -->
			<AppenderRef ref="err" level="error" />
		</Root>
	</Loggers>
</Configuration>
```
# 参考
1. [使用Log4j](https://www.liaoxuefeng.com/wiki/1252599548343744/1264739436350112)