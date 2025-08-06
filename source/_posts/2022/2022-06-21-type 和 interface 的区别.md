---
title: type 和 interface 的区别
tags: [typescript]
---

## 相同点

### 都可以描述一个对象或者函数

interface

```typescript
interface User {
  name: string;
  age: number;
}

interface setUser {
  (name: string, age: number): void;
}
```

type

```typescript
type User = {
  name: string;
  age: number;
};

type setUser = (name: string, age: number) => void;
```

语法上 type 用等于号，interface 直接跟 class 一样使用。

<!-- more -->

### 都允许扩展

interface 和 type 都可以拓展，并且不是互相独立的，也就是说 interface 可以 extends type，type 也可以 extends interface。虽然效果差不多，但是两者语法不同。

interface extends interface

```typescript
interface Name {
  name: string;
}
interface User extends Name {
  age: number;
}
```

type extends type

```typescript
type Name = {
  name: string;
};
type User = Name & {
  age: number;
};
```

interface extends type

```typescript
type Name = {
  name: string;
};
interface User extends Name {
  age: number;
}
```

type extends interface

```typescript
interface Name {
  name: string;
}
type User = Name & { age: number };
```

扩展的语法也不一样，type 使用&进行扩展，interface 使用 extends 进行扩展

## 不同点

### type 可以而 interface 不行

type 可以声明基本类型别名，联合类型，交叉类型，元组等类型

```typescript
// 基本类型别名
type Name = string;

interface Dog {
  wang();
}

interface Cat {
  miao();
}

// 联合类型
type Pet = Dog | Cat;
// 交叉类型
type Nothing = Dog & Cat;
// 元组，具体定义数组每个位置的类型
type PetList = [Dog, Cat];
```

### interface 可以而 type 不行

interface 能够声明合并

```typescript
interface User {
  name: string;
  age: number;
}

interface User {
  sex: string;
}

/*
User 接口为 {
  name: string
  age: number
  sex: string 
}
*/
```
