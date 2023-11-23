---
title: 模拟实现JavaScript的apply和call方法
date: 2023-11-21
categories: [JavaScript]
comments: true
---

apply 和 call 的相同点是：

1. 都由一个函数调用
2. 第一个参数都是原函数的执行环境 this

不同点是：

apply 的第二个参数接收原函数的所有参数，而 call 从第二个参数开始跟原函数一样是打散的

代码如下：

```javascript
F(arg1, arg2, ...){}
F.apply(thisArg, [arg1, arg2, ...]);
F.call(thisArg, arg1, arg2, ...);
```

需要特别注意的是，如果是在非严格模式下，thisArg 如果为 null 或 undefined，就会被替换成全局对象（在浏览器中是 window）；如果为原始值，就会被替换成原始值的的自动包装对象。

<!-- more -->

```javascript
function getGlobalObject() {
  return this;
}

function generateFunctionCode(argsLength) {
  let res = "return arguments[0][arguments[1]](";
  for (let i = 0; i < argsLength; i++) {
    if (i > 0) {
      res += ",";
    }
    res += "arguments[2][" + i + "]";
  }
  res += ")";
  // 相当于 return 'arguments[0][arguments[1]](arguments[2][0], arguments[2][1], arguments[2][2]...)';
  return res;
}

Function.prototype.applyFn = function apply(thisArg, argsArray) {
  // 调用方必须是函数
  if (typeof this !== "function") {
    throw new TypeError(this + "is not a function");
  }
  // 非严格模式下，thisArg 如果为 null 或 undefined，就会被替换成全局对象
  if (thisArg === null || thisArg === void 0) {
    thisArg = getGlobalObject();
  }
  // 非严格模式下，thisArg 如果为原始值，就会被替换成原始值的的自动包装对象
  thisArg = new Object(thisArg);
  if (argsArray === null || argsArray === void 0) {
    argsArray = [];
  }
  if (argsArray !== new Object(argsArray)) {
    throw new TypeError("The second parameter must be an array like object.");
  }
  const hasOriginVal = thisArg.hasOwnProperty("fn");
  const originVal = thisArg["fn"];
  thisArg["fn"] = this;
  const code = generateFunctionCode(argsArray.length);
  const result = new Function(code)(thisArg, "fn", argsArray);
  if (hasOriginVal) {
    thisArg["fn"] = originVal;
  } else {
    delete thisArg["fn"];
  }
  return result;
};
```

以上代码涉及到了挺多知识点的：

1. 防御式编程，对参数进行校验：this, thisArg, argsArray
2. 细心，为了防止改到 fn，做了暂存
3. ES3 开始，非严格模式下，thisArg 的特殊处理
4. 如果不让用 ES6 的扩展运算符`...`，就要利用`new Function()`自己构造新的函数调用语句。apply 是 es5 的，所以不让用 es6 的语法很正常。
5. 在 ES3、ES5 中 undefined 是能修改的

借助以上结果，模拟实现 call 方法的话，如下：

```javascript
Function.prototype.callFn = function call(thisArg) {
  return this.applyFn(thisArg, [].slice.applyFn(arguments, [1]));
};
```

测试用例：

```javascript
const a = {
  name: "1",
  h,
};

function h(arg1) {
  console.log(arg1, this.name);
}

h.applyFn(a, ["7"]);
h.callFn(a, "8");
```

## 在 ES3、ES5 中 undefined 是能修改的

可能大部分人不知道。ES5 中虽然在全局作用域下不能修改，但在局部作用域中也是能修改的，不信可以复制以下测试代码在控制台执行下。虽然一般情况下是不会的去修改它。

```javascript
function test() {
  var undefined = 3;
  console.log(undefined); // chrome下也是 3
}
test();
```

所以判断一个变量 a 是不是 undefined，更严谨的方案是 `typeof a === 'undefined'`或者 `a === void 0;`这里面用的是 void，void 的作用是计算表达式，始终返回 undefined，也可以这样写 void(0)。

## 参考

- [Function() constructor - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/Function)
- [void 运算符 - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/void)
- [为什么用「void 0」代替「undefined」](https://github.com/lessfish/underscore-analysis/issues/1)
- [undefined - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/undefined)
- [面试官问：能否模拟实现 JS 的 call 和 apply 方法 - 掘金](https://juejin.cn/post/6844903728147857415)
