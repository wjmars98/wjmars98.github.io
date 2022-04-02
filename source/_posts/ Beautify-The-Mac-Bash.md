---
title: Beautify The Mac Bash Base on iTerm2 And oh-my-zsh
date: 2022-04-02 12:34:49
tags:
- mac
- bash
- iterm2
---
在公司实习需要使用mac电脑来进行工作，其中bash是非常重要的工具，本文也是对bash进行了美化，提升使用的效率。
本文采用的方案是利用ITerm2 与 oh-my-zsh来进行美化,同时也要将其配置在vscode中。

在配置的过程中，发现如果路径层级过长，主机名的信息较长，会导致代码容易换行，影响观看。所以选了隐藏路径以及主机名，仅保留当前文件名，效果如图所示：

![demo show1](./%20Beautify-The-Mac-Bash/demo.jpg)
<!-- more -->

# 1. Iterm2安装及其陪配置
手动安装: [打开Iterm2 的官方网址](https://iterm2.com/)，下载相应的Iterm2 安装包，并安装。
Homebrew安装: 为了方便后期管理，采用homebrew进行安装。
```shell
# use brew to install iterm2
brew install iTerm2
```

设置iTerm2为默认的终端

<center>
    <img src="./%20Beautify-The-Mac-Bash/default-iterm2.jpg" width=300 >
</center>

设置iTerm2的字体为 *Meslo LG L DZ for powerline*，之后vscode的terminal字体也设置为Meslo LG L DZ for powerline。

# 参考文档：
[1. Iterm2官方文档以及下载链接](https://iterm2.com/)

[2. mac之 iTerm2 + Oh My Zsh 终端安装教程](https://segmentfault.com/a/1190000039834490)