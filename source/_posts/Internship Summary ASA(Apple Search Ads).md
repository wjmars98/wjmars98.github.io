---
title: Internship Summary ASA(Apple Search Ads)
date: 2022-04-07 18:42:11
tags:
- intership
- ads
categories: 
  - Intership Summary
---
本文是为了记录与总结笔者在实习(前10天)中完成的第一个小项目——**ASA(Apple Search Ads)投放数据拉取**.
该项目大体由数据拉取、数据清洗、数据存储三个部分构成，笔者在这个项目中，目前实现了每天定时拉取应用数据，对其进行格式化处理，上传至Bigquery数据库中。

**TO BE CONTINUED ...**

<center>
    <img src="./Internship Summary ASA(Apple Search Ads)/asa_logo.jpg", width=80%>
</center>
<!--more-->

# What is ASA
Apple Search Ads helps people discover your app when they search on the App Store, matching customers with your app right when they’re looking.

苹果搜索广告（Apple Search Ads）是苹果官方设置在iphone、ipad AppStore中的竞价广告，它展示在特定关键词搜索结果首位（ipad为右上角），每次搜索仅展示一个广告位，用户可以通过点击广告下载对应的App。苹果搜索广告展示页面有特殊的标识——蓝色背景和”Ad“字样的图标。

<center>
    <img src="./Internship Summary ASA(Apple Search Ads)/ad_show.jpg", width=80%>
</center>

ASA一共有两种模式，basic/advanced,实习期间我主要运用的是advanced模式。

<center>
    <img src="./Internship Summary ASA(Apple Search Ads)/two_kinds.jpg", width=80%>
</center>

# 实习部分

# 拓展

## 苹果搜索广告的竞价模式
搜索广告能否在特定关键词下展示以及展示量级受到竞价系数的影响，影响竞价系数的因素有两个——**相关性**和**出价**。

竞价系数=相关性*CPT出价

影响App与投放关键词相关性的因素有以下两个方面：
**App元数据**。 App的名称、副标题、关键词、描述等文本信息会对App与关键词的相关性产生影响。

**用户反馈**。App在特定关键词下的广告从展示到点击、下载的转化率过低时，搜索广告系统会判断该关键与App的相关性较差，从而降低两者的相关性，减少广告展示量甚至不再展示。

苹果搜索广告采用竞价系统，最终按照点击（cost-per-taps）计费，也就是说只有用户点击广告时开发者才需要付出费用。点击的实际成本采用**次价密封竞价模式**，*是根据开发者出价和仅次于该出价的竞争对手出价计算得出*。

> 例如：关键词“games”某开发者出价为5美元/CPT,仅次于该出价的为3美元/CPT,最后成交价格高于3美元而低于5美元。也就是说开发者可以投标竞价而不用担心过度支付。

## 名词解释
### 账户体系

Account
账户，任何一个AppleID都可以注册成为搜索广告账户。账户下对投放应用没有限制，可以投放任意一款在线应用，也可以同时投放一款或多款应用。

Campaign Group
广告组，广告计划（Campaign）的集合。广告组能够开放查看或修改权限给其他苹果搜索广告账户，便于数据分享。每一个Campaign Group可以创建2000个Campaign。

Campaign
广告计划，一个计划对应一款App在一个国家的广告活动，一个广告计划内可以创建2000个Ad Group。

Ad Group
关键词组，是关键词的集合。一个关键词组中可以添加1000个关键词、2000个屏蔽词。开发者可以根据关键词的类型设置不同的词组，比如可以将竞品品牌词、行业词设置不同的词组，对比投放效果。

Keywords
关键词，竞价广告中最低的投放单元。开发者可针对每一个Campaign设定出价、匹配模式等等。

<center>
    <img src="./Internship Summary ASA(Apple Search Ads)/asa_structure.png" width=80%>
</center>

<center>
    <img src="./Internship Summary ASA(Apple Search Ads)/ASA账户结构说明.jpg", width=80%>
</center>

[*ps: ASA 账户结构说明*](https://zhuanlan.zhihu.com/p/150152235)
### 创建广告计划
App Name：应用名称

Storefront：广告投放地区

Budget：总预算，创建搜索广告时为一个App，也就是Campaign（广告计划）设置的预算金额。Budget在广告开启后，只能提高不能降低。

Daily Cap：每日预算，当花费达到每日预算上限时，广告就会在当天停止展示，如果Campaign仍有剩余预算，则会在第二天重新开始投放。每日预算是选填项，苹果搜索广告系统并不会严格执行每日预算，因此实际花费会高于或低于每日预算。

Devices：设备，可选择iphone、ipad或iphone and ipad

Default Max CPT Bid ：默认点击出价，这个价格将默认为广告组中任何关键词以及Search Match的出价。

CPA Goal：目标CPA，是开发者期望的每个获取量（cost-per-acquisition）的价格。目标CPA是选填项，这个数值苹果系统同样不会严格执行，甚至有时候实际CPA会大大高于目标CPA。

Search Match：搜索匹配，是指苹果系统自动为广告匹配搜索词的行为。搜索匹配是一项默认功能，它使用多种资源将广告与App Store上的相关搜索进行匹配，其中包括应用在App Store列表中的元数据，相同分类中类似应用的相关信息以及其他搜索数据。搜索匹配的CPT出价依据为默认最高CPT单价。

Recommended Keywords：推荐关键词，在创建Ad Group时，苹果搜索广告系统为应用推荐的关键词。推荐关键词数量不会超过50个。

Customer Types：受众类型，包括三个选项，All User、Have not downloaded the app、Have downloaded my other apps

Gender：性别，可选择male、famale或all。

Age range：年龄，搜索广告不会向13岁及以下的人群展示广告，年龄最低可选18岁，最高为65+。

Locations：位置，搜索广告支持位置细分，可以针对特定的州或城市投放广告。

Negative Keywords：屏蔽词，屏蔽词可以确保广告不会针对特定关键词展示。在搜索广告中，有两个层级可以添加屏蔽词——Campaign和Ad Group。 屏蔽词可以帮助开发者控制成本并提高广告系列的效率。

Exact Match/Broad Match：精确匹配/广泛匹配。

精确匹配包含四种匹配方式，即原型、单复数、各种形态、拼写错误，开发者无需单独添加这几种形态的关键词，广告也能够匹配到这些关键词，这种方式能够最大限度的控制可能展示广告的搜索内容，造成广告展示量降低，但点击率（TTR）和转化率（CR）可能会提高。在关键词中，添加有双括号的[keyword]的关键词采用的是精确匹配。

### 报表
CPT：Cost-Per-Tap，是搜索广告的计费模式，即广告定价是按照点击数量收取费用。

Impressions：展示量

Taps：点击量

Conversions：获取（安装）量，也可理解为下载量。New Downloads是指首次下载该款App的新用户。Redownloads是指当用户下载某款App后，删除该App并在App Store上点击苹果搜索广告后再次下载同一App，或将该App下载到其他设备时所产生的下载量。LAT是指 Limit Ad Tracking限制广告追踪，开启LAT的设备将不会接收到广告或对其活动进行跟踪。LAT On Conversions来自已启用LAT的用户。LAT Off Conversions来自未在其设备上启用LAT的用户的安装。

CR（Conversion Rate）：下载转化率，下载量/点击量

TTR（Tap-Through Rate）：点击转化率，点击量/下载量

Avg CPT：平均CPT单价

Avg CPA：平均CPA单价

Search Term：搜索项目，是广告展示、点击或下载量的详细来源，会统计到下载量来自哪个关键词，这里的关键词不是指投放设置的关键词，而是指用户看到并点击广告之前，搜索的关键词。

Match Source：匹配来源，是指搜索项目的来源。匹配来源主要有两种——Keywords、Search Match：Keywords是指搜索项目来源于添加关键词的广泛或精确匹配形式；Search Match是指搜索项目来源于系统自动匹配出的关键词。

Low volume terms：低量，这意味着这些数据低于Apple的隐私权阈值，例如搜索词必须至少达到10词展示，否则搜索词报表中会显示“低量”值。

User withheld：用户保留，如果广告用户在其设备上启用了“显示广告跟踪”或停用了位置服务时，可能会在性别、年龄和位置的报表中看到用户保留。

CPI（cost-per-install）：每个下载（安装）的费用，即按安装付费。

Maximum Cost-Per-Install (CPI)：愿意为每个安装的应用支付的最高金额。 实际CPI永远不会超过这个金额。

Monthly Budget：每月预算。 搜索广告基础版每个App每月最高预算为5000美元。月预算可以随时更改，直至最高金额。需要注意的是，预算增加会立即生效，减少将在下个自然月生效。

# 参考
[1. 官方网站](https://searchads.apple.com/advanced)
[2. 值得收藏!Apple Search Ads专有名词解释](https://zhuanlan.zhihu.com/p/42119163)
[3. ASA 账户结构说明](https://zhuanlan.zhihu.com/p/150152235)