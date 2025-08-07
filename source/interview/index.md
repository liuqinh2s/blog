---
title: 前端面试指南
---

# 编程题

- [寻找字符串中出现最多的字符怎么实现？](../2022/07/24/寻找字符串中出现最多的字符怎么实现？)
- 数组扁平化(nest to flat)：实现一个`Array.prototype.flat()`，leetcode 对应题目：[2625. 扁平化嵌套数组](https://leetcode.cn/classic/problems/flatten-deeply-nested-array/description/)
- [扁平数组嵌套化（flat to nest）](../2022/07/25/扁平数组嵌套化（flat to nest）)
- 实现一个深拷贝
- 实现 Promise

# JavaScript 基础

最基础的两个知识点：

1. Prototype Chain（原型链）
   - [JavaScript 原型和原型链](../2022/07/10/JavaScript原型和原型链/)
   - [JavaScript 对象的继承有哪几种？](../2023/11/20/JavaScript对象的继承有哪几种/)
2. closure（闭包）
   - [JavaScript 词法作用域](../2022/07/11/JavaScript词法作用域/)
   - [JavaScript 执行上下文栈](../2022/07/12/JavaScript执行上下文栈/)
   - [JavaScript 执行上下文之变量对象](../2022/07/13/JavaScript执行上下文之变量对象/)
   - [JavaScript 执行上下文之作用域链](../2022/07/14/JavaScript执行上下文之作用域链/)
   - [JavaScript 闭包](../2022/07/14/JavaScript闭包/)

结合这两个知识点学习，我们发现，**原型链就是用来方便查找对象上的变量，闭包就是方便查找自由变量**，本质上都是为了让 JavaScript 这个编程语言更加丰富，灵活，好用，方便程序员写出更加短小精悍，易于封装和复用的代码。

- [箭头函数](../2022/08/06/箭头函数/)
- [Promise A+ 规范](../2023/07/19/Promise详解/)
- [Event Loop（事件循环）](../2022/08/05/宏任务和微任务/)
- 内存回收
- try-catch：
  - [try-catch 能抛出 promise 的异常吗](https://juejin.cn/post/6850418110907088910)
- 怎么判断对象为空？
- 类型判断
  - JavaScript 有几种基础数据类型(7 种)？Symbol 和 BigInt 是什么时候引进的？
  - `typeof`有几种类型(8 种)？分别是什么？
  - `Object.prototype.toString()`有几种类型？分别是什么？
- 模拟 JavaScript 原生方法
  - [模拟实现 JavaScript 的 new 操作符](../2023/11/20/模拟实现JavaScript的new操作符/)
  - [模拟实现 JavaScript 的 apply 和 call 方法](../2023/11/21/模拟实现JavaScript的apply和call方法/)
  - [模拟实现 JavaScript 的 bind 方法](../2023/11/22/模拟实现JavaScript的bind方法/)
- [知不知道最新的 url 参数获取的 API？](../2022/07/26/知不知道最新的url参数获取的API？/)

## JavaScript 历史

- [5 分钟彻底搞懂 js 的版本演进（ES5,ES6,ES2015 的区别） - 知乎](https://zhuanlan.zhihu.com/p/516325981)
- ES6 带来了哪些新东西？
- [ECMAScript 2015 Language Specification – ECMA-262 6th Edition](https://262.ecma-international.org/6.0/)
- [var，let，const 的区别](../2023/11/23/JavaScript的var,let,const的区别/)

## 浏览器环境

- [window.parent](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/parent)

## node 环境

# CSS 基础

- [行内元素和块级元素](../2022/12/08/%E8%A1%8C%E5%86%85%E5%85%83%E7%B4%A0%E5%92%8C%E5%9D%97%E7%BA%A7%E5%85%83%E7%B4%A0/)
- [盒模型](../2022/08/07/盒模型)
- [伪类和伪元素](../2022/08/10/伪类和伪元素)
- [CSS 前缀](../2022/08/09/CSS 前缀)
- [BFC](../2022/08/07/BFC)
- 垂直居中有几种方式？
  - [垂直居中和水平居中](../2022/12/13/css%E5%B1%85%E4%B8%AD%E7%9A%84%E6%9C%80%E4%BD%B3%E5%AE%9E%E8%B7%B5/)
- [position](../2022/08/08/css position)
- text-overflow（文本溢出）
- flex: 2 有用过吗？多列布局怎么实现？

# 前端编程范式

- [debounce, throttle（防抖和节流）](../2023/12/05/JavaScript如何实现节流和防抖函数/)
- EventBus（事件总线）

# 浏览器相关

- [浏览器事件](../2022/07/31/浏览器事件/)
- [事件委托](../2022/07/31/浏览器事件/#事件委托)
- Repaint, Reflow（重绘和回流）
- [同源策略和跨域](../2022/08/04/浏览器同源策略和跨域问题/)
- [CSRF 和 XSS 攻击](../2022/08/04/浏览器同源策略和跨域问题/#CSRF)

# 网络

## HTTP

- HTTP 状态码
- GET 请求和 POST 请求的区别
- HTTP 和 HTTPS 的区别
- HTTP 缓存

## TCP/IP

- [TCP 为什么要三次握手四次挥手](../2022/06/20/TCP和UDP的区别/)

# typescript

- [type 和 interface 的区别](../2022/06/21/type 和 interface 的区别/)

# react

- [用过哪些 react hooks？](../2025/07/21/常用 react hooks 总结/)

# vue

- Vue 组件通信方式有哪些，各有什么特点？
- Vue 项目怎么提高项目性能？举一些例子
- vue3 在某些场景比 vue2 性能更低，为什么会这样？

# 其他

- 新版本发布后，怎么用技术手段通知用户刷新页面？
- 性能优化数据怎么上报、分析？
- element ui table 吸顶怎么做，滚动怎么处理等
- TS 用的多吗？
- 工作中解决的最有成就感的事？
- 你在工作中遇到过最大的挑战是什么，怎么解决的？
- 在团队协作时，有遇到过什么问题吗，如果有冲突你会怎么做
- 你有什么想问我的？
- 低代码、怎么动态加载渲染一个组件，底层怎么实现？

## 2025-07-21

- 用过哪些 react hooks？
- 跨站脚本攻击
- 浏览器跨窗口通信，postMessage，broadcastChanel
- vue2，vue3
- 防爬虫手段
- canvas
- top left 搭配什么使用？
- less 语法，module css，怎么定义全局样式，怎么定义变量
- 暴露出的问题：问 Java 答不上，问 vue 答不上
