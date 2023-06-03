---
title: AwesomeWeb项目
date: 2023-05-22
categories: [项目]
tags: [前端, 项目]
comments: true
---

github 仓库：[liuqinh2s/AwesomeWeb](https://github.com/liuqinh2s/AwesomeWeb)
项目展示：[replit - AwesomeWeb](https://replit.com/@liuqinh2s/AwesomeWeb?v=1)

最近想像洛雪音乐一样做一个免费的视频 app，主要学习对象是努努视频，说干就干，先看看努努用了哪些第三方 js 库，打开努努视频网站：nunuyy5.org，然后打开开发者工具，可以看到用了这些：

1. [hls.js](https://github.com/video-dev/hls.js/)
2. [jquery.js](https://jquery.com/)
3. [p2p-media-loader-core.min.js 和 p2p-media-loader-hlsjs.min.js](https://github.com/Novage/p2p-media-loader/tree/master)

<!-- more -->

用`hls.js`就可以播放 m3u8 视频了，但是要怎么下载视频呢，在网上搜了一下，找到了一个下载器：[Momo707577045/m3u8-downloader](https://github.com/Momo707577045/m3u8-downloader/blob/master/index.html)

他的源码还是值得学习的

# 电子书阅读器

## epubjs

[官方文档](http://epubjs.org/documentation/0.3/)

[官方简单 demo](http://futurepress.github.io/epub.js/examples/spreads.html)

epub.js 核心类

Book 阅读器解析
Rendition 阅读器渲染
Locations 阅读器定位
Navigation 存储目录信息
View Manager 阅读器渲染出来的视图管理
EpubCFI 利用 EpubCFI 标准进行文字级别定位（可以定位到电子书中任意一个字符）
Theme 管理场景切换
Spine 指定阅读顺序和管理 Section
Section 指向具体章节（全文检索、章节切换）
Contents 管理章节资源内容（为某章节添加自定义字体）
Hook 定义钩子函数、管理类的生命周期
Annotations 管理标签（文字高亮显示）

这是我朋友做的一个基于 epubjs 的电子书阅读器:[http://118.190.10.34/epub-z/#/](http://118.190.10.34/epub-z/#/)

> 由于 epubjs 在 react 中太难使用，翻页都没实现成功。最终还是采用了更为简单的库：[React Reader - an easy way to embed a ePub into your webapp](https://github.com/gerhardsletten/react-reader)
