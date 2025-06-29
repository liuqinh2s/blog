---
title: JavaScript对象的继承有哪几种
tags: [javascript]
---

javascript 高级程序设计中有写，对象的继承总共有六种:

1. 原型链继承，子原型是父原型的一个实例
2. 借用构造函数继承，子构造函数调用父构造函数
3. 组合式继承(组合 1 和 2)
4. 原型式继承
5. 寄生式继承
6. 寄生式组合继承（组合 3 和 5）

<!-- more -->

## 原型链继承

```javascript
function Parent() {
  // Parent 的非引用属性
  this.a = 1;
  // Parent 的引用属性
  this.array = [1, 2, 3];
}
// Parent 的静态方法
Parent.prototype.func1 = () => {
  console.log("func1");
};
function Child() {
  this.b = 2;
}
Child.prototype = new Parent(); // 子原型是父原型的一个实例
Child.prototype.func2 = () => {
  console.log("func2");
};
const child1 = new Child();
const child2 = new Child();
child1.a = 3;
child1.array.push(4);
console.log(child2.a); // 1
console.log(child2.array); // [1, 2, 3, 4]
```

缺点是：由于**子原型是父原型的一个实例**，所以父类属性在子类的原型上，而不在每个子类的实例上，所以如果属性是引用类型时会互相影响。

## 借用构造函数继承

```javascript
function Parent() {
  // Parent 的非引用属性
  this.a = 1;
  // Parent 的引用属性
  this.array = [1, 2, 3];
}
// Parent 的静态方法
Parent.prototype.func1 = () => {
  console.log("func1");
};
function Child() {
  // 把父级属性绑定到子实例里面
  Parent.call(this);
  this.b = 2;
}
Child.prototype.func2 = () => {
  console.log("func2");
};
const child1 = new Child();
const child2 = new Child();
child1.array.push(4);
console.log(child2.array); // [1, 2, 3]
console.log(child1.func1); // undefined
```

解决了原型链继承中，属性没绑定到子实例里面的问题，但如果仅这样继承的话，父原型上的属性没有被继承

## 组合式继承

综合了以上两种继承方式，可以既继承原型，又把属性绑定到了子实例（从而覆盖原型的属性）

```javascript
function Parent() {
  // Parent 的非引用属性
  this.a = 1;
  // Parent 的引用属性
  this.array = [1, 2, 3];
}
// Parent 的静态方法
Parent.prototype.func1 = () => {
  console.log("func1");
};
function Child() {
  // 把父类属性绑定到子实例里面，此处第二次调用父构造函数
  Parent.call(this);
  this.b = 2;
}
Child.prototype = new Parent(); // 子原型是父原型的一个实例，此处第一次调用父构造函数
Child.prototype.func2 = () => {
  console.log("func2");
};
const child1 = new Child();
const child2 = new Child();
child1.array.push(4);
console.log(child2.array); // [1, 2, 3]
console.log(child1.func1); // func1
```

组合式继承效果是已经达到了，既把父类的实例属性绑定到了子类实例中，又把父类静态方法绑定到了子类原型上。

缺点是：

1. 父构造函数执行了两次
2. 父实例上存储了多余的属性（压根用不到），浪费内存

## 原型式继承

创建一个临时的构造函数，并把这个临时的构造函数的 prototype 指向父原型

```javascript
function myObject(ParentPrototype) {
  function F() {}
  F.prototype = ParentPrototype;
  return new F();
}
```

这样就避免了创建父类的实例，可以只使用父类的原型

> 相当于`Object.create()`，ECMAScript 5 通过增加 Object.create()方法将原型式继承的概念规范化了。这个方法接收两个参数：作为新对象原型的对象，以及给新对象定义额外属性的对象（第二个可选）。在只有一个参数时，Object.create()与这里的 myObject()方法效果相同

## 寄生式继承

在原型式继承的基础上，做了一个封装：

```javascript
function inheritPrototype(Child, Parent) {
  // 拷贝了一份父级的原型，而非生成父级的实例，所以上面没有父级的实例的属性
  const p = myObject(Parent.prototype);
  p.constructor = Child;
  Child.prototype = p;
}
```

## 寄生式组合继承

综合了寄生式继承和组合式继承，并克服了组合式继承的缺点

```javascript
function myObject(Parent) {
  function F() {}
  F.prototype = Parent;
  return new F();
}
function inheritPrototype(Child, Parent) {
  // 拷贝了一份父级的原型，而非生成父级的实例，所以上面没有父级的实例的属性
  const p = myObject(Parent.prototype);
  p.constructor = Child;
  Child.prototype = p;
}
function Parent() {
  // Parent 的非引用属性
  this.a = 1;
  // Parent 的引用属性
  this.array = [1, 2, 3];
}
// Parent 的静态方法
Parent.prototype.func1 = () => {
  console.log("func1");
};
function Child() {
  // 把父类属性绑定到子实例里面
  Parent.call(this);
  this.b = 2;
}
inheritPrototype(Child, Parent);
Child.prototype.func2 = () => {
  console.log("func2");
};
const child1 = new Child();
const child2 = new Child();
child1.array.push(4);
console.log(child2.array); // [1, 2, 3]
console.log(child1.func1); // func1
```

ES6 的 class 语法糖，就是寄生式组合继承

## 参考

- [JavaScript 高级程序设计（第 4 版）](https://book.douban.com/subject/35175321/)
- [一文看懂 JS 的继承](https://www.freecodecamp.org/chinese/news/inheritance-in-js/)
