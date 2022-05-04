---
title: imdb-scrapy
date: 2022-04-22 23:18:14
tags:
- scrapy

categories:
- Projects
---

在有了一定的scrapy基础之后，便可以尝试将scrapy的知识应用起来，做一些小项目。本文将介绍一个基于scrapy的imdb数据爬取项目，其主要功能有以下三点：

- imdb最受欢迎榜单数据，新片榜单数据爬取

- md5文件监视与crontab定时运行

- 报告邮件形式发送

Github入口： [imdb-scrapy：基于scrapy的imdb数据爬取项目](https://github.com/wjmars98/imdb-scrapy)

<center>
        <img src="imdb-scrapy/logo.jpg", width=80%>
</center>

<!--more-->
# 简介
在实习期间，流媒体部分的同事需要imdb相关的数据，这个任务最后落在了我的身上，正好这个项目与公司项目相对独立，不涉及保密协议的部分，所以我打算将这个项目放在自己的github上，深入自己对scrapy的理解，同时也丰富自己的工程经验。

Github入口： [imdb-scrapy：基于scrapy的imdb数据爬取项目](https://github.com/wjmars98/imdb-scrapy)

# 项目需求
## 爬取对象

**1. IMDB影片信息获取**
根据IMDB链接，获取IMDB页面信息供资讯站内容填充，所需信息如下(详见图片)：
例子：https://www.imdb.com/title/tt10048342/
- ID：10048342
- 影片标题
- IMDB评分
- 影片热度：popularity，对应图中302
- 影片描述
- 影片图片：封面图，尺寸(像素)：198*261，大小：≤50k
- 影片IMDB ID
更新频率：24小时/次

<center>
        <img src="imdb-scrapy/src1.png", width=80%>
</center>


**2. IMDB新片上映信息获取**
根据IMDB新片上映页面，获取影片信息供资讯站内容筛选参考，所需信息如下(详见图片)：
- 新片上映页面：https://www.imdb.com/calendar/
- 影片上映时间：包含年月日
- 影片名称：包含年份
- 影片热度：点击影片获取影片热度，如图③
- 影片IMDB ID
- 影片链接

更新频率：24小时/次
爬取条数：最近两个月的影片
<center>
        <img src="imdb-scrapy/src2.png", width=80%>
</center>

<center>
        <img src="imdb-scrapy/src3.png", width=80%>
</center>


**3. IMDB喜爱榜单信息获取**
根据IMDB喜爱榜单页面，获取影片信息供资讯站内容筛选参考，所需信息如下(详见图片)：
新片上映页面：https://www.imdb.com/chart/moviemeter/?ref_=nv_mv_mpm
- 排名
- 影片名称：包含年份
- IMDB 评分
- 影片IMDB ID
- 影片链接
- 影片热度：点击影片获取影片热度


更新频率：24小时/次
爬取条数：前100条
<center>
        <img src="imdb-scrapy/src4.png", width=80%>
</center>

## 报告输出格式
《IMDB新片上映信息获取》、《IMDB喜爱榜单信息获取》以csv格式导出，csv所要字段如表所示：
<center>
                <img src="imdb-scrapy/favourite-new.jpg", width=80%>
</center>
备注：

《IMDB新片上映信息获取》：https://www.imdb.com/calendar/

《IMDB喜爱榜单信息获取》：https://www.imdb.com/chart/moviemeter/

《爬取提供imdb-url-list》以csv格式导出，csv所要字段如表所示：
<center>
                <img src="imdb-scrapy/imdb-url-list.jpg", width=80%>
</center>

# 项目编写
## scrapy框架
<center>
                <img src="imdb-scrapy/structure.png", width=80%>
</center>


## 项目文件树
```
.
├── README.md
├── imdbSpider
│   ├── bin
│   │   ├── get_report.py
│   │   ├── lib_noti.py
│   │   └── spy_list.sh
│   ├── conf
│   │   └── list
│   │       ├── imdb-url-list
│   │       └── imdb-url-list.md5
│   ├── data
│   │   ├── favourite.csv
│   │   ├── list.csv
│   │   └── new.csv
│   ├── images
│   │   ├── full
│   │   └── thumbs
│   │       └── format
│   ├── imdbSpider
│   │   ├── __init__.py
│   │   ├── items.py
│   │   ├── middlewares.py
│   │   ├── pipelines.py
│   │   ├── settings.py
│   │   └── spiders
│   │       ├── __init__.py
│   │       ├── favourite.py
│   │       ├── list.py
│   │       └── new.py
│   ├── log
│   │   ├── spider.log
│   │   ├── spy-list.log
│   │   └── spy-profile.log
│   ├── run.sh
│   ├── scrapy.cfg
│   └── spy.sh
└── pic
    ├── project_structure.png
    ├── scrapy_logo.png
    ├── spider_structure.png
    └── structure.png
```

## 自动化部署与监视
### crontab 自动化部署
```imdb-scrapy```项目主要利用crontab来实现定时运行项目程序,服务器crontab代码样例如下所示。
```shell
# imdb-scrapy crontab profile
0 8 * * * cd /home/apps/wj/stream-media-pump/imdbSpider;/bin/sh /home/apps/wj/stream-media-pump/imdbSpider/run.sh > /home/apps/wj/stream-media-pump/imdbSpider/crontab-log.txt
```

crontab的详细配置可以查看：
[Mars' Blog crontab](https://wjmars98.github.io/2022/05/02/crontab/#more)


### md5文件数据监视
在imdb-scrapy项目中，存在对imdb-url-list文件进行监视的需求，当用户上传新的imdb-url-list时，服务器能够捕捉到数据改变，启动list 爬虫进行数爬取。

```imdb-scrapy```项目利用生成并定时比对指定文件的md5码来监视文件，如果文件更新，则进行爬取，并生成新的md5码。

监视shell 脚本储存于```imdbSpider/bin/spy-list.sh```中，如下所示。
```shell
#!/bin/sh
while true
do
{
  cd /path/to/imdbSpider
  # Using md5 to check whether the imdb-url-list changed.
  char=$(md5sum -c conf/list/imdb-url-list.md5 2>/dev/null|grep "OK"|wc -l)

  if [ $char -eq 1 ];then
    echo "yes"
  else
    echo "begin output list csv"

    # Fetch the new list data
    python -m scrapy crawl list

    # Path of the server which store the report.
    scp data/list.csv server:path
    python bin/get_report.py -r "list"

    # Update the imdb-url-list md5
    md5sum conf/list/imdb-url-list > conf/list/imdb-url-list.md5
  fi
  sleep 10
}

```

# 参考
[1. Mars' Blog](https://wjmars98.github.io/)

[2. 初窥Scrapy](https://scrapy-chs.readthedocs.io/zh_CN/0.24/intro/overview.html)

[3. imdb官网](https://www.imdb.com/)