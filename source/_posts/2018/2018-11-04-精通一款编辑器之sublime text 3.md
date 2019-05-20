---
title: 精通一款编辑器之sublime text 3
categories: [Skills of Tools, Editor]
comments: true
tags: [编辑器]
---

## 编辑器常用功能

1. 格式化代码：格式化代码可以让你不用管代码的格式，可以放肆的写程序，你可以少敲很多空格，不用关心代码的格式问题，机器给出的代码格式风格统一且漂亮，一键解决你的格式问题，真是提高码代码效率的非常重要的功能。
2. 查找文件：查找文件是在集成开发的时候非常重要的功能，当文件多起来的时候，快速定位到文件可以节省很多时间，甚至有时候文件实在太多，你只能通过查找的方式找到那个文件。
3. 正则全文件查找和替换：轻松让你更改全局变量和配置，这是一个必须的功能，没有它简直无法想象工作量有多大。
4. 代码收缩和扩展：代码太长怎么办，收缩和扩展啊。

<!-- more -->

## 安装卸载插件

1. `cmd+shift+p`：打开命令板，输入`install`，点击：**Package Control: Install Package**选项，然后搜索你想要的插件。
2. 卸载请在命令板输入：`remove`，点击：**Package Control: Remove Package**选项。其实卸载无非就是两个词：`remove`和`uninstall`，多试试就行了。

>打开命令板之后什么都不想干，怎么关闭命令板呢？其实很简单，再按一次打开命令板的快捷键就行了，**开关都用同一个键或者按钮（术语叫：toggle，可开可关），这是比较通用设计理念**。

## 基本快捷键

- 显示隐藏菜单栏：alt，如果你不小心把菜单栏隐藏了，除了用快捷键唤出，还真不知道有什么其他办法。
- 显示隐藏目录树：ctrl+k+b，这个功能可以在菜单栏中的view中找到，所以我觉得记不记无所谓

## vue 插件

1. **vue-syntax-highlight**：可以让`.vue`文件高亮。
2. **HTML-CSS-JS Prettify**：可以格式化这三种语言的代码，特别是单文件的vue，非常需要这个来同时格式化三种语言。不过需要配置一下。工具栏路径：`Sublime Text -> Preferences -> Package Settings -> HTML/CSS/JS Prettify -> Plugin Options - Default`，然后搜索：`allowed_file_extensions`，给这个配置项添加一个`vue`即可，要注意的是有四处有这个配置项，分别是`html`、`css`、`js`、`json`，如果你想它们全都能格式化，自然是要全都添加`vue`，但实验证明只加html里面就行了，如果在其他几个里面加反而引起了冲突。然后格式化代码的快捷键是什么呢？同样也有配置文件的，工具栏路径：`Sublime Text -> Preferences -> Package Settings -> HTML/CSS/JS Prettify -> Keyboard Shortcuts - Default`，可以看到：

```
[{
  "keys": ["super+shift+h"],
  "command": "htmlprettify"
}, {
  "keys": ["super+alt+h", "p"],
  "command": "htmlprettify_set_prettify_prefs"
}, {
  "keys": ["super+alt+h", "o"],
  "command": "htmlprettify_set_plugin_options"
}, {
  "keys": ["super+alt+h", "k"],
  "command": "htmlprettify_set_keyboard_shortcuts"
}, {
  "keys": ["super+alt+h", "n"],
  "command": "htmlprettify_set_node_path"
}]
```

第一项即为使用这个插件的快捷键，也就是格式化代码的快捷键。

## 底栏设置显示文件编码

在mac osx上一不小心按了cmd+shift+c，文件的存储格式现在变成了GBK格式，当我再按下cmd+s保存时，提示我UTF-8格式的文件不能用GBK格式来保存。怎么解决这个问题呢？首先我想查看这个文件是什么编码，Sublime Text的默认设置是不开启显示编码的，如果想开启，可通过菜单Perference → Settings – User，在打开的配置文件里 ，在大括号后面，增加以下内容：

```
// Display file encoding in the status bar
"show_encoding": true,
// Display line endings in the status bar
"show_line_endings": true,
```

此时保存该配置文件，就能够看到sublime最底下一行会显示文件编码格式了。以上的配置内容在Perference → Setting─Default都是false的。

然后在底栏点击文件编码，点击reopen with encoding，然后选择utf-8，然后cmd+w关闭窗口，然后cmd+shift+t重新打开刚刚关闭的窗口，就一切恢复正常了。
