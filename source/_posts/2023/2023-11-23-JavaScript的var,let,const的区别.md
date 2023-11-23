---
title: JavaScript的var,let,const的区别
date: 2023-11-23
categories: [JavaScript]
comments: true
---

首先`var`,`let`,`const`都是用于定义变量，这是它们的共同点，那么它们的区别呢？

其实还可以什么都不用，直接给变量赋值，这样的话，就是赋值给了全局对象（在浏览器上就是 window 对象）:

```javascript
a = 1;
console.log(window.a);
```

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
