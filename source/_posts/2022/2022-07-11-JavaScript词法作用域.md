---
title: JavaScript词法作用域
date: 2022-07-11
categories: [JavaScript]
comments: true
---

有两种作用域：

- 动态作用域
- 静态作用域（也叫：词法作用域，lexical scoping）

JavaScript 采用的是词法作用域

<!-- more -->

# 什么是作用域

作用域，顾名思义是用来表示一个变量作用的范围。

# 这两种作用域的区别是什么

让我们看一个例子就能知道：

```Javascript
var value = 1;

function foo() {
    console.log(value);
}

function bar() {
    var value = 2;
    foo();
}

bar();

// 结果是 ???
```

如果是静态作用域，那么答案是 1，因为 value 这个变量在函数定义的时候就已经决定了。如果是动态作用域，那么答案是 2，value 这个变量要等函数执行的时候才定下来。

## 静态作用域执行过程

执行 foo 函数，先从 foo 函数内部查找是否有局部变量 value，如果没有，就根据书写的位置，查找上面一层的代码，也就是 value 等于 1，所以结果会打印 1。而且如果去掉`var value = 1;`这一句，会报变量未定义错误。

## 动态作用域执行过程

执行 foo 函数，依然是从 foo 函数内部查找是否有局部变量 value。如果没有，就从调用函数的作用域，也就是 bar 函数内部查找 value 变量，所以结果会打印 2。

前面我们已经说了，JavaScript 采用的是静态作用域，所以这个例子的结果是 1。

bash 脚本采用的是动态作用域:

```bash
value=1
function foo () {
    echo $value;
}
function bar () {
    local value=2;
    foo;
}
bar
```

这个例子会打印 2

# 思考题

```Javascript
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

```Javascript
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

这两个例子中，虽然函数执行的环境不一样，但打印的结果是一样的，因为还是那个原因，JavaScript 的作用域是静态作用域

# 引用犀牛书中的一段话

> Like most modern programming languages, JavaScript uses lexical scoping. This means that functions are executed using the variable scope that was in effect when they were defined, not the variable scope that is in effect when they are invoked. In order to implement lexical scoping, the internal state of a JavaScript function object must in- clude not only the code of the function but also a reference to the current scope chain. (Before reading the rest of this section, you may want to review the material on variable scope and the scope chain in §3.10 and §3.10.3.) This combination of a function object and a scope (a set of variable bindings) in which the function’s variables are resolved is called a closure in the computer science literature. (This is an old term that refers to the fact that the function’s variables have bindings in the scope chain and that therefore the function is “closed over” its variables.)

> Technically, all JavaScript functions are closures: they are objects, and they have a scope chain associated with them. Most functions are invoked using the same scope chain that was in effect when the function was defined, and it doesn’t really matter that there is a closure involved. Closures become interesting when they are invoked under a different scope chain than the one that was in effect when they were defined. This happens most commonly when a nested function object is returned from the function within which it was defined. There are a number of powerful programming techniques that involve this kind of nested function closures, and their use has become relatively common in JavaScript programming. Closures may seem confusing when you first en- counter them, but it is important that you understand them well enough to use them comfortably.

> JavaScript, The Definite Guide

# 参考

- [JavaScript 深入之词法作用域和动态作用域](https://github.com/mqyqingfeng/Blog/issues/3)
