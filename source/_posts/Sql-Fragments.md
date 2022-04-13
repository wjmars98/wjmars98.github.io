---
title: Sql-Fragments
date: 2022-04-11 11:35:01
tags:
- Sql

catgories:
- Fragments
---

This article is used for recording some study fragments in mysql.

<center>
        <img src="Sql-Fragments/sf-logo.png" width=60%>
</center>

<!--more-->

# 如何阅读长sql
[提升阅读sql的快感](https://cloud.tencent.com/developer/article/1559983)
- 通读，非技术性的通读
- 需要联想，也就是想象力
- 批评

1. 目前我用的是vscode来阅读sql代码。首先我会尝试用beautify sql这个vscode插件来美化sql代码，分出层级。
2. select -- from -- where 基本的sql逻辑，由外向内拆分，理解各层逻辑。给自己找问题，千万别一遍看完代码，什么都没留下来。
3.  理解sql的业务逻辑，你也可以在手边，画画流程图，帮助记忆。

> “在我们编程这个圈子，也有很多书，专讲这方面的。我给你推荐几本吧，《编程珠玑》，《CLR Via C#》, 尤其是 SQL 数据库方面，《数据库索引设计与优化》，《Oracle 优化日记》，《T-SQL Querying》,《T-SQL 性能调优秘籍-基于SQL Server 2012 窗口函数》”

# 阅读长sql时的整体感
经常会遇到一些比较长，且层级结果比较多的sql语句，在阅读的过程中，时常会发生读到一半忘掉前面的代码逻辑的情况。在阅读sql语句的时候，需要保持整体感。整体感的保持。
- 首先需要了解sql的输入与输出，明白这个sql的主要目的是什么。
- 其次，需要逐层拆分，理解层级表。要理解同一层的各个select -from-where检索出来的表，因为是同一层吗，在逻辑上是并列的，比较好理解。
- 最后，在对sql基本脉络了解之后，再根据需要去阅读代码，而非阅读所有代码。

如果以学习为目的，则能适当阅读所有代码。

# coalesce()

The COALESCE() function returns the first non-null value in a list.
返回列表中第一个非空元素

``` sql
# The COALESCE() function returns the first non-null value in a list.
COALESCE(val1, val2, ...., val_n)

```

# unnest
The UNNEST function takes an ARRAY and returns a table with a row for each element in the ARRAY.

unnest函数输入一个array数组，返回array数组中每一个元素作为行的表。

``` sql
# Syntax: UNNEST(ARRAY) [WITH OFFSET]
SELECT
  *
FROM
  UNNEST([1, 2, 2, 5, NULL]) AS unnest_column

# Result
# 1
# 2
# 2
# 5
# null


# 其中还有一个offset选项，为每一行提供了一个附加列，其中包含数组中每个元素的位置（从零开始）
SELECT
  *
FROM
  UNNEST([1, 2, 2, 5, NULL]) AS unnest_column WITH OFFSET AS `offset`

```

# cast
CAST函数用于将某种数据类型的表达式显式转换为另一种数据类型。CAST()函数的参数是一个表达式，它包括用AS关键字分隔的源值和目标数据类型。

```sql
# Syntax: CAST (expression AS data_type)
# expression：任何有效的SQServer表达式。
# AS：用于分隔两个参数，在AS之前的是要处理的数据，在AS之后是要转换的数据类型。
# data_type：目标系统所提供的数据类型，包括bigint和sql_variant，不能使用用户定义的数据类型。

SELECT CAST('9.0' AS decimal)  # 结果：9
```

# interval
MySQL 间隔值(interval)主要用于日期和时间计算,创建间隔值。
``` sql
# INTERVAL keyword is the expr that determines the interval value, and unit that specifies the interval unit
# INTERVAL expr unit
INTERVAL 1 DAY

# We mainly use interval values for date and time arithmetic as shown below
date + INTERVAL expr unit
date - INTERVAL expr unit
```
# DATE_SUB()
DATE_SUB() 函数从日期减去指定的时间间隔。

```sql
# date 参数是合法的日期表达式。expr 参数是您希望添加的时间间隔。
DATE_SUB(date,INTERVAL expr type)
```

# IFNULL()
IFNULL() 函数用于判断第一个表达式是否为 NULL，如果为 NULL 则返回第二个参数的值，如果不为 NULL 则返回第一个参数的值。
``` sql
# 如果第一个参数的表达式 expression 为 NULL，则返回第二个参数的备用值。
IFNULL(expression, alt_value)
```

# union all
UNION 操作符用于连接两个以上的 SELECT 语句的结果组合到一个结果集合中。多个 SELECT 语句会删除重复的数据。
``` sql
# expression1, expression2, ... expression_n: 要检索的列。
# tables: 要检索的数据表
# WHERE conditions: 可选， 检索条件。
# DISTINCT: 可选，删除结果集中重复的数据。默认情况下 UNION 操作符已经删除了重复数据，所以 DISTINCT 修饰符对结果没啥影响。
# ALL: 可选，返回所有结果集，包含重复数据。

SELECT expression1, expression2, ... expression_n
FROM tables
[WHERE conditions]
UNION [ALL | DISTINCT]
SELECT expression1, expression2, ... expression_n
FROM tables
[WHERE conditions];
```
 [union all样例](https://www.runoob.com/mysql/mysql-union-operation.html)

 # acid
 