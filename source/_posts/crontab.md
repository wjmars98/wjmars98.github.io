---
title: crontab
date: 2022-05-02 23:19:26
tags:
- linux
categories:
- Basic
---

Linux下的任务调度分为两类：系统任务调度和用户任务调度。Linux系统任务是由 cron (crond) 这个系统服务来控制的，这个系统服务是默认启动的。用户自己设置的计划任务则使用crontab 命令，可以实现某一任务在指定的时间运行。
<!--more-->

Linux下的任务调度分为两类：系统任务调度和用户任务调度。Linux系统任务是由 cron (crond) 这个系统服务来控制的，这个系统服务是默认启动的。用户自己设置的计划任务则使用crontab 命令。

# crontab配置文件
在centos系统中，通过调用
```shell
# 查看配置指令
cat /etc/crontab

# 能够看到如下解释
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root
HOME=/
# For details see man 4 crontabs
# Example of job definition:
# .---------------- minute (0 - 59)
# | .------------- hour (0 - 23)
# | | .---------- day of month (1 - 31)
# | | | .------- month (1 - 12) OR jan,feb,mar,apr ...
# | | | | .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# | | | | |
# * * * * * user-name command to be executed
```

# crontab文件含义
前四行是用来配置crond任务运行的环境变量

1. 第一行SHELL变量指定了系统要使用哪个shell，这里是bash；

2. 第二行PATH变量指定了系统执行命令的路径；

3. 第三行MAILTO变量指定了crond的任务执行信息将通过电子邮件发送给root用户，如果MAILTO变量的值为空，则表示不发送任务执行信息给用户；

4. 第四行的HOME变量指定了在执行命令或者脚本时使用的主目录。

<center>
    <img src="./crontab/crontab.png", width=80%>
</center>

在以上各个字段中，还可以使用以下特殊字符：

"\*"代表所有的取值范围内的数字，如月份字段为*，则表示1到12个月；

"/"代表每一定时间间隔的意思，如分钟字段为*/10，表示每10分钟执行1次。

"-"代表从某个区间范围，是闭区间。如“2-5”表示“2,3,4,5”，小时字段中0-23/2表示在0~23点范围内每2个小时执行一次。

","分散的数字（不一定连续），如1,2,3,4,7,9。

注：由于各个地方每周第一天不一样，因此Sunday=0（第一天）或Sunday=7（最后1天）。

# crontab命令详解
```shell
crontab [-u user] file
crontab [ -u user ] [ -i ] { -e | -l | -r }
```
- -u user：用于设定某个用户的crontab服务；
- file: file为命令文件名，表示将file作为crontab的任务列表文件并载入crontab；
- -e：编辑某个用户的crontab文件内容，如不指定用户则表示当前用户；
- -l：显示某个用户的crontab文件内容，如不指定用户则表示当前用户；
- -r：从/var/spool/cron目录中删除某个用户的crontab文件。
- -i：在删除用户的crontab文件时给确认提示。

# 注意点

1. crontab有2种编辑方式：直接编辑/etc/crontab文件与
crontab –e，其中/etc/crontab里的计划任务是系统中的计划任务，而用户的计划任务需要通过crontab –e来编辑；

2. 每次编辑完某个用户的cron设置后，cron自动在/var/spool/cron下生成一个与此用户同名的文件，此用户的cron信息都记录在这个文件中，这个文件是不可以直接编辑的，只可以用crontab -e 来编辑。

3. crontab中的command尽量使用绝对路径，否则会经常因为路径错误导致任务无法执行。

4. 新创建的cron job不会马上执行，至少要等2分钟才能执行，可从起cron来立即执行。

5. %在crontab文件中表示“换行”，因此假如脚本或命令含有%,需要使用\%来进行转义。

# 参考：
1. [crontab用法与实例](https://www.linuxprobe.com/how-to-crontab.html)
2. [crontab(5) — Linux manual page](https://man7.org/linux/man-pages/man5/crontab.5.html)