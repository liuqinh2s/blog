---
title: 模拟实现JavaScript的new操作符
tags: [JavaScript]
---

JavaScript 的 new 操作符，操作对象是一个函数（箭头函数，async 函数除外），一般来说此函数我们不自己写 return，此时返回的是个默认的对象 this。

如果自己写了返回，那么分两种情况：

1. 返回的是对象或者方法，就返回我们自己写的返回内容
2. 否则返回默认对象 this

<!-- more -->

```javascript
function A() {
  this.aa = "6";
  // 7种基本数据类型，都不能作为构造函数的返回值，意思就是会被当做无效语句忽略掉。返回的依旧是默认对象this，而非基本数据类型
  //   return 1; // Number
  //   return false; // Boolean
  //   return "1"; // String
  //   return Symbol(); // Symbol
  //   return BigInt(1); // BigInt 也可以这么写 return 1n;
  //   return undefined; // Undefined
  //   return null; // Null
  // 5种常见对象，都可以作为构造函数的返回值
  //   return {};    // Object
  //   return [];    // Array
  //   return new Date();    // Date
  //   return /a/;    // RegExp
  //   return new Error();   // Error
  // 函数，可以作为构造函数的返回值
  //   return function(){};  // Function
}

const a = new A();
console.log(a, a.aa);
```

new 操作符的模拟实现：

```javascript
function newOperator(C) {
  if (typeof C !== "function") {
    throw "newOperator function the first param must be a function";
  }
  // ES6 new.target 指向构造函数，可以用来标识函数是否被用做构造函数
  newOperator.target = C;
  const obj = Object.create(C.prototype);
  const args = [].slice.call(arguments, 1); // arguments本身没有slice方法，除了这种写法，还可以这样：[...arguments].slice(1);或者Array.from(arguments).slice(1);
  const res = C.apply(obj, args);
  // typeof null 的结果是'object'，所以这里要排除掉
  if ((typeof res === "object" && res !== null) || typeof res === "function") {
    return res;
  }
  return obj;
}
```

## 参考

- [如何模拟实现 JS 的 new 操作符](https://www.freecodecamp.org/chinese/news/javascript-new-operator/)
- [new.target - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/new.target)
