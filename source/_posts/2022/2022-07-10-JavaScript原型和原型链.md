---
title: JavaScript原型和原型链
tags: [JavaScript]
---

# 原型链是干什么用的

JavaScript 采用了原型和原型链来实现类和继承（就是查找属性用的）。

当 JavaScript 查找一个对象上的属性的时候，在该对象上找不到就会去它的原型链上查找（通过`__proto__`一层一层往上找）。比如：

```javascript
function Foo() {}
var foo = new Foo();
Foo.prototype.a = 1;
console.log(foo.a); // 1
```

原型和原型链主要由三个指针实现：

- `prototype`: 构造函数的`prototype`属性指向原型对象（这个原型对象一般就用`构造函数.prototype`表示）
- `__proto__`: 实例对象的`__proto__`属性指向原型对象
- `constructor`: 原型对象的`constructor`属性指向构造函数
- 所有对象都基于`Object`，是因为所有原型对象的`__proto__`最终都指向`Object.prototype`，而`Object.prototype`的`__proto__`为 null

<!-- more -->

> JavaScript 只要前面带 new 就是构造函数，箭头函数和异步函数不可以做构造函数，因为箭头函数没有 this，而异步函数返回的是 Promise 对象

当我们在实例对象上查找一个属性的时候，如果不存在，则会递归的去原型链上找。

![Javascript Object Hierarchy](../../../../images/2023/prototype.jpg)

- 所有对象都有`__proto__`属性，但只有函数对象才有`prototype`属性，只有原型对象才有`constructor`属性（严格意义上）
- 实例对象没有`constructor`属性，该属性继承自原型对象。分别对实例对象和原型对象使用`hasOwnProperty`验证`constructor`属性即可证明

```Javascript
var a = new Object();
console.log(a.hasOwnProperty('constructor'));   // false
console.log(a.__proto__.hasOwnProperty('constructor')); // true
```

# 参考资料

- [JavaScript 深入之从原型到原型链](https://github.com/mqyqingfeng/Blog/issues/2)
- [Javascript Object Hierarchy](http://www.mollypages.org/tutorials/js.mp)
- [一文看懂 JS 的继承](https://www.freecodecamp.org/chinese/news/inheritance-in-js/)
- [面试官问：能否模拟实现 JS 的 new 操作符](https://juejin.cn/post/6844903704663949325)

# 实践

最后不得不说一句，在我们公司的项目开发中，根本用不上以上知识，我们都是用 typescript 和类编程。但了解底层原理还是有助于解决一些疑难杂症的
