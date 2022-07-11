---
title: JavaScript原型和原型链
date: 2022-07-10
categories: [JavaScript]
comments: true
---

JavaScript 采用了原型和原型链来实现类和继承。原型和原型链主要由三个指针实现：

- `prototype`: 构造函数的`prototype`属性指向原型对象
- `__proto__`: 实例对象的`__proto__`属性指向原型对象
- `constructor`: 原型对象的`constructor`属性指向构造函数
- 所有对象都基于`Object`，而`Object`的`__proto__`为 null

<!-- more -->

> JavaScript 只要前面带 new 就是构造函数，箭头函数和异步函数不可以做构造函数，因为箭头函数没有 this，而异步函数返回的是 Promise 对象

当我们在实例对象上查找一个属性的时候，如果不存在，则会递归的去原型链上找。

![Javascript Object Hierarchy](http://www.mollypages.org/tutorials/jsobj.jpg)

- 所有对象都有`__proto__`属性，但只有函数对象才有`prototype`属性
- 实例对象没有`constructor`属性，该属性继承自原型对象

# 参考资料

- [JavaScript 深入之从原型到原型链](https://github.com/mqyqingfeng/Blog/issues/2)
- [Javascript Object Hierarchy](http://www.mollypages.org/tutorials/js.mp)
