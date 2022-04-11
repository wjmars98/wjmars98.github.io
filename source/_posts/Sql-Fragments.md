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