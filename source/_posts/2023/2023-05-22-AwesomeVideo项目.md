---
title: AwesomeVideo项目
date: 2023-05-22
categories: [项目]
tags: [前端, 项目]
comments: true
---

[liuqinh2s/AwesomeVideo](https://github.com/liuqinh2s/AwesomeVideo)

最近想像洛雪音乐一样做一个免费的视频 app，主要学习对象是努努视频，说干就干，先看看努努用了哪些第三方 js 库，打开努努视频网站：nunuyy5.org，然后打开开发者工具，可以看到用了这些：

1. [hls.js](https://github.com/video-dev/hls.js/)
2. [jquery.js](https://jquery.com/)
3. [p2p-media-loader-core.min.js 和 p2p-media-loader-hlsjs.min.js](https://github.com/Novage/p2p-media-loader/tree/master)

<!-- more -->

用`hls.js`就可以播放 m3u8 视频了，但是要怎么下载视频呢，在网上搜了一下，找到了一个下载器：[Momo707577045/m3u8-downloader](https://github.com/Momo707577045/m3u8-downloader/blob/master/index.html)

他的源码还是值得学习的
