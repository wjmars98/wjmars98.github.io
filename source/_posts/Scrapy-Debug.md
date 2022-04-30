---
title: Scrapy——DebuggingSpiders
date: 2022-04-28 15:03:10
tags:
 - scrapy
 
 categories:
- Big Data
---
在使用scrapy的时候，由于不能像平常一样对代码进行调试，花费了大量的时间在scrapy运行的等待上，每次溯源去寻找问题都非常麻烦。后来发现scrapy也有属于自己的调试方法，也用此文来记录学习一下scrapy的调试知识。
<!--more-->

考虑下面的spider:
```python
import scrapy
from myproject.items import MyItem

class MySpider(scrapy.Spider):
    name = 'myspider'
    start_urls = (
        'http://example.com/page1',
        'http://example.com/page2',
        )

    def parse(self, response):
        # collect `item_urls`
        for item_url in item_urls:
            yield scrapy.Request(item_url, self.parse_item)

    def parse_item(self, response):
        item = MyItem()
        # populate `item` fields
        # and extract item_details_url
        yield scrapy.Request(item_details_url, self.parse_details, meta={'item': item})

    def parse_details(self, response):
        item = response.meta['item']
        # populate more `item` fields
        return item
```
简单地说，该spider分析了两个包含item的页面(start_urls)。Item有详情页面， 所以我们使用 Request 的 meta 功能来传递已经部分获取的item。

# Scrapy Shell
Scrapy终端是一个交互终端，供您在未启动spider的情况下尝试及调试您的爬取代码。 其本意是用来测试提取数据的代码，不过您可以将其作为正常的Python终端，在上面测试任何的Python代码。

##  可用的快捷命令(shortcut)
- shelp( ) - 打印可用对象及快捷命令的帮助列表

- fetch(request_or_url) - 根据给定的请求(request)或URL获取一个新的response，并更新相关的对象

- view(response) - 在本机的**浏览器**打开给定的response。 其会在response的body中添加一个 <base> tag ，使得外部链接(例如图片及css)能正确显示。 

## 可用的Scrapy对象
Scrapy终端根据下载的页面会自动创建一些方便使用的对象，例如 Response 对象及 Selector 对象(对HTML及XML内容)。

这些对象有:

- crawler - 当前 Crawler 对象.

- spider - 处理URL的spider。 对当前URL没有处理的Spider时则为一个 Spider 对象。

- request - 最近获取到的页面的 Request 对象。 您可以使用 replace() 修改该request。或者 使用 fetch 快捷方式来获取新的request。

- response - 包含最近获取到的页面的 Response 对象。

- sel - 根据最近获取到的response构建的 Selector 对象。

- settings - 当前的 Scrapy settings

## 在spider中启动shell来查看response
有时您想在spider的某个位置中查看被处理的response， 以确认您期望的response到达特定位置。
这可以通过 ```scrapy.shell.inspect_response``` 函数来实现。

```python
import scrapy

class MySpider(scrapy.Spider):
    name = "myspider"
    start_urls = [
        "http://example.com",
        "http://example.org",
        "http://example.net",
    ]

    def parse(self, response):
        # We want to inspect one specific response.
        if ".org" in response.url:
            from scrapy.shell import inspect_response
            inspect_response(response, self)

        # Rest of parsing code.
```

当运行spider时，您将得到类似下列的输出:
```shell
2014-01-23 17:48:31-0400 [myspider] DEBUG: Crawled (200) <GET http://example.com> (referer: None)
2014-01-23 17:48:31-0400 [myspider] DEBUG: Crawled (200) <GET http://example.org> (referer: None)
[s] Available Scrapy objects:
[s]   crawler    <scrapy.crawler.Crawler object at 0x1e16b50>
...

>>> response.url
'http://example.org'

```
也就是运行到指定代码的时候，能够中断爬取，利用shell进行调用。
最后您可以点击Ctrl-D(Windows下Ctrl-Z)来退出终端，恢复爬取。

> 注意: 由于该终端屏蔽了Scrapy引擎，您在这个终端中不能使用 fetch 快捷命令(shortcut)。 当您离开终端时，spider会从其停下的地方恢复爬取，正如上面显示的那样。

# 参考
[1. Scrapy终端(Scrapy shell)](https://scrapy-chs.readthedocs.io/zh_CN/0.24/topics/shell.html)