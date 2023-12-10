---
title: JavaScript 闭包
tags: [JavaScript]
---

# 闭包是干什么用的

本质上闭包就是为了拓展查找自由变量的范围

MDN 对闭包的定义为：

A closure is the combination of a function bundled together (enclosed) with references to its surrounding state (the lexical environment)

一个函数和对其周围状态（lexical environment，词法环境）的引用捆绑在一起（或者说函数被引用包围），这样的组合就是闭包（closure）。

```Javascript
function init() {
  var name = 'Mozilla'; // name is a local variable created by init
  function displayName() {
    // displayName() is the inner function, a closure
    console.log(name); // use variable declared in the parent function
  }
  displayName();
}
init();
```

name 是 displayName 函数所处环境中的变量，它们一起构成了闭包。而闭包的实现依赖于执行上下文中的作用域链。

上面这个例子有点平平无奇了，让我们看一个神奇一点的例子：

<!-- more -->

```JavaScript
var scope = "global scope";
function checkscope(){
    var scope = "local scope";
    function f(){
        return scope;
    }
    return f;
}

var foo = checkscope();
foo();
```

这里直接给出简要的执行过程：

1. 进入全局代码，创建全局执行上下文，全局执行上下文压入执行上下文栈
2. 全局执行上下文初始化
3. 执行 checkscope 函数，创建 checkscope 函数执行上下文，checkscope 执行上下文被压入执行上下文栈
4. checkscope 执行上下文初始化，创建变量对象、作用域链、this 等
5. checkscope 函数执行完毕，checkscope 执行上下文从执行上下文栈中弹出
6. 执行 f 函数，创建 f 函数执行上下文，f 执行上下文被压入执行上下文栈
7. f 执行上下文初始化，创建变量对象、作用域链、this 等
8. f 函数执行完毕，f 函数上下文从执行上下文栈中弹出

了解到这个过程，我们应该思考一个问题，那就是：

当 f 函数执行的时候，checkscope 函数上下文已经被销毁了啊(即从执行上下文栈中被弹出)，怎么还会读取到 checkscope 作用域下的 scope 值呢？

以上的代码，要是转换成 PHP，就会报错，因为在 PHP 中，f 函数只能读取到自己作用域和全局作用域里的值，所以读不到 checkscope 下的 scope 值。

然而 JavaScript 却是可以的！

当我们了解了具体的执行过程后，我们知道 f 执行上下文维护了一个作用域链：

```javascript
fContext = {
  Scope: [AO, checkscopeContext.AO, globalContext.VO],
};
```

对的，就是因为这个作用域链，f 函数依然可以读取到 checkscopeContext.AO 的值，说明当 f 函数引用了 checkscopeContext.AO 中的值的时候，即使 checkscopeContext 被销毁了，但是 JavaScript 依然会让 checkscopeContext.AO 活在内存中（因为还有别的引用在，所以不会进行垃圾回收），f 函数依然可以通过 f 函数的作用域链找到它，正是因为 JavaScript 做到了这一点，从而实现了闭包这个概念。

所以，让我们再看一遍实践角度上闭包的定义：

- 即使创建它的上下文已经销毁，它仍然存在（比如，内部函数从父函数中返回）
- 在代码中引用了自由变量

在这里再补充一个《JavaScript 权威指南》英文原版对闭包的定义:

> This combination of a function object and a scope (a set of variable bindings) in which the function’s variables are resolved is called a closure in the computer science literature.

闭包在计算机科学中也只是一个普通的概念，大家不要去想得太复杂。

# 经典面试题

```javascript
var data = [];

for (var i = 0; i < 3; i++) {
  data[i] = function () {
    console.log(i);
  };
}

data[0]();
data[1]();
data[2]();
```

答案是全是 3，因为这里的 i 是直接从全局上下文中读取到的，让我们多加一层闭包：

```javascript
var data = [];

for (var i = 0; i < 3; i++) {
  data[i] = (function (i) {
    return function () {
      console.log(i);
    };
  })(i);
}

data[0]();
data[1]();
data[2]();
```

这里写了个立即执行函数，由它创建了一个闭包：立即执行函数的 AO + 内层函数，这个闭包中有个自由变量 i，来自这个立即执行函数的形参，形参在每次立即执行后会被分别赋值 0,1,2。而内层函数被返回给这个 data 数组，当内层函数执行时，顺着作用域链查找 i，会先从立即执行函数的 AO 中读取到 i，就会分别读取到 0,1,2。

# 参考

- [JavaScript 深入之闭包](https://github.com/mqyqingfeng/Blog/issues/9)
- [闭包 - mdn](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Closures)
