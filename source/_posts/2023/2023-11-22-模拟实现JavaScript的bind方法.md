---
title: 模拟实现JavaScript的bind方法
date: 2023-11-22
categories: [JavaScript]
comments: true
---

bind 函数我们经常用到，主要用于换绑 this。其返回值是一个方法。此外我们还可以把一些参数固定下来，相当于封装了一个简易函数。

<!-- more -->

## 换绑 this:

```javascript
const obj = {
  bbb: "hello",
  sayHi,
};

function sayHi() {
  console.log("Hi", this.bbb);
}

sayHi();
const a = sayHi.bind(obj);
a();
```

## 减少参数：

```javascript
const obj = {
  bbb: "hello",
  sayHi,
};

function sayHi(a, b) {
  console.log("Hi", this.bbb, a, b);
}

sayHi();
const a = sayHi.bind(obj, "jjjj");
a("123");
```

不过如果 bind 返回的方法用作构造函数的话，绑定 this 动作就失效了，且会返回原方法构造出的新对象。

## 用作构造函数：

```javascript
const obj = {
  bbb: "hello",
  sayHi,
};

function sayHi(a, b) {
  console.log(this, this.bbb);
}

const a = sayHi.bind(obj, "jjjj");
a();
const b = new a();
console.log(b);
```

基于这些特性我们自己模拟实现一个 bind 方法：

```javascript
Function.prototype.bindFn = function bind(thisArg) {
  if (typeof this !== "function") {
    throw TypeError(this + "is not a function");
  }
  const self = this;
  const bindArgs = [].slice.call(arguments, 1);
  function bound() {
    const boundArgs = [].slice.call(arguments);
    const finalArgs = bindArgs.concat(boundArgs);
    if (new.target === bound) {
      return new self();
    } else {
      return self.apply(thisArg, finalArgs);
    }
  }
  return bound;
};
```

## 函数的`.name`和`.length`属性

此外函数还有一些默认行为，比如`.name`打印函数名和`.length`打印形参个数。如果是 bind 函数返回的话，会在前面加个`bound `

```javascript
console.log(Function.prototype.bind.name); // bind
console.log(Function.prototype.bind().name); // bound
const obj = {
  bbb: "hello",
  sayHi,
};

function sayHi(a, b, c) {
  console.log(this, this.bbb, b, c);
}

console.log(sayHi.name, sayHi.length); // sayHi 3

const a = sayHi.bind(obj, "jjjj");
console.log(a.name, a.length); // bound sayHi 2
console.log(function () {}.bind().name); // 'bound '
```

我们构建的 bind 在这个方面依旧跟原生 bind 的表现不一样：

```javascript
Function.prototype.bindFn = function bind(thisArg) {
  if (typeof this !== "function") {
    throw TypeError(this + "is not a function");
  }
  const self = this;
  const bindArgs = [].slice.call(arguments, 1);
  function bound() {
    const boundArgs = [].slice.call(arguments);
    const finalArgs = bindArgs.concat(boundArgs);
    if (new.target === bound) {
      return new self();
    } else {
      return self.apply(thisArg, finalArgs);
    }
  }
  return bound;
};

const obj = {
  bbb: "hello",
  sayHi,
};

function sayHi(a, b, c) {
  console.log(this, this.bbb);
}

const a = sayHi.bindFn(obj, "jjjj");
console.log(a.name, a.length); // bound 0
const b = sayHi.bind(obj, "jjjjj");
console.log(b.name, b.length); // bound sayHi 2
```

函数的`.name`和`.length`属性是无法修改的：

```javascript
var aa = function () {};
aa.name = "ccc";
aa.length = 4;
console.log(aa.name, aa.length);
```

## `new.target`的用处

如果用`this instanceof bound`来替代`new.target === bound`会有如下问题：

```javascript
function Student(name) {
  if (this instanceof Student) {
    this.name = name;
    console.log("name", name);
  } else {
    throw new Error("必须通过new关键字来调用Student。");
  }
}
var student = new Student("若");
var notAStudent = Student.call(student, "川"); // 不抛出错误，且执行了。
console.log(student, "student", notAStudent, "notAStudent");
```

可见并非是实例就可以，而必须是用 new 调用才是构造函数
