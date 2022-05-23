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

# Background
To be more specific, I would love to share a software developing program situation appeared in my program developing process.

When I tried to develop a scrapy project to crawl some data on the imdb website, which not only included the titles and release time, rating and other text data, but also contained the images data like movie posters, I found the a single item contains both.

To solve this problem, of course, we can try to create different spiders which can crawl text data while the other can crawl image data. However, basing on our observation, this data can be crawled by only one spider if we can assemble a functional pipeline module.  Comparing to the first solution, this approach has several advantages:

- High Efficiency
- Code Modularization
- Easy to Debug

# Example
## Crawl Requirements
Firstly, let me to show you the project requirement  as following.

Target crawk website: [imd: The Batman](https://www.imdb.com/title/tt1877830)

<center>
        <img src="Scrapy-Manage-Multiple-Pipelines/imdb-the-batman.jpg", width=80%>
</center>

Target crawl text info:

- Text: title, rating, description

- Image: image

## Understand Pipeline Module

According to [scrapy document](https://docs.scrapy.org/en/latest/topics/item-pipeline.html), the pipeline is briefly descriped as: 
> Item has been scraped by a spider, it is sent to the Item Pipeline which processes it through several components that are executed sequentially.

As mentioned above, pipeline is designed to process the item data from spiders. And to achieve the designated function, we can try to assemble a number of pipelines in a specific order which is the key to  make a pipeline module to implement complex functions.
 
 


# Reference

[1. Scrapy at a glance](https://docs.scrapy.org/en/latest/intro/overview.html)

