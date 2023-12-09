---
title: Inside the C++ Object Model 系列笔记 一 -- Object Lessons
tags: [C++]
---

> 多态：统一的接口，不同的实现

**C++多态（polymorphism）** 表示“以一个 public base class 的指针（或者 reference），寻址出一个 derived class object”

## Layout Costs for Adding Encapsulation(封装)

> 意思是：为了添加封装所需要付出的内存布局花销

第一章 Object Lessons 介绍了 C++如何在背后实现一个对象，内存中的布局以及空间上的关系。

**在计算机的原理中，要实现某个机制，我们总能找到很多种实现方式**（对比着学习，多思考每种实现方法的利弊），C++的类的实现也不例外，让我们对比以下三种实现方式：

<!-- more -->

### 三种对象实现模式

#### A Simple Object Model

![A Simple Object Model](../../../../images/简单对象模型.jpg)

可以看到，简单对象模型把所有的 data member 和 member function（函数指针）都放在对象里了。

#### A Table-driven Object Model

![A Table-driven Object Model](../../../../images/表驱动模型.jpg)

表驱动模型把 member 分为 data 和 function 两类，用两个指针分别指向两个表，一个存放所有的 data member，一个存放所有的 function 指针。

#### The C++ Object Model

![The C++ Object Model](../../../../images/C++对象模型.jpg)

```C++
template<class Type>
class Point3d{
public:
    Point3d(Type x, Type y, Type z) : x_(x), y_(y), z_(z) {}
    Type x() { return x_; }
private:
    Type x_, y_, z_;
}
```

上面的 C++ 类并不会比 C 语言 的 struct 耗费更多的内存空间，三个 data members 直接内含于 Object 中，member functions 则放在 Object 外。

C++的 data members 有两种：**static 和 nonstatic**

C++的 member functions 有三种：**static 、nonstatic 、virtual**

> 放在 Object 中的只有 nonstatic data members，其他的统统是放在 Object 外。

一个对象的内存布局大小(通常由 3 部分组成):

- 其 nonstatic data member 的总和大小;
- 任何由于位对齐所需要的填补上去的空间;(关于内存对齐，自己查)
- 为了支持 virtual 机制而引起的额外负担。

### data members 在内存中的布局

`C++`只保证处于同一个 access section（也就是 private,public,protected 片段）的数据，一定会以声明的次序出现在内存布局当中(要求较晚出现的数据成员处在较大的内存地址中)。
`C++`标准只提供了这一点点的保证。
允许编译器将多个 Access Section 的顺序自由排列，而不必在乎它们的声明次序。但似乎没有编译器这样做。
对于继承类，C++标准并未指定是其基类成员在前还是自己的成员在前。

```C++
class X {
public:
   int i;
   int j;
private:
   int k;
   int n;
}
```

数据 i 一定在 j 之前，k 一定在 n 之前。其他顺序就看编译器了。

### Virtual Table(vtbl, vtable) 和 vptr

Virtual function 机制由以下 2 个步骤来支持：

1. 每个 class 产生的 Virtual function 的指针放在 Virtual Table 中
2. 编译器给每个 class object 添加一个指针 vptr，指向相应的 vtable

一个 vtable 对应一个 class，一个 vptr 才对应一个 class object，必须区分开这 2 个概念。vtable 独立于对象，就跟函数独立于对象一样。这样所有对象才能共享它们，就像 static data members 被共享一样。

`nonstatic data member`是对象独有的，每个对象都有自己的一份。而其他的 member 全都是公用的。其实这里可以顺便学一下[序列化](https://zh.wikipedia.org/zh/序列化)这个概念，思考一下序列化对象的时候哪些东西需要存储。

RTTI(run-time type identification):一般来说，每一个 class 相关联的 type_info 对象的指针通常也保存在 vtable 的第一个 slot 中。关于 type_info 是什么，可以自己查。

### 引入继承后的对象模型成本

- 如果是普通继承，父对象被直接包含在子对象里面，这样父对象的存取也是直接进行的，没有额外的指针成本。
- 如果是虚拟继承，父对象由一个指针指出来，这样父对象的存取就必须由指针访问，添加了一层间接性。

virtual base class，用以实现 “多次出现在继承体系中的 base class，有一个单一而被共享的实例”

![虚基类](../../../../images/虚基类.jpg)

![虚拟多重继承](../../../../images/虚拟多重继承.jpg)

```C++
class A { public: void Foo() {} };
class B : public virtual A {};
class C : public virtual A {};
class D : public B, public C {};
```

> 我觉得这里有个问题，class D 继承 class B 和 class C 的时候并不是虚继承，所以何不将 B 和 C 直接放在 D 中呢？这样就省了两次指针。

这是我看到的一个讲的很不错的博客：[虚拟继承](https://liuhongjiang.github.io/hexotech/2012/11/30/virtual-inheritance/)

## struct 和 class 关键字的区别

总共就两个区别：

- struct defaults to public access and class defaults to private access.
- When inheriting, struct defaults to public inheritance and class defaults to private inheritance. (Ironically, as with so many things in C++, the default is backwards: public inheritance is by far the more common choice, but people rarely declare structs just to save on typing the “public” keyword). 哈哈，我觉得这么做的目的无非就是提醒你注意封装，不要给外部暴露没必要的东西，所以才把默认搞成 private。

除此之外 struct 和 class 一样。

struct 用来表现那些只有数据的集合体 POD(Plain Old Data)、而 class 则希望表达的是`ADT(abstract data type)`的思想。

> POD stands for Plain Old Data - that is, a class (whether defined with the keyword struct or the keyword class) without constructors, destructors and virtual members functions.

由于这 2 个关键字在本质上无区别，所以 class 并没有必须要引入，但是引入它的确非常令人满意，因为这个语言所引入的不止是这个关键字，还有它所支持的封装和继承的哲学。可以这样想象：struct 只剩下方便 C 程序员迁徙到 C++的用途了。

## programming paradigms

C++支持三种形式的编程风格(或称典范 paradigm):

- 面向过程的风格（procedural model）: 就像 C 一样，一条语句接一条语句的执行或者函数跳转;
- 抽象数据类型模型(abstract data type model，ADT): 仅仅使用了 class 的封装，很多人都是 在用基于对象的风格却误以为自己在使用面向对象的风格;
- 面向对象的风格(object-oriented): 使用了 class 的封装和多态的编程思维(多态才是 真正的面向对象的特征)。

纯粹以一种 paradigm 写程序，有助于整体行为的良好稳固。

> 一个 reference 通常是以一个指针来实现的，所以 point 和 reference 并没有本质的区别，reference 和 const 指针的区别就是，你取 reference 指针的地址的时候，取到的是数据的地址，const 指针取地址取到的是指针的地址。下面的程序说明了这一点：

```C++
#include <iostream>

using namespace std;

int main(){
  int a=1;
  int &b=a;
  const int *p = &a;
  cout << &b << endl;
  cout << p << endl;
  cout << &p << endl;
}
```

也就是说你取不到 b 的地址。所以说引用相当于一个 `别名`。引用常用在函数调用里，可以直接操作原有对象，这样就可以不用写指针的指针这种绕弯的东西了。

> 函数的实参传递给形参是值传递，也就是一个 copy，形参在函数里将是一个局部变量。这个特性是许多新手面临的大坑。一道经典的考察题目便是，实现一个 C 语言的 swap 函数，由于 C 语言没有引用，你就只能用指针来操作原有对象了。java 更坑，java 没有指针，所以需要用引用，但基础数据类型没有引用，所以你如果要交换基础数据类型的话，根本没办法写 swap 函数。

> 如果你对 C 语言的程序栈很了解的话，就会知道形参实际上是不存在的，实参直接拷贝到了寄存器中，所以底层上来说参数都是值拷贝，而且操作结果无法写回到实参，实参稳稳的放在上一个栈帧中从未发生任何变化。具体的细节可以看：[《CSAPP》读书笔记 -- 第 3 章：程序的机器级表示](../../../../2018/10/08/程序的机器级表示/#过程调用例子)

## 指针的类型

- 对于内存来说，不同类型的指针并没有什么不同。它们都是占用一个 word 的大小（所以 word 的大小决定了内存可访问空间的大小，32 位系统是 4 字节，64 位系统是 8 字节），包含一个数字，这个数字代表内存中的一个地址;
- 指针的类型是编译器的概念，对于硬件来说，并没有什么指针类型的概念;
- 转型操作也只是一种编译器的指令，它改变的是编译器对被指内存的解释方式而已!
- `void*`指针只能够持有一个地址（一个字节），而不能通过它操作所指向的 object
