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

​		该博客主要是利用Github为其每个用户提供的Github Pages服务，允许用户搭建一个静态网站。所以首先需要Github上构建名为:{username}.github.io的仓库，其名字必须由“.github.io”结尾。同时为了后续的操作便利，[需要配置本地与Github的ssh连接](https://docs.github.com/cn/authentication/connecting-to-github-with-ssh/about-ssh)。

​		同时还需安装Node.js，Hexo。

```shell
# node.js
# download from https://nodejs.org/zh-cn/download/

# Hexo 安装
npm install -g hexo-cli
```



<center>
    <img src="./A-Private-Blog-Built-By-Github-Hexo-Next/build_repository.png" width=600 >
</center>



<center>
     <img src="./A-Private-Blog-Built-By-Github-Hexo-Next/ssh-key.png" width=600 >
</center>



### 2.2 项目初始及本地搭建



​		首先, 需要创建项目，利用指令

```shell
# hexo init {name}
# 我的项目名为wjmars98
hexo init wjmars98
```

在wjmars98文件夹下面出现Hexo的初始化文件，各个文件的具体细节下一章再展开。

<center>
     <img src="./A-Private-Blog-Built-By-Github-Hexo-Next/file_structure.png" width=600 >
</center>

​		第二，需要将Hexo编译成HTML文件，调用指令

```shell
# 编译形成HTML文件
hexo generate
```

输出结果里面包含了 js、css、font 等内容，处在了项目根目录下的 public 文件夹下面，随后利用Hexo提供的Server服务，将其在本地运行起来

```html
# 启动hexo服务器
hexo server
```

随后可以在本地4000端口查看博客站点，如下所示,其中图例是已经选用next的情况。



<center>
     <img src="./A-Private-Blog-Built-By-Github-Hexo-Next/hexo_server.png" width=600 >
</center>



<center>
     <img src="./A-Private-Blog-Built-By-Github-Hexo-Next/localhost.png" width=600 >
</center>



### 2.3 项目部在Github Page上的部署

​		为了便利后面的操作，我们将部署的shell脚本写在 *deploy.sh* 的脚本文件上

``` shell
# deploy.sh 文件
hexo clean
hexo generate
hexo deploy
```

利用 *sh deploy.sh* 指令就能完成部署操作。



​		在部署之前，我们还需要修改部署文件细节。打开根目录下的 _config.yml 文件，找到 Deployment 这个地方，把刚才新建的 Repository 的地址贴过来，然后指定分支为 master 分支，最终修改为如下内容：

``` shell
# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type: git
  # 替换成个人github上的git地址
  repo: {git repo ssh address}
  branch: master
```

还需安装支持 Git 的部署插件，名字叫做 hexo-deployer-git，然后才能顺利部署到Github上

``` shell
npm install hexo-deployer-git --save

# 如果不按照会报错
# Deployer not found: git
```



## 参考资料

> 1.  <u>[Hexo官方参考资料](https://hexo.io/zh-cn/)</u>
> 2. [崔庆才-利用 GitHub + Hexo + Next 从零搭建一个博客)](https://cuiqingcai.com/7625.html)
> 3. [Github的SSH连接](https://docs.github.com/cn/authentication/connecting-to-github-with-ssh/about-ssh)
> 4. [Hexo 图片部署](https://www.npmjs.com/package/hexo-asset-image-for-hexo5)



