---
title: 'Scrapy: Manage Multiple Pipelines'
date: 2022-05-10 20:14:34
tags:
- scrapy

categories:
- Big Data
---
It's a common situation that managing multiple pipelines are required  when we try to develop some scrapy projects and decide the order of the pipelines. 

What's worse, there may be not only one spider in the porject, and each  spider own different requirements to the project pipelines. And there is no doubt that **effective management of pipelines can greatly improve our efficiency** which is also the purpose of this article.


<center>
    <img src="Scrapy-Manage-Multiple-Pipelines/logo.png", width=80%>
</center>
<!--more-->

To be more specific, I would love to share a situation appeared in my program developing process.

When I tried to develop a scrapy project to crawl some data on the imdb website, which not only included the titles and release time, rating and other text data, but also contained the images data like movie posters, I found the a single item contains both.

Of course, we can create different type of pipeline and appoint each single pipeline to statisfy each single need. However, our code will be real complex and redundancy in this method. It will be a better way to assemble some pipelines into a pipeline moudle in specified order. Comparing to the first method, this approach has several advantages:

- High Efficiency
- Code Modularization
- Easy to Debug

# Pipeline
## 

