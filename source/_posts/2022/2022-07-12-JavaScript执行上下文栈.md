---
title: JavaScript执行上下文栈
tags: [JavaScript]
---

# 顺序执行？

代码示例 1：

```Javascript
var foo = function () {

    console.log('foo1');

}

foo();  // foo1

var foo = function () {

    console.log('foo2');

}

foo(); // foo2
```

代码示例 2：

```Javascript
function foo() {

    console.log('foo1');

}

foo();  // foo2

function foo() {

    console.log('foo2');

}

foo(); // foo2
```

第一个例子中用到了变量提升，第二个例子中用到了函数提升。JavaScript 引擎并非一行一行地分析和执行程序，而是一段一段地分析执行。当执行一段代码的时候，会进行一个“准备工作”。到底 JavaScript 引擎遇到一段怎样的代码时才会做“准备工作”呢？

<!-- more -->

# 可执行代码

JavaScript 总共有三种可执行的代码：

- 全局代码
- 函数代码
- eval 代码

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

# 执行上下文中包含哪些东西

对于每个执行上下文，都有三个重要属性：

- 变量对象(Variable object，VO)
- 作用域链(Scope chain)
- this

# 参考

- [JavaScript 深入之执行上下文栈](https://github.com/mqyqingfeng/Blog/issues/4)
