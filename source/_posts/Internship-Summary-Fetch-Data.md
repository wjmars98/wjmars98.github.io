---
title: Internship Summary Fetch Data
date: 2022-04-14 22:53:34
tags:
- intership
- http
categories:
- Intership Summary
---
在实习的前两个星期，感觉最常接触的一类任务就是**数据的拉取**以及api的调用，本文也是对这个part的内容、方法以及遇到的问题进行一个记录。

 **To be continued ...**
<center>
        <img src="Internship-Summary-Fetch-Data/fd_logo.jpg", width=80%>
</center>
<!--more-->


在向服务器发送拉取数据请求（比如asa，bigo等等），大多都是通过https request的请求实现。其中最常使用的method为GET 与POST,但是当需要我去解释http request原理以及两个方法区别的时候，竟会一时语塞，所以相信此时的记录对后期的工作会有极大的帮助。

# 请求报文
一条请求信息主要四个部分组成：
1. 请求行 （request line）
2. 请求头部（header）
3. 空行（填充至头部区域结尾）
4. 请求数据（Optionally a message-body）

<center>
        <img src="Internship-Summary-Fetch-Data/http报文.png" width=80%>
</center>

``` http
POST /user HTTP/1.1                       // 请求行
Host: www.user.com
Content-Type: application/x-www-form-urlencoded
Connection: Keep-Alive
User-agent: Mozilla/5.0.                  // 以上是请求头
（此处必须有一空行 |                         // 空行分割header和请求内容 
name=world                                // 请求体(可选，如get请求时可选)
```
## request line
请求行由方法token开头，伴随着请求url，协议版本，以换行符，这几个部分由空格隔开。

## Request Method
请求方法指示要对给定 Request-URI 标识的资源执行的方法。

请求方法比较多：GET、POST、HEAD、PUT、DELETE、OPTIONS、TRACE、CONNECT，其中最常用的是GET和POST。

- GET： 使用 GET 的请求应该只检索数据，并且对数据没有其他影响。传递参数长度受限制，因为传递的参数是直接表示在地址栏中，而特定浏览器和服务器对url的长度是有限制的。GET**不适合用来传递私密数据**，也不适合拿来传递大量数据。

- POST：POST把传递的数据封装在HTTP请求数据中，以名称/值的形式出现，可以传输大量数据，对数据量没有限制，也不会显示在URL中。

[more request methods](https://www.tutorialspoint.com/http/http_requests.htm
)

## Request-URI
最常用的指定 URI 的形式：
```html
Request-URI = "*" | absoluteURI | abs_path | authority
```
请求头部由关键字/值对组成，每行一对。
