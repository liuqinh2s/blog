---
title: JavaScript如何实现节流和防抖函数
tags: [JavaScript]
---

节流：throttle
防抖：debounce

这两个是 JavaScript 开发中两个经常需要用到的工具函数，主要用于解决性能问题。节流的意思是针对某函数的连续调用，在一定时间内每隔一小段时间调用一次目标函数；防抖的意思是针对某函数的连续调用，只在一小段时间间隔后执行最后一次调用。

常用的场景有：浏览器高频 DOM 事件的回调函数，比如 scroll，mousemove，resize 等

<!-- more -->

## throttle

时间戳实现：

```javascript
function throttle(fn, delay) {
  let timer = Date.now();
  return function (args) {
    if (new Date().getTime() - timer >= delay) {
      timer = new Date().getTime();
      return fn.apply(null, args);
    }
  };
}
```

定时器实现：

```javascript
function throttle(fn, delay) {
  let timer;
  return function (args) {
    if (timer) {
      return;
    }
    let res;
    timer = setTimeout(() => {
      timer = null;
      res = fn.apply(null, args);
    }, delay);
    return res;
  };
}
```

其实还有很多细节可以规定，比如，是否要立即执行一次，如果每次的执行结果不一样，指定了要最新的执行结果还是最旧的执行结果。

## debounce

```javascript
function debounce(fn, delay) {
  let timer;
  return function (args) {
    clearTimeout(timer);
    timer = setTimeout(() => {
      fn.apply(null, args);
    }, delay);
  };
}
```

debounce 也可以规定很多细节，比如，如果每次的执行结果不一样，指定了要最新的执行结果还是最旧的执行结果。如果要求立即返回第一次执行结果，抛弃之后的连续调用，怎么写？
