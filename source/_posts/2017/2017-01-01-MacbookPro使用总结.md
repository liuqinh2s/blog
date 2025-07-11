---
title: Macbook Pro 使用总结
tags: [工具]
---

## 前言

我使用 macbook pro 2014 已经一年了，于是写篇总结吧。

> 此文最初写于 2016 年，2015 年我买了这台电脑，大约用了 7 年，够本了。目前在用 macbook air m1

macbook 机器的亮点：

1. 轻薄，铝制机身，外观简洁美观
2. 触摸板真的很好用，我已经很久没用过鼠标了（但触摸板很不适合打游戏）
3. 键盘背光
4. retina 屏也是非常养眼
5. 立体声也十分不错
6. 细节做得很好，充电口是磁吸的，正反两面都能充，指示灯是能显示是否充满的（用过 surface pro 4 的对比一下就知道，什么叫做细心，虽然 surface pro 4 也有充电指示灯，但只是纯白色，无法看出是否充满）

macbook 的系统叫做 OS X，这个系统最大的亮点是：GUI 和 CLI 完美结合，优化的很好，系统耗电少，待机时间超长。

可以说这是一个不错的工具，无论是对普通用户来说，还是对程序员来说。

> 然而价格并不亲民

接下来要讲的全是如何高效操作 macbook 的干货！！！

<!-- more -->

## 文件管理器 Finder

首先讲 Finder，这是 mac 系统的文件管理器。和 windows 的文件管理器对比有点不同，最不方便的地方在于点击右键没有新建文件选项。如果你会 Linux，可以用命令`touch 文件名`来新建文件，如果你不会命令，可以先打开文本编辑器，再新建文本文件。它的设计哲学是，你要新建什么文件，就先打开与这个文件相关的软件，再在这个软件里新建这个类型的文件，不过不方便就是不方便。

再讲讲优秀的地方，Finder 可以打开多级目录，另外可以 **按空格键预览**。Finder 还有 tag 系统，你可以通过 tag 来访问同一 tag 下的文件

格式转换：

有时候需要把 png 等格式的图片转成 jpg 的格式，于是有同学就去到处找格式转换软件了。其实在 Mac 中直接更改图片的扩展名，即可自动转成相应地格式~试试吧，如果你改格式前看了文件修改日期，改完格式后你会发现修改日期依然没变。

## 快捷键

然后讲讲快捷键设计，我在 windows 下已经有了些使用快捷键的习惯，比如：

win+E 是打开文件管理器

win+D 是显示桌面（也就是将所有窗口最小化）

win+L 锁屏

ctrl+S 保存

ctrl+A 全选

ctrl+C 复制

ctrl+X 剪切

ctrl+V 粘贴

ctrl+F 查找

当我来到 OS X 系统的时候，我同样先摸索了一番快捷键。**设计快捷键的哲学就是通用**，这样就可以节省记忆成本，mac 上的 cmd 基本上承担了 windows 上 ctrl 的职能，常用的快捷键有：

cmd+S 保存

cmd+A 全选

cmd+C 复制

cmd+X 剪切

cmd+V 粘贴

cmd+F 查找

cmd+, 打开 preferance 也就是打开设置界面

cmd+N 打开新窗口

cmd+W 关闭窗口

cmd+H 隐藏窗口

cmd+Q 退出程序

cmd+ctrl+F 全屏（并不支持所有程序，仅仅支持右上角有双箭头的程序）

cmd+Tab 切换程序

你用了 Finder 之后可能会恼火没有剪切文件的功能，但其实是有的，只是快捷键不一样，剪切文件的快捷键是，**先 cmd+C 复制，然后 cmd+option+V 粘贴。**

这是我常用的几个快捷键。总之快捷键不用记很多，按你自己的需要，记住常用的就行。

> 常用的容易记住，不常用的很难记住

另外对于乐于摸索的人，我觉得一些小 trick 可以增加趣味性，从而激发兴趣。下面再讲些不常用但是有意思的：

除了 cmd 键是常用的，option 键也值得我们关注，下面再讲几个 option 的妙用：

按住 option+shift 可以微调（1/4）音量、键盘背光亮度和屏幕亮度，按住 option 再按其他字母键等，会出现奇怪的字符 ¥©
œ∑®†¥åß©≈ç。

数学符号：

- 约等于: `Option + X` = ≈
- 度数: `Shift + Option + 8` = °
- 除号: `Option + /` = ÷
- 无穷: `Option + 5` = ∞
- 大于等于和小于等于: `Option + ,` 和 `Option + .` = ≤ 和 ≥
- 不等于: `Option + =` = ≠
- 圆周率: `Option + P` = π
- 加减: `Shift + Option + =` = ±
- 开方: `Option + V` = √
- 求和符号: `Option + W` = ∑

其他输入特殊符号：

- 版权符号: `Option + G` = ©
- 人民币符号: `Option + Y` = ¥

**按住 option 再把鼠标移到 Dock 上的 APP 上，你会发现退出变成了强制退出**。这就是快捷杀进程利器。

Command+Option+D 控制 Dock 的显示与隐藏

Command+Shift+H 隐藏所有其他窗口

**Shift+音量 会有声音，直接按音量默认是不出声**。调音量利器

Command+I 显示简介（在 Finder 中），可以修改打开一个文件的默认 APP

Command+Control+N 新建一个文件夹，并归类你选中的所有文件

### 编辑文本的快捷键

Command+Space 切换输入法

Command+left 让光标跳到最前面，相当于 windows 下的 home 键

Command+right 让光标跳到最后，相当于 windows 下的 end 键

Command+up 让光标跳到整个文本的最开头

Command+down 让光标跳到整个文本的最后

**Command+delete** 删除当前行，相当于 windows 下的 home，shift+end（选中，从行头到行尾），backspace，这三个操作的组合。这个快捷键会让你相当爽的。

### 截图快捷键

Command+Shift+3 截取整个桌面，并把截图作为一个文件存储在桌面上

Command+Shift+4 截取一个区域，并把截图作为一个文件存储在桌面上

Command+Shift+Ctrl+3 截取整个桌面，并复制到剪切板

Command+Shift+Ctrl+4 截取一个区域，并复制到剪切板

Command+Shift+4 然后按 Space 就会截取一个窗口。这样截图会自带阴影效果。如果不想自带阴影效果，可以按住 option 再点触摸板。

Command+Ctrl+A mac QQ 截图快捷键，由于屏幕分辨率太高，mac 系统快捷键截出来的图都太大了，而 macQQ 截出来的图大小正合适。

### Chrome 浏览器快捷键

这个应该是与操作系统无关的，但在 Mac 下养成了用快捷键的习惯，所以 Chrome 的快捷键都是在 Mac 上学的，在 windows 下注意用`Ctrl`替换`Command`键就行了。

Command+R 刷新

Command+L 将窗口焦点锁定到浏览器的地址栏，不用移动鼠标哦

Command+T 打开一个新 Tab

Command+Shift+T 打开一个之前被关闭的 Tab

Command+Shift+J 打开下载页面

Command+Shift+C 打开“检查(spectator)”，鼠标右键可以看到这个选项，一般是程序员使用的高级功能，但不能再次使用快捷键关闭。

Command+Shift+I 同样是打开 spectator，使用开发人员工具，但可以再次使用快捷键关闭。

Command+Shift+B 打开或关闭书签栏

Command+Option+B 打开书签管理器

Command+Y 打开历史记录

Command+Option+左右方向键 切换标签页

Command+D 收藏此页为书签

Command+Shift+D 将所有标签页加书签

Command+上下方向键 跳到页面顶部或底部

Command+Option+J 打开 javascript 控制台

按住 Command 后点击链接，在新 Tab（标签页）中打开这条链接。

Command+Shift 再点击链接，在新标签页中打开并切换到新标签页

Command+Shift+N 用隐身模式打开新窗口

Command+Shift+W 关闭当前窗口

Command+[ 或者 ] 前进或者回退

Command+左右方向键 前进或者后退

Command+Option+U 查看网页源代码

### iTerm2 快捷键

iTerm2 中的文本，选中即复制

Command+D 水平分隔出一个终端

Command+Shift+D 垂直分割出一个终端

可以配置透明度，Command+U 快速切换透明与否

可以配置全局唤出快捷键，我自己配置的是 Command+T

可以配置快捷悬浮，Hotkey window

Command+Shift+H 查看复制历史

Command+Enter 快速切换全屏与否

### CLI(命令行)快捷键

本来这里应该放到 Linux 里面讲的，但 Mac 本身的特点就是 GUI 和 CLI 的完美结合（很多 Linux 的爱好者，不想被 Linux 的桌面、各种驱动、不兼容等等杂七杂八的问题折腾的，大可以选择 Mac）。

首先教一个最重要的东西
记住**按 Tab 补全**，这是命令行用的爽的根源。

Ctrl+A 回到行首

Ctrl+E 到行末

Ctrl+U 删除一行

然后基本的 Linux 命令来了

cd / 到根目录

open / 用 Finder 打开根目录

## Launchpad 与 Dock

Launchpad 是指，你在触摸板上用五指向中间收拢，出现的全是 APP 的页面，半透明的。
Dock 是指，最下方的摆满 APP 的一栏，在 Dock 上你可以放上最常用的 APP。

调整 launchpad 的图标大小：

```bash
defaults write com.apple.dock springboard-rows Default

defaults write com.apple.dock springboard-columns Default

killall Dock
```

在 appstore 下载一个软件到一半，然后在 Application 删除了该软件，结果在 launchpad 中留下了一个垃圾残留空图标。
删除 launchpad 中的垃圾残留图标，只需拖拽到下载文件夹。其他方法都试过（无效），比如按住图标几秒，出现一个叉，点击叉，删除，没用。在 Application 找到相应项删除没用。

## 软件推荐

国内的常用娱乐软件：

- Mac QQ
- 微信
- 网易云音乐
- 新浪微博
- 百度云
- 迅雷
- 我来
- 有道词典
- 优酷客户端
- 爱奇艺客户端
- 阿里旺旺
- 每日英语听力

国外产的：

- Chrome
- VSCode
- calibre
- LICEcap
- Pocket
- iStat Menus
- TeamViewer
- Blu-ray Player
- Irvue
- Sip
- VMware Fusion
- The unarchiver
- Keka
- OmniDiskSweeper
- Bartender 2

程序员使用的：

- Xcode
- iTerm2
- oh-my-zsh
- dash
- FileZilla
- Pycharm
- Intellj IDEA
- Android Studio

## 结束语

君子性非异也，善假于物也。好的工具可以使人事半功倍，回顾整个人类史，又何尝不是一个工具史呢，从用石器到用火，从铁器到火药，从蒸汽机到内燃机，从汽车到电脑，我们在使用工具、利用自然规律，从而让自身变得越来越强大。
