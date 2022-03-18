---
title: A Private Blog Built By Github + Hexo + Next
tags:
  - Hexo
  - Blog
categories: Blog
date: 2022-03-18 15:26:00
---



# 基于Github + Hexo + NexT 的私人博客搭建

## 1. 前言

​		度过了迷茫的半年，终于摸清楚了自己未来职业的方向，不再畏畏缩缩，要勇于去拼搏，去争取机会。在接下来的5年会是我未来非常重要的一段时光，实习、研究生、工作等等，每一步得需要万分的努力才能一步一个台阶的往上爬。所以我想创捷属于自己的blog，来记录自己未来几年的自己在技术、项目、职场等方面的一些心得与体会。之前也有类似的想法，但是经常就是做到一半中途而废。这次我是想认真的经营自己blog，不断的督促自己学习进步。同时blog也利于自己对过去经历进行记录与复盘，查漏补缺更进一步。

​		这个私人博客的搭建是基于Github Page创建最基础的个人静态网站，Hexo则是一个快速、简洁且高效的博客框架，利用Markdown进行文章的解析，NexT是其中的一种主题theme，其拓展性优秀，后期能基于该框架与主题进行个性化的修改。基于Github + Hexo + NexT模式的博客在管理方便，本地-远程简单部署的同时，也保证了博客网页的美观与整洁。

​		本文将从以下几个部分来记录该博客的搭建:

- 项目构建及其部署
- 配置文件功能解析
- 基于该框架主题的DIY
- 难点与收获



​		个人链接: 

>1.  [Mars' Github Home](https://github.com/wjmars98)
>
>2.  [Mars' Blog Home Page](https://wjmars98.github.io/) 



## 2. 项目构建及其部署

### 2.1 准备条件

​		该博客主要是利用Github为其每个用户提供的Github Pages服务，允许用户搭建一个静态网站。所以首先需要Github上构建名为:{username}.github.io的仓库，其名字必须由“.github.io”结尾。同时为了后续的操作，[需要配置本地与Github的ssh连接](https://docs.github.com/cn/authentication/connecting-to-github-with-ssh/about-ssh)。



<center>
    <img src=".\A-Private-Blog-Built-By-Github-Hexo-Next\build_repository.png" width=800 >
</center>





<center>
     <img src=".\A-Private-Blog-Built-By-Github-Hexo-Next\ssh-key.png" width=800 >
</center>











## 参考资料

> 1.  <u>[Hexo官方参考资料](https://hexo.io/zh-cn/)</u>
> 2. [ 崔庆才-利用 GitHub + Hexo + Next 从零搭建一个博客)](https://cuiqingcai.com/7625.html)
> 3. [Github的SSH连接](https://docs.github.com/cn/authentication/connecting-to-github-with-ssh/about-ssh)
> 4. 



