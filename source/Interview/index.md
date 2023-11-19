---
title: 前端面试指南
---

# 编程题

## 数组扁平化(nest to flat)

实现一个`Array.prototype.flat()`，leetcode 对应题目：[2625. 扁平化嵌套数组](https://leetcode.cn/classic/problems/flatten-deeply-nested-array/description/)

## 扁平数组嵌套化(flat to nest)

1. 菜单数组转换为嵌套树形结构，但示例只有两级

```javascript
[
  { id: 1, menu: '水果', level: 1 },
  { id: 2, menu: '橘子', level: 2, parentId: 1 }
  // ...
]
// 转换为
[
  {
    id: 1, menu: '水果', level: 1, children: [{ id: 2, menu: '橘子', level: 2, parentId: 1 }]
  },
  // ...
]
```

以下是我给出的解答，未经过严格测试

```javascript
const a = [
  {
    id: 2,
    menu: "橘子",
    level: 2,
    parentId: 1,
  }, // ...
  {
    id: 1,
    menu: "水果",
    level: 1,
  },
];

function flat2nest(array) {
  const res = [];
  const map = {};
  for (let index = 0; index < array.length; index++) {
    if (map[array[index].id]) {
      map[array[index].id] = {
        ...array[index],
        children: map[array[index].id].children,
      };
    } else {
      map[array[index].id] = { ...array[index] };
    }
    if (!array[index].parentId) {
      res.push(map[array[index].id]);
    } else {
      if (!map[array[index].parentId]) {
        map[array[index].parentId] = {};
      }
      if (!map[array[index].parentId].children) {
        map[array[index].parentId].children = [];
      }
      map[array[index].parentId].children.push({ ...array[index] });
    }
  }
  return res;
}

const b = flat2nest(a);
console.log(b);
```

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

- [行内元素和块级元素](../2022/12/08/%E8%A1%8C%E5%86%85%E5%85%83%E7%B4%A0%E5%92%8C%E5%9D%97%E7%BA%A7%E5%85%83%E7%B4%A0/)
- 盒模型
- 伪类和伪元素
- CSS 前缀
- BFC
- [垂直居中和水平居中](../2022/12/13/css%E5%B1%85%E4%B8%AD%E7%9A%84%E6%9C%80%E4%BD%B3%E5%AE%9E%E8%B7%B5/)
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
