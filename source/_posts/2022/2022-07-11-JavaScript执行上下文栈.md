---
title: JavaScript执行上下文栈
date: 2022-07-11
categories: [JavaScript]
comments: true
---

JavaScript 总共有三种可执行的代码：

- 全局代码
- 函数代码
- eval 代码

对于每个执行上下文，都有三个重要属性：

- 变量对象(Variable object，VO)
- 作用域链(Scope chain)
- this

<!-- more -->

# 执行上下文栈

JavaScript 引擎创建了执行上下文栈（Execution context stack，ECS）来管理执行上下文

```JavaScript
var scope = "global scope";
function checkscope(){
    var scope = "local scope";
    function f(){
        return scope;
    }
    return f();
}
checkscope();
```

```JavaScript
var scope = "global scope";
function checkscope(){
    var scope = "local scope";
    function f(){
        return scope;
    }
    return f;
}
checkscope()();
```

上面这个例子中，执行上下文栈的变化就不一样

让我们模拟第一段代码：

```JavaScript
ECStack.push(<checkscope> functionContext);
ECStack.push(<f> functionContext);
ECStack.pop();
ECStack.pop();
```

让我们模拟第二段代码：

```JavaScript
ECStack.push(<checkscope> functionContext);
ECStack.pop();
ECStack.push(<f> functionContext);
ECStack.pop();
```

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

- [JavaScript 深入之执行上下文栈](https://github.com/mqyqingfeng/Blog/issues/4)
- [JavaScript 深入之变量对象](https://github.com/mqyqingfeng/Blog/issues/5)
