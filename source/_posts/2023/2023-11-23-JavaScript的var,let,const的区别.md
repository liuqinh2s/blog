---
title: JavaScript的var,let,const的区别
tags: [JavaScript]
---

首先`var`,`let`,`const`都是用于定义变量，这是它们的共同点，那么它们的区别呢？

其实还可以什么都不用，直接给变量赋值，这样的话，就是赋值给了全局对象（在浏览器上就是 window 对象）:

```javascript
a = 1;
console.log(window.a);
```

<!-- more -->

## var 可以提升作用域，var 的作用域在闭包内

一下代码不会报错，即便声明 a 在用到 a 后面：

```javascript
console.log(a, b, c);
var a;  // 即便声明在使用之后，也不会报错，因为var变量声明和函数声明会提升到最前面执行
let b;
const c;
```

加一个块级作用域，var 依旧不会报错：

```javascript
console.log(a, b, c);
{
  var a;
  let b;
  const c;
}
```

而且 let 和 const 是块级作用域，写成这样也会报错：

```javascript
{
  let a;
  const b;
}
console.log(a, b);
```

var 无法跨闭包，报错：

```javascript
function a() {
  function b() {
    var a;
  }
  console.log(a);
}
a();
```

## 通过 var 声明的所有全局变量和函数都会变成 window 对象的属性和方法，而 let 和 const 不会

```javascript
var a = 1;
var b = function () {
  console.log("b");
};
// 用function声明的也会变成全局对象的方法
function c() {
  console.log("c");
}
console.log(window.a, window.b, window.c);
```

## 一个经典的坑

```javascript
for (var i = 0; i < 6; i++) {
  setTimeout(() => {
    console.log(i); // 输出全部是6
  });
}
```

使用 let 可以避免此问题：

```javascript
for (let i = 0; i < 6; i++) {
  setTimeout(() => {
    console.log(i); // 输出全部是6
  });
}
```

也可以用闭包来解决此问题，let 是 es6 引进的，实际上在 es5 一般就是用闭包来解决问题：

```javascript
function fn(i) {
  setTimeout(() => {
    console.log(i);
  });
}
for (let i = 0; i < 6; i++) {
  fn(i);
}
```

顺带说一下 js 怎么实现 sleep，用 setTimeout 和 Promise 可以实现

```javascript
function sleep(time) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve(true);
    }, time);
  });
}

for (let i = 0; i < 6; i++) {
  await sleep(1000);
  console.log(i);
}
```

不过 setTimeout 其实的 sleep 秒数不太准确，它要等所有的微任务都做完，如果微任务很长的话，就要多等一会儿了。

```javascript
function costManyTime() {
  let count = 0;
  for (let i = 0; i < 1000; i++) {
    for (let j = 0; j < 100_0000; j++) {
      count = Math.random();
    }
  }
}

function sleep(time) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve(true);
    }, time);
  });
}

for (let i = 0; i < 6; i++) {
  await sleep(1000);
  console.log(i, new Date());
  console.time("costManyTime");
  costManyTime();
  console.timeEnd("costManyTime");
}
```
