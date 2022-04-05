---
title: Pyenv
date: 2022-04-02 00:05:00
tags:
- python
---
在python编程的过程中，经常需要在2.x 与  3.x 中进行切换，2和3两个版本间差异巨大，需要进行管理。

pyenv是一个forked自ruby社区的简单、低调、遵循UNIX哲学的Python环境管理工具, 它可以轻松切换全局解释器版本, 同时结合vitualenv插件可以方便的管理对应的包源.

pyenv和virtualenv。前者用于管理不同的Python版本，后者用 于管理不同的工作环境，能够极好得解决我们工作学习中遇到的python版本环境控制问题。
<!--more-->

# Pyenv简介
如前言所言，pyenv允许用户在不同版本的python中切换。pyenv基于rbenv进行开发，由ruby语言进行编程，为python而准备的。

## Pyenv 用处
1. 允许用户更改全局python的版本
2. 为每个python版本都提供支持
3. 允许使用环境变量重写python版本
4. 有助于使用 tox 跨 Python 版本进行测试

## Pyenv 不允许
1. pyenv是由shell 脚本编写的，不存在python的引导问题。
2. 需要将把pyenv安装目录载入到环境中。
3. pyenv无法管理虚拟环境，但是可以利用 virtualenv或者 pyenv-virtualenv实现。

# 工作原理




# 参考文档
[pyenv-官方文档](https://github.com/pyenv/pyenv)
