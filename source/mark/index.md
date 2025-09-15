---
title: 收藏
date: 2019-02-20 20:30:09
---

这是我上网冲浪发现的一些有趣的东西，它们的编排方式是按日期倒序来的。

我一直打算像阮一峰一样出一份自己的周刊，但我不想局限于技术方面，只要是我感兴趣的，高质量的，有价值的信息都会在这里记录下来，以后周刊就会从这个里面出。

# 2025-08-29

- [机械图书馆](https://mechanical-library.org/)
- [天体地图](https://atlasof.space/)
- [all text in nyc](https://www.alltext.nyc/search?q=China)：这个网站对纽约街景照片做了文字识别，可以搜索某个词在纽约街头（路牌/招牌）出现的地点。
- [Is This Tech Dead? | Tech Obsolescence Tracker](https://www.isthistechdead.com/)
- [提示式编程](https://www.gibney.org/prompt_coding)

# 2025-08-22

- [中小学语文示范诵读\_央广网](https://edu.cnr.cn/eduzt/ywkwsfsd/)
- [毒蘑菇测试入口](https://volumeshader.org/zh)
- [HRAC 业余无线电执照考试 2025 最新题库 在线模拟 PWA 支持](https://github.com/AlliotTech/ham-exam-web)
- [citywalki](https://www.citywalki.com/)：这个网站让你感受在世界 200 多个城市步行/开车/飞无人机。选择城市和移动方式后，它会全屏播放相应的 Youtube 视频，体验不错。

# 2025-08-08

- 在线的像素图作图工具，可以同屏制作多个动画帧：[Pixel Motion](https://pixel-motion.yysuni.com/)
- 一个 25MB 大小的 AI 语音模型，用来从文本生成语音。只使用个人电脑 CPU，几分钟就安装完毕，通过 Python 脚本使用，好像不支持中文：[KittenML/KittenTTS: State-of-the-art TTS model under 25MB 😻](https://github.com/KittenML/KittenTTS)
- 跨平台的 AI 智能截图工具，可以识别并提取公式、表格、代码、图片和文字：
  - [xyTom/snippai: Snip Anything Solve Everything​](https://github.com/xyTom/snippai)
  - [Snippai: Snip Anything Solve Everything](https://www.snippai.de/)
- 一个在线数学工具，包括数学手册、计算器、数学图形绘制等功能：[黄博士网: 教育网,在线数学手册计算器软件，电化学虚拟实验室，虚拟电化学工作站，电化学软件](https://drhuang.com/chinese/science/mathematics/software/)
- 该网站收录中国国内的各种标志 LOGO 的 SVG 文件，目前有 700 多个：[收录国内矢量 LOGO - SVGLOGO](https://svglogo.top/?view=original)
- 这个英文仓库收录了启用 Linux 服务器以后的各种安全措施：[imthenachoman/How-To-Secure-A-Linux-Server: An evolving how-to guide for securing a Linux server.](https://github.com/imthenachoman/How-To-Secure-A-Linux-Server)
- 一篇长文，介绍 SVG 格式的基础知识：[A Friendly Introduction to SVG • Josh W. Comeau](https://www.joshwcomeau.com/svg/friendly-introduction-to-svg/)

# 2024-08-06

- [一些好书](https://github.com/0voice/expert_readed_books)

# 2024-07-31

发现一个宝藏博主：https://icheer.me/

跟我一样也对世界保持好奇，收藏了蛮多有意思的东西。

- [earth.fm](https://earth.fm/)：地球 FM，聆听地球的声音
- [各行各业每日新闻报告](https://www.mrbaogao.com/)
- [relingo](https://relingo.net/en)：这个好像和沉浸式翻译差不多
- [monkeytype](https://monkeytype.com/)：一个打字网站，不知道为啥挺火的样子
- [calmcode](https://calmcode.io/)：免费 python 编程教学视频

# 2024-03-23

- [阳光知道 - 关注各种编程开发技术](https://uovol.com/)
- [文生视频](https://app.pixverse.ai/)

# 2023-12-08

- [Python Online Compiler (interpreter / Editor)](https://pythononlinecompiler.com/)
- [LLM Visualization](https://bbycroft.net/llm)
- 英语长文阅读 Think things through - A daily long-form essay to make you smarter about technology, productivity, and AI.
  Trusted by almost 70k builders.：[Every](https://every.to/)

# 2023-11-19

今日话题：

- 前端面试

最近在看一些面试的常见问题，看看自己的技术底子是否扎实，发现一个很好的东西：[若川 - freeCodeCamp.org](https://www.freecodecamp.org/chinese/news/author/lxchuan12/)

- [使用基本 HTML5 模板，开始你的 Web 开发项目](https://www.freecodecamp.org/chinese/news/basic-html5-template-boilerplate-code-example/)
- [about:blank 是什么意思？](https://www.freecodecamp.org/chinese/news/about-blank-what-does-about-blank-mean-and-why-is-it-blocked-in-chrome-and-firefox/)
- [面试官问：能否模拟实现 JS 的 new 操作符](https://juejin.cn/post/6844903704663949325)

如果我来出面试题：如何实现一个 instanceof

```javascript
function instanceofFunc(instance, A) {
  let p = instance.__proto__;
  while (p !== null) {
    if (p.__proto__ === A.prototype) {
      return true;
    } else {
      p = p.__proto__;
    }
  }
  return false;
}
```

# 2023-11-15

今日话题：

- 技术开发岗薪资，以及什么是真正的技术

今天查了一下 2023 开发岗薪资的情况，发现自己的工资有点落后了，中位数是 36w。通过这篇文章：[开发人员薪资：2023 年有增长吗？](https://hackernoon.com/zh/2023-%E5%B9%B4%E5%BC%80%E5%8F%91%E4%BA%BA%E5%91%98%E8%96%AA%E8%B5%84%E6%9C%89%E5%A2%9E%E9%95%BF%E5%90%97)，发现了这个网站：[HackerNoon - read, write and learn about any technology](https://hackernoon.com/)，感觉挺不错的。

最难的是内科

# 2023-11-14

今日话题：

- 如何开发一个富文本编辑器
- vanilla-js

最近有同事在研究富文本编辑器，我也顺带看看：[Building A Rich Text Editor (WYSIWYG) — Smashing Magazine](https://www.smashingmagazine.com/2021/05/building-wysiwyg-editor-javascript-slatejs/)

据说 [vanilla-js](http://vanilla-js.com/) 特别快，但我是第一次听说这个，结果这个项目只是个玩笑：[前端社区的恶趣味之 Vanilla JS](https://cloud.tencent.com/developer/article/1480652)

# 2023-11-09

今日话题：

- AI
- 编译原理 - 语法分析
- 免费翻墙搭建

一些调教好的 AI，用以回答专门领域的问题：
[Open Prompt - Create, Use, Share ChatGPT prompts.](https://openprompt.co/)

JavaScript AST Parser：

- Esprima
  - [Esprima: Parser](https://esprima.org/demo/parse.html#)
  - [esprima/src at main · jquery/esprima](https://github.com/jquery/esprima/tree/main/src)

很早之前就想自己写个解析器了，但一直没有落实下来，最近看了 Esprima 的源码

如何搞一个免费的翻墙，有人用 Cloudflare 搞了一个：

- [Cloudflare CDN 反代免费 VPN 高速上网，速度超快，千兆节点、解锁奈飞流媒体 - 科技小飞哥](https://www.techxiaofei.com/post/vpn/cdn/)
- [CloudFlare 的免费 VPN，Warp+ 优选 IP，实现无限的高速流量！ – 零度解说](https://www.freedidi.com/9876.html)

# 2023-11-08

今日话题：

- chrome 插件开发入门
- vscode 插件开发入门
- 自己封装常用的 useHooks
- WebGL 入门
- 发现一本高分设计书
- 谷歌官方出的 web 开发教程
- ChatGPT 提示词

在搜 chrome 插件怎么开发的时候，发现了这篇文章：[Chrome 插件(扩展)开发全攻略-腾讯课堂](https://ke.qq.com/cheese/graphic_9c1952c561e303f378ce03e6a174c046_0-1.html)

然后觉得这个 [涨知识-腾讯课堂](https://ke.qq.com/cheese)，还不错。又在里面看文章，通过这篇[React Hooks 的花样玩法-腾讯课堂](https://ke.qq.com/cheese/graphic_328429a4ceea74ca454293560efcadf9_0-1.html)，发现了一个不错的小网站：[useHooks – The React Hooks Library](https://usehooks.com/)，专门罗列了一些常用的 useHooks，可以学习一下，比如`useClickAway`我就经常用到。

最近想自己开发一款类似 Beecarbonize 的卡牌游戏，于是搜到了一个关于 WebGL 的不错的教程：[WebGL2 理论基础](https://webgl2fundamentals.org/webgl/lessons/zh_cn/)

关于 WebGL 的更多有意思的网站：

- [WebGL playground](http://webglplayground.net/)
- [WebGL Academy Interactive Tutorials](http://www.webglacademy.com/)

从某人的博客中发现的一本设计书笔记，搜了一下豆瓣，评分还可以：[写给大家看的设计书（第 3 版）](https://book.douban.com/subject/3323633/)

同事自己开发了一款方便工作的 vscode 插件，我也搜了一下 vscode 插件如何开发，发现了这篇文章：[前端 - 从 0 到 1 开发一款自己的 vscode 插件 - 个人文章 - SegmentFault 思否](https://segmentfault.com/a/1190000040720760)

谷歌专家写的 web 开发教程：[web.dev](https://web.dev/learn?hl=zh-cn)

# 2023-07-21

阮一峰的周报，里面看到四个简单介绍技术原理的文章：

- [Everything You Want To Know About Media Queries and Responsive Design | Kablamo Engineering Blog](https://engineering.kablamo.com.au/posts/2023/media-queries-and-responsive-design/)
- [A Fast Intro to Git Internals](https://sites.google.com/a/chromium.org/dev/developers/fast-intro-to-git-internals)
- [Hashing](https://samwho.dev/hashing/)
- [socket 到底是个啥](https://mp.weixin.qq.com/s/Ebvjy132eRDOmcIL5cmxJw)

一些有意思的工具：

- [迅排设计](https://github.com/palxiao/poster-design)
- [sniffnet](https://github.com/GyulyVGC/sniffnet)
- [Triviance! - Free online trivia quizzes](https://triviance.com/)
- [fastgpt](https://labs.kagi.com/fastgpt)
- [Discovering the Best Artificial Intelligence Website](https://www.toolai.io/)

免费电子书:

- [Python for Data Analysis, 3E](https://wesmckinney.com/book/)

# 2023-07-19

和菜头最近的文章质量高到爆炸

- [回答：究竟哪一个译本最好？](https://mp.weixin.qq.com/s/x--2-cGJkIXhMoFxn9EzWA)
- [短视频里什么都有，除了......](https://mp.weixin.qq.com/s?__biz=MjM5MjAzODU2MA==&mid=2652795054&idx=1&sn=2b8963c4cc88cfef3cf5eca13b043483&chksm=bd46bb618a3132777dfc6f04eb72cacbbe01e3ce32f4036b1cd3b639dd02cf8f2d1fecc4ab8e&scene=178&cur_album_id=1883283321711820801#rd)
- [笨蛋，当然是先选人](https://mp.weixin.qq.com/s?__biz=MjM5MjAzODU2MA==&mid=2652795062&idx=1&sn=0b12c99943846fb0c22f69e04321510d&chksm=bd46bb798a31326f339fb1b72dc9982fedbac61cba7ad3be00781ae19d289b9171d70b943322&scene=178&cur_album_id=1883283321711820801#rd)

发现一个制作非常精美的网站，有点像期刊的感觉，这个 UI 和产品设计很值得学习

- [#UNTAG](https://utgd.net/)

其他比较好的小网站：

- [FancyPig's blog——专注于网络安全与技术分享](https://www.iculture.cc/)
- [小众软件 - 分享免费、小巧、实用、有趣、绿色的软件](https://www.appinn.com/)

# 2023-07-17

- [一个独立创造者的五年](https://mp.weixin.qq.com/s/x6PLSIMn_1qcKnXWPT-J-Q)
- [GifCities](https://gifcities.org/)
- [FlagWaver](https://krikienoid.github.io/flagwaver/)
- [LeaferJS](https://www.leaferjs.com/)
- [原生 css scope](https://css.oddbird.net/scope/explainer/)：试了一下官方的例子，似乎浏览器还没支持

# 2023-07-12

- [RefrainMusic](https://refrain-music.vercel.app/#/musichall/featrued)，我同事做的一款音乐 app

# 2023-07-08

- [小报童](https://xiaobot.netlify.app/)
- [BlogHub](https://bloghub.fun/)
- [TO-D 杂志](https://2d2d.io/)
- [f5.pm](https://f5.pm/)
- [美团技术团队](https://tech.meituan.com/)
- [Quick Reference](https://wangchujiang.com/reference/)

# 2023-07-07

- [A free API database list for developers](https://apivault.dev/)：这个网站收集了大量公共 API，相当于 API 的搜索引擎，用户可以提交新的 API。

# 2023-06-16

- [Introduction to Compilers and Language Design](https://www3.nd.edu/~dthain/compilerbook/)
- [GitHub Actions by Example](https://www.actionsbyexample.com/)
- [提示工程指南 | Prompt Engineering Guide](https://www.promptingguide.ai/zh)
- [高等院校三千所 👨‍🎓 助力考生选大学 | Laosheng.top](https://laosheng.top/fuwu/yuanxiao)
- [Tiny Player | Tiny Player](https://tiny-player.vercel.app/)
- [zh-lx/code-inspector: 点击页面元素，可以自动定位至编辑器元素对应源代码，支持 webpack 和 vite](https://github.com/zh-lx/code-inspector)
- [How to make a QR code with Stable Diffusion - Stable Diffusion Art](https://stable-diffusion-art.com/qr-code/)

# 2023-06-15

- [通往 AGI 之路](http://waytoagi.com)

# 2023-06-11

- [Music Player](https://shurlormes.github.io/MusicPlayer/#/)
- [github - Shurlormes/MusicPlayer](https://github.com/Shurlormes/MusicPlayer/blob/master/README.md)
- [react-jinke-music-player](https://www.lijinke.cn/react-music-player/)
- [github - lijinke666/react-music-player](https://github.com/lijinke666/react-music-player)

# 2023-06-09

- [配置使用 Kcptun 来暴力加速 shadowsocks 代理](https://lala.im/1569.html)

# 2023-06-08

- [讲讲 PWA](https://segmentfault.com/a/1190000012353473)

# 2023-06-07

- [Github Actions 备忘清单](https://wangchujiang.com/reference/docs/github-actions.html)
- [新的脚本，自动部署 Hugo 博客至服务器](https://jyan.wang/tech/new-auto-deploy-hugo-blog/)
- [阮一峰 - GitHub Actions 入门教程](https://www.ruanyifeng.com/blog/2019/09/getting-started-with-github-actions.html)

# 2023-06-05

- [Every tool you need to work with PDFs in one place](https://www.ilovepdf.com/)
- [How Clothes Should Fit](https://howclothesshouldfit.com/)
- [首页 | 墨七](https://blog.mo7.cc/)
- [Artiely](https://artiely.gitee.io/)

# 2023-06-02

- [安全训练的 Web 应用](https://owasp.org/www-project-juice-shop/)
- [计算机专业学习路线](https://hackway.org/docs/cs/intro)

# 2023-06-01

- [Free Music For YouTube Videos & Creators • Uppbeat](https://uppbeat.io/)
- [欢迎来到首页 | Viking Zhang, 一个前端开发工程师以及独立开发者的故事](https://vikingz.me/)

# 2023-05-30

- [随机点菜小程序](http://chishenme.xyz/)

# 2023-05-19

- [维基大学](https://en.wikiversity.org/wiki/Wikiversity:Main_Page)
- [一个搜索引擎，查找最热门的免费 3D 打印模型。](https://www.printablesearch.com/)
- [壁纸网站](https://wallhaven.cc/)
- [基于 Electron 的桌面壁纸客户端](https://github.com/wangrongding/wallpaper-box)

# 2023-03-31

- [这个网站可以导入 GPS 轨迹，在地形图上显示，特别适合生成山地路线图。](https://cubetrek.com/static/join.html)
- [AI 研究所](https://www.aiyjs.com/)
- [Deep Learning Do It Yourself!](https://dataflowr.github.io/website/)
- [这篇长文详细介绍 Web 应用是什么，理清各种概念，比如 SPA（单页应用）、SSR（服务器端渲染）、SSG（静态网站生成）。](https://www.robinwieruch.de/web-applications/)

# 2023-02-24

- [渐构](https://www.modevol.com/): 这个网站我今天又去看了，新增了不少视频和合作方，挺好的一个学习网站

# 2023-02-15

- [计算机教育中缺失的一课](https://missing-semester-cn.github.io/)
- [LABULADONG 的算法网站](https://labuladong.github.io/algo/)

# 2023-01-13

- [MLU-Explain(Visual explanations of core machine learning concepts)](https://mlu-explain.github.io/)

# 2022-12-25

- [欢迎来到 GitHub 最大的开源算法库](https://the-algorithms.com/zh_Hans)

# 2022-12-15

- [2021 家电选购攻略 | 洗衣机 - 知乎](https://zhuanlan.zhihu.com/p/99879416)
- [深入浅出 CSS 布局\_CSS 布局从入门到精通](http://layout.imweb.io/)

# 2022-12-14

今天主要是总结了 css 居中的最佳实践，工作中应该足够用了，但对于其他很多的 css 特性我掌握得还不够，下面是 grid 布局的知识：

- [CSS Grid 网格布局教程 - 阮一峰的网络日志](https://www.ruanyifeng.com/blog/2019/03/grid-layout-tutorial.html)
- [网格布局的基本概念 - CSS（层叠样式表） | MDN](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Grid_Layout/Basic_Concepts_of_Grid_Layout)
- [grid 布局*网格布局*深入浅出 CSS 布局](http://layout.imweb.io/article/grids.html)
- [CSS Houdini - Web 开发者指南 | MDN](https://developer.mozilla.org/zh-CN/docs/Web/Guide/Houdini)

# 2022-12-09

以下内容全部来自每周五的阮一峰周报：

- 一个简单教程，介绍如何写一个 TypeScript 库发布到 NPM 上面。:[How to Write a TypeScript Library](https://www.tsmean.com/articles/how-to-write-a-typescript-library/)
- 很多音乐服务现在都是收费的，作者使用树莓派，搭建一个自己的音乐服务器，实现随时随地的听歌自由。:[如何搭建一个自己的音乐服务器](https://www.wdbyte.com/music-server.html)
- 程序员分成两派，一派是"如果东西没有损坏，就不要去修它"，另一派是"尽早更新，并经常发布"。我的想法是，即使"东西没有坏"，你仍然可以改进它。你的客户会喜欢这样，你的竞争对手不会。永远不要停止挑战自己。:[Balancing “If it ain’t broke, don’t fix it” vs. “Release early and often”](https://www.redhat.com/en/blog/balancing-if-it-aint-broke-dont-fix-it-vs-release-early-and-often)
- 如果从 10 岁开始，一直到 80 岁，你每天浏览 90 个网页，每个网页的加载需要 4 秒，你一共会花费 103.66 天等待网页加载。如果网页加载时间减少 1 秒，你会多出来 27 天的生命！:[How much time do we waste waiting for websites to load?](https://www.datafantic.com/how-much-time-do-we-waste-waiting-for-websites-to-load/)
- 作者推荐使用 NestJS 作为后端框架，本文介绍他眼中这个框架的几大优点。:[Why Choose NestJS as Your Backend Framework - Amplication](https://amplication.com/blog/why-choose-nestjs-as-your-backend-framework-amplication)
- 本文介绍如何使用 JavaScript 验证一个 URL 是否合法。:[Secure JavaScript URL validation](https://snyk.io/blog/secure-javascript-url-validation/)
- Backblaze 是一个存储服务商，Cloudflare 是 CDN 服务商，两者都提供免费服务。将它们结合起来，就能获得免费的存储 + CDN。:[How to setup a practically free CDN](https://gist.github.com/charlesroper/f2da6152d6789fa6f25e9d194a42b889)
- 作者需要找一个功能完善的云原生应用平台，经过自己筛选和朋友推荐，剩下 KubeSphere 和 Rainbond 这两个产品。:[开源云原生平台 KubeSphere 与 Rainbond 对比](https://mp.weixin.qq.com/s/VIxJNlJHQu91T7ASXg7sAQ)
- 这是 Markdown 格式的升级版，修正了一些不合理和难用的地方。我很喜欢这个格式，但愿能够推广开来。作者 John MacFarlane 是加州大学的哲学教授，也是程序员。他的主要项目是文档工具 Pandoc，他还参与了 CommonMark 标准的制定。[Djot](https://djot.net/)
- 一款好用强大的开源建站工具，基于 Spring，最近发布了 2.0 版，在 GitHub 有 24k+ 星，查看 Demo。:[Halo [ˈheɪloʊ] 好用又强大的开源建站工具。](https://halo.run/)
- 一个数据探索和数据可视化工具，可以与各种数据源很好地集成。:[Apache Superset is a modern data exploration and visualization platform](https://superset.apache.org/)
- 一个 Node.js 网站框架，特点是结构简单，一个 HTML 页面就是一个路由。:[Enhance Docs](https://enhance.dev/docs/)
- 平面设计软件 Canva 推出了四款中文字体，可以免费使用（包括商用）。:[Canva 可画原创字体集发布｜江南百味，此刻沉醉](https://mp.weixin.qq.com/s/dDCQxLhxj3tciMWEW2JeqQ)
- 一个 Node.js 工具，在命令行显示两个方框，一个输入代码，一个显示结果。:[【开源自荐】一个 Node.js 交互式解释器终端](https://github.com/ruanyf/weekly/issues/2776)
- ChatGPT 的新用途，现在每天都在增加。有人让它解释代码，有人让它写程序和找 Bug，甚至有人让它扮演虚拟机，我说一条命令，你把执行结果告诉我。:[Building A Virtual Machine inside ChatGPT](https://www.engraved.blog/building-a-virtual-machine-inside/)
- 美国空军正在试验一种"体外骨骼"，士兵穿上这种机械装置以后，会拥有更大的力量，完成各种任务。:[US Air Force tests exoskeleton to give cargo-loading porters a boost](https://www.defensenews.com/air/2022/10/17/us-air-force-tests-exoskeleton-to-give-cargo-loading-porters-a-boost/)
- 西铁城手表的官网有一个页面，教你怎么用手表作为指南针，（在北半球）找到南方，很实用的小知识。:[如何使用手表作为指南针（以北半球为例）](https://www.citizenwatch-global.com/support/exterior/direction_sc.html)
- ChatGPT 项目：[Welcome to ChatGPT Log in with your OpenAI account to continue](https://chat.openai.com/auth/login)
- [ChatGPT 知乎插件](https://github.com/no13bus/chat-gpt-zhihu-extension)
- [ChatGPT google 插件](https://github.com/wong2/chat-gpt-google-extension)

# 2022-11-27

今天得整理一下 Tools，把里面非工具的部分，挪到 Mark 里面

- [37 岁白手起家，干成世界第一，资产 5000 亿，邓小平接见他 9 次！](https://mp.weixin.qq.com/s/wD1TeoqeDB9KLNHnTRWrnQ)
- [2020 年全球森林资源评估](https://www.fao.org/forest-resources-assessment/2020/zh)

# 2022-11-18

- [国产文具太难了...日本文具玩转“黑科技”，网友看完：真绝，差距不止一点点](https://mp.weixin.qq.com/s/itV_n0iIMD_k2Mal70DVyg)
