---
title: wsl oh my zsh 字符乱码问题
tags:
	- fixed issues
	- wsl
comments: true
---

## 安装 oh my zsh 

首先检查自己有没有zsh：

```
cat /etc/shells
```

如果有的话就下载[oh my zsh](https://github.com/robbyrussell/oh-my-zsh)

<!-- more -->

## 设置默认shell

```
chsh -s /bin/zsh
```

有可能会遇到设置不成功的问题，那么我们可以手动修改`/etc/passwd`，找到自己那一条配置信息，把默认shell改成`/bin/zsh`就OK了。

## 字体问题

`->`等一些其他字符可能显示不出来，这是字体导致的。google一下：`wsl oh my zsh font`，找到：[https://github.com/Microsoft/WSL/issues/1517](https://github.com/Microsoft/WSL/issues/1517)，下载并设置字体为：[DejaVuSansMono](https://github.com/powerline/fonts/blob/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf)。

## 怎么设置字体

右键标题栏，进入属性