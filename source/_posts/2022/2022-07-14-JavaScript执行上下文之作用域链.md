---
title: JavaScript执行上下文之作用域链
tags: [JavaScript]
---

执行上下文中有个作用域链，当查找一个变量时会顺着这个链找。

函数的作用域在函数定义的时候就决定了。这是因为函数对象有个内部属性`[[scope]]`

函数的生命周期分为：**函数创建** 和 **函数调用**。

函数创建的时候，会把其所处执行上下文的作用域链直接赋值给函数的内部属性`[[scope]]`（这就是词法作用域的原理了），函数调用的时候会创建自己的执行上下文，并把自己的`AO`和`[[scope]]`合并成新的作用域链：

> 假设要实现动态作用域的话，`[[scope]]`就得在调用时去执行上下文栈的上一帧去取。

```JavaScript
Scope = [AO].concat([[scope]]);
```

<!-- more -->

# 实例剖析

```javascript
var scope = "global scope";
function checkscope() {
  var scope2 = "local scope";
  return scope2;
}
checkscope();
```

执行过程如下：

1. 全局执行上下文创建，其作用域链就只有自身的 VO，然后将全局上下文压栈：

```javascript
ECStack = [];
globalContext = {
  VO,
  Scope: [VO],
  this: window,
};
ECStack.push(globalContext);
```

2. checkscope 函数被创建，保存当前执行上下文的作用域链到 checkscope 函数的内部属性`[[scope]]`（这一步是词法作用域实现的关键）

```javascript
checkscope.[[scope]] = globalContext.Scope;
```

4. 调用 checkscope 函数，函数并不立刻执行，开始做准备工作，生成执行上下文，并压入执行上下文栈：

- AO：用 arguments 创建活动对象，随后初始化活动对象，加入形参、函数声明、变量声明
- Scope：复制函数`[[scope]]`属性创建作用域链，将活动对象压入 checkscope 作用域链顶端
- this

```javascript
checkscopeContext = {
  AO: {
    arguments: {
      length: 0,
    },
    scope2: undefined,
  },
  Scope: [AO, [[Scope]]],
};
ECStack.push(checkscopeContext);
```

5. 准备工作做完，开始执行函数，随着函数的执行，修改 AO 的属性值，查找到 scope2 的值，返回后函数执行完毕，函数上下文从执行上下文栈中弹出

```javascript
checkscopeContext = {
  AO: {
    arguments: {
      length: 0,
    },
    scope2: "local scope",
  },
  Scope: [AO, [[Scope]]],
};
ECStack.pop();
```

每一步中具体的实现细节我们无法得知（因为可以有多种实现手法），但这 5 步却是真实存在的（因为可以通过例子验证）。
