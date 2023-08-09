---
title: 前端面试指南
---

# JavaScript 基础

最基础的两个知识点：

1. Prototype Chain（原型链）
   - [JavaScript 原型和原型链](../2022/07/10/JavaScript原型和原型链/)
2. closure（闭包）
   - [JavaScript 词法作用域](../2022/07/11/JavaScript词法作用域/)
   - [JavaScript 执行上下文栈](../2022/07/12/JavaScript执行上下文栈/)
   - [JavaScript 执行上下文之变量对象](../2022/07/13/JavaScript执行上下文之变量对象/)
   - [JavaScript 执行上下文之作用域链](../2022/07/14/JavaScript执行上下文之作用域链/)
   - [JavaScript 闭包](../2022/07/14/JavaScript闭包/)

结合这两个知识点学习，我们发现，**原型链就是用来方便查找对象上的变量，闭包就是方便查找自由变量**，本质上都是为了让 JavaScript 这个编程语言更加丰富，灵活，好用，方便程序员写出更加短小精悍，易于封装和复用的代码。

- 箭头函数
- Promise A+ 规范
- Event Loop（事件循环）
- apply, call, bind
- 内存回收
- try-catch：
   - [try-catch 能抛出 promise 的异常吗](https://juejin.cn/post/6850418110907088910)

## 浏览器环境

- [window.parent](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/parent)

## node 环境

# CSS 基础

- 行内元素和块级元素
- 盒模型
- 伪类和伪元素
- CSS 前缀
- BFC
- 垂直居中和水平居中
- position
- text-overflow（文本溢出）

# 前端编程范式

- debounce, throttle（防抖和节流）
- EventBus（事件总线）

# 浏览器相关

- 浏览器事件
- 事件委托
- Repaint, Reflow（重绘和回流）
- 同源策略和跨域
- CSRF 和 XSS 攻击

# 网络

## HTTP

- HTTP 状态码
- GET 请求和 POST 请求的区别
- HTTP 和 HTTPS 的区别
- HTTP 缓存

## TCP/IP

- TCP 为什么要三次握手四次挥手

# typescript

- type 和 interface 的区别
