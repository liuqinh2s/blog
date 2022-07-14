---
title: JavaScript执行上下文之变量对象
date: 2022-07-13
categories: [JavaScript]
comments: true
---

# 执行上下文中包含哪些东西

对于每个执行上下文，都有三个重要属性：

- 变量对象(Variable object，VO)
- 作用域链(Scope chain)
- this

本篇就来讲讲第一个变量对象

<!-- more -->

# 全局上下文

- 在顶层 JavaScript 代码中，可以用关键字 this 引用全局对象。因为全局对象是作用域链的头，这意味着**所有非限定性的变量和函数名都会作为该对象的属性来查询**。
- 例如，当 JavaScript 代码引用 parseInt() 函数时，它引用的是全局对象的 parseInt 属性。全局对象是作用域链的头，还意味着在顶层 JavaScript 代码中**声明的所有变量都将成为全局对象的属性**。
- 在浏览器中，全局对象有 window 指向自身

也就是说在全局执行上下文中，所有未限定的变量都挂在全局对象上，从全局对象中读写。比如:

```Javascript
var a = 1;
console.log(a);
console.log(this.a);
console.log(window.a);
console.log(this.window.a);
// 但是不能写
console.log(window.this.a);
```

# 执行过程

JavaScript 代码在进入一段代码环境时，会分为两个阶段：

1. 代码分析（进入执行上下文）
2. 代码执行

## 进入执行上下文

当进入执行上下文时，这时候还没有执行代码，

变量对象会包括三类：

1. 函数的所有形参 (如果是函数上下文)
   - 由名称和对应值组成的一个变量对象的属性被创建
   - 没有实参，属性值设为 undefined
2. 函数声明
   - 由名称和对应值（函数对象(function-object)）组成一个变量对象的属性被创建
   - 如果变量对象已经存在相同名称的属性，则完全替换这个属性
3. 变量声明
   - 由名称和对应值（undefined）组成一个变量对象的属性被创建
   - 如果变量名称跟已经声明的形式参数或函数相同，则变量声明不会干扰已经存在的这类属性

```Javascript
function foo(a) {
  var b = 2;
  function c() {}
  var d = function() {};

  b = 3;

}

foo(1);
```

在进入执行上下文后，这时候的 AO 是：

```json
AO = {
    arguments: {
        0: 1,
        length: 1
    },
    a: 1,
    b: undefined,
    c: reference to function c(){},
    d: undefined
}
```

## 代码执行

还是上面的例子，当代码执行完后，这时候的 AO 是：

```json
AO = {
    arguments: {
        0: 1,
        length: 1
    },
    a: 1,
    b: 3,
    c: reference to function c(){},
    d: reference to FunctionExpression "d"
}
```

# 思考题

## 第一题

```Javascript
function foo() {
    console.log(a);
    a = 1;  // 相当于挂在全局对象上
}

foo(); // ???
```

会报错，`Uncaught ReferenceError: a is not defined`

这是因为函数中的 "a" 并没有通过 var 关键字声明，所有不会被存放在 AO 中。

第一段执行 console 的时候， AO 的值是：

```json
AO = {
    arguments: {
        length: 0
    }
}
```

没有 a 的值，然后就会到全局去找，全局也没有，所以会报错。

```Javascript
function foo() {
    console.log(a);
    var a = 1;
}

foo(); // ???
```

改成这样，有变量提升就不会报错了。打印 undefined

或者先挂在全局对象上

```Javascript
function bar() {
    a = 1;
    console.log(a);
}
bar(); // ???
```

打印 1

## 第二题

```Javascript
console.log(foo);

function foo(){
    console.log("foo");
}

var foo = 1;
```

会打印函数，而不是 undefined 。

这是因为在进入执行上下文时，首先会处理函数声明，其次会处理变量声明，如果变量名称跟已经声明的形式参数或函数相同，则变量声明不会干扰已经存在的这类属性。

# 参考

- [JavaScript 深入之变量对象](https://github.com/mqyqingfeng/Blog/issues/5)
