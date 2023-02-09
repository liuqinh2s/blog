---
title: border-radius详解
date: { { date } }
categories: [css]
tags: [css]
comments: true
---

看《CSS解密》的时候遇到border-radius不是很懂，有个例子如下：

```css
border-radius: 100% 100% 0 0 / 100% 0 0 0;  /* 左上角椭圆半径是半宽高 */
border-radius: 100% 0 0 0 / 100% 0 0 0;  /* 左上角椭圆半径是全宽高 */
```

差别挺大的对吧，原因就是角与角之间出现了挤兑（或者说重叠），如果遇到了重叠怎么办呢？怎么表现呢？原理是什么？

<!-- more -->

查[官方文档](https://developer.mozilla.org/en-US/docs/Web/CSS/border-radius)，发现讲的很粗糙，但官方文档给出了一个[**specification**](https://w3c.github.io/csswg-drafts/css-backgrounds/#border-radius)（详细说明），这里面有一条[Overlapping Curves](https://w3c.github.io/csswg-drafts/css-backgrounds/#corner-overlap)，专门讲了这种情况怎么处理。

简单来说就是找最大的一处重叠，然后所有的半径都等比例缩小，比例是：重叠处的总长度/原本长度。

假如最大重叠处的长度是宽的两倍，那么所有半径都要缩小一半。

[实验链接](https://codepen.io/liuqinh2s/pen/eYjzqMR)

## 关于缩写

缩写1（一个值）：

这种最简单

```css
border-radius: 100%;
/*等价于*/
border-radius: 100% 100% 100% 100%;
```

缩写2（两个值）：

重复自身一遍

```css
border-radius: 100% 0;
/*等价于*/
border-radius: 100% 0 100% 0;
```

缩写3（三个值）：

把中间这个值重复一遍

```css
border-radius: 100% 50% 100%;
/*等价于*/
border-radius: 100% 50% 100% 50%;
```

跟margin和padding的缩写是一模一样的



