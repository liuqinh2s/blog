---
title: 实现一个高效的deepClone
date: 2023-11-01
categories: [js]
tags: [js]
comments: true
---

最近 EDA 项目在解决一些性能上的问题，首当其冲的就是 deepClone，各种地方都在用，且十分卡性能。如何解决这个问题呢？

由于我们项目中的 deepClone 是一个递归版本的 deepClone，所以应该可以通过把它改成迭代版的 deepClone 来提速。

用栈来实现迭代。函数调用栈本身也是栈，但开销肯定比自己写的栈要大一些。

<!-- more -->

```javascript
function toString(a) {
  return Object.prototype.toString.call(a).slice(8, -1);
}

function isObj(a) {
  return toString(a) === "Object";
}

function isNum(a) {
  return toString(a) === "Number";
}

function isStr(a) {
  return toString(a) === "String";
}

function isBool(a) {
  return toString(a) === "Boolean";
}

function isSymbol(a) {
  return toString(a) === "Symbol";
}

function isBigInt(a) {
  return toString(a) === "BigInt";
}

function isFunction(a) {
  return toString(a) === "Function";
}

function isRegExp(a) {
  return toString(a) === "RegExp";
}

function isDate() {
  return toString(a) === "Date";
}

function isError() {
  return toString(a) === "Error";
}

function

function isPrim(a) {
  return (
    isNum(a) ||
    isStr(a) ||
    isBool(a) ||
    isSymbol(a) ||
    isBigInt(a) ||
    isFunction(a) ||
    a === null ||
    a === void 0
  );
}

function deepCloneStack(obj) {
  if (isPrim(obj)) {
    return obj;
  }
  const root = Array.isArray(obj) ? [] : {};
  const stack = [[{ root }, obj, "root"]];

  while (stack.length > 0) {
    let [target, obj, key] = stack.pop();
    if (Array.isArray(obj)) {
      if (!target[key]) {
        target[key] = new Array(obj.length);
      }
      for (let k = 0; k < obj.length; k++) {
        if (isPrim(obj[k])) {
          target[key][k] = obj[k];
        } else {
          stack.push([target[key], obj[k], k]);
        }
      }
    } else {
      if (!target[key]) {
        target[key] = {};
      }
      for (let k in obj) {
        if (isPrim(obj[k])) {
          target[key][k] = obj[k];
        } else {
          stack.push([target[key], obj[k], k]);
        }
      }
    }
  }
  return root;
}
```

[在线运行地址](https://replit.com/@liuqinh2s/deepClone#script.js)

不过很遗憾的是迭代版本速度比递归还要慢，估计是因为 js 的数组性能太差导致的。
