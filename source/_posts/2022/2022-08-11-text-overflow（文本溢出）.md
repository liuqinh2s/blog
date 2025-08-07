---
title: CSS文本溢出显示三个点
tags: [前端基础]
---

# 参考

https://developer.mozilla.org/zh-CN/docs/Web/CSS/text-overflow

这个面试的时候被问过 N 次。不知道为啥这么喜欢问这个。今天好好学一下这个技巧

<!-- more -->

# text-overflow

text-overflow CSS 属性确定如何向用户发出未显示的溢出内容信号。它可以被剪切，显示一个省略号（"..."）或显示一个自定义字符串

![](https://secure2.wostatic.cn/static/x5sD24sryE3PtyBkBzw4Hd/image.png?auth_key=1754473784-6GYTYgJpMtXgz576di2vVr-0-5849c07b628e06a4470a2ac6a42739f1)

这个属性只对那些块级元素溢出的内容有效，但是必须要与块级元素内联（inline）方向一致（举个例子：内容在盒子的下方溢出。此时就不会生效）。文本可能在以下情况下溢出：当其因为某种原因而无法换行（例子：设置了"white-space: nowrap"），或者一个单词太长而不能合理的被安置（fit）

这个属性并不会强制"溢出"事件的发生，因此为了能让"text-overflow"能够生效，程序员们必须要在元素上添加几个额外属性，比如设置：overflow: hidden
