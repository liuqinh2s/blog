---
layout: post
title: Inside the C++ Object Model 系列笔记 四 -- The Semantics of Function
date: 2017-10-23
categories: [Programming Language, C++]
comments: true
---

>c++支持三种类型的成员函数，分别为static,nostatic,virtual。每一种调用方式都不尽相同。

<!-- more -->

## nonstatic member function

C++的设计准则之一就是:nonstatic member function至少必须和一般的nonmember function 有相同的效率。
实际上，nonstatic member function 会被编译器进行如下的转换，变成一个普通函数:

Type1 X::foo(Type2 arg1) { ... }

会被转换为如下的普通函数:

void foo(X *const this, Type1 &__result, Type2 arg1) { ... }

改写函数原型，在参数中增加this指针，对每一个”nonstatic data member的存取操作”改为由this指针来存取

将member function重写为一个外部函数，经过”mangling”处理（不需要处理的加上 extern “C”）

实际上，普通函数、普通成员函数、静态成员函数到最后都会变成与C语言函数类似的普通函数，只是编译器在这些不同类型的函数身上做了不同的扩展，并放在不同的 scope 里面而已。

编译器内部会将成员函数等价转换为非成员函数，具体是这样做的:

1.改写成员函数的签名，使得其可以接受一个额外参数，这个额外参数即是this指针：

```C++
float Point::X();
//成员函数X被插入额外参数this
float Point:: X(Point* this );
```

当然如果成员函数是const的，插入的参数类型将为 const Point* 类型。

2.将每一个对非静态数据成员的操作都改写为经过this操作。

3.将成员函数写成一个外部函数，对函数名进行“mangling”处理，使之成为独一无二的名称。

可以看出，将一个成员函数改写成一个外部函数的关键在于两点，一是给函数提供一个可以直接读写成员数据的通道；
二是解决好有可能带来的名字冲突。第一点通过给函数提供一个额外的指针参数来解决，第二点则是通过一定的规则将名字转换，使之独一无二。

于是在VC中对于上面的例子中的成员函数的调用将发生如下的转换：

```C++
//p->X();被转化为
?X@Point@@QAEMXZ(p);
//obj.X();被转化为
?X@Point@@QAEMXZ(&obj);
```

覆盖（override）、重载（overload）、隐藏（hide, overwrite）的区别：

- 覆盖（也叫重写）是指在派生类中重新对基类中的虚函数（注意是虚函数）重新实现。即函数名和参数都一样（函数签名一样），只是函数的实现体不一样。
- 重载是指 **在同一个类中** 不同的函数使用相同的函数名，但是函数的参数个数或类型不同。调用的时候根据函数的参数来区别不同的函数。
- 隐藏是指派生类中的函数把基类中相同名字的函数屏蔽掉了。隐藏与另外两个概念表面上看来很像，很难区分，其实他们的关键区别就是在多态的实现上。

>C++多态（polymorphism）表示”以一个public base class的指针（或者reference），寻址出一个derived class object”

我专门写了一篇关于这些容易弄混的概念的文章：[Override Overload Overwrite](../2017/11/14/Override-Overload-Overwrite)

## Virtual Member Function

如果function()是一个虚拟函数，那么用指针或引用进行的调用将发生一点特别的转换——一个中间层被引入进来。例如：

```C++
// p->function()
//将转化为
(*p->vptr[1])(p);
```

- 其中vptr为指向虚函数表的指针，它由编译器产生。vptr也要进行名字处理，因为一个继承体系可能有多个vptr。
- 1是虚函数在虚函数表中的索引，通过它关联到虚函数function().

何时发生这种转换？答案是在必需的时候 -- 一个再熟悉不过的答案。当通过指针调用的时候，要调用的函数实体无法在编译期决定，必需待到执行期才能获得，所以上面引入一个间接层的转换必不可少。但是当我们通过对象（不是引用，也不是指针）来调用的时候，
进行上面的转换就显得多余了，因为在编译器要调用的函数实体已经被决定。此时调用发生的转换，与一个非静态成员函数(Nonstatic Member Functions)调用发生的转换一致。p.function()的处理就跟非静态成员函数一样了。

## Static Member Function

- 不能够直接存取其类中的非静态成员（nostatic members），包括不能调用非静态成员函数(Nonstatic Member Functions)。
- 不能声明为const、volatile或virtual
- 参数没有this
- 可以不用对象访问，直接 类名::静态成员函数 访问，当然，通过对象调用也被允许

需要注意的是通过一个表达式或函数对静态成员函数进行调用，被C++ Standard要求对表达式进行求值。如：

```C++
(a+=b).static_fuc();
func().static_fuc();
```

虽然省去对a+b求值对于static_fuc()的调用并没有影响，但是程序员肯定会认为表达式a+=b已经执行，一旦编译器为了效率省去了这一步，很难说会浪费多少程序员多少时间去查找这个bug。这无疑是一个明智的规定。func()返回一个对象。

vtable的内容：

- virtual class offset（有虚基类才有）
- topoffset
- typeinfo
- 继承基类所声明的虚函数实例，或者是覆盖（override）基类的虚函数
- 新的虚函数（或者是纯虚函数占位）

虚函数表的构造挺简单的：

![虚函数表的构造](https://i.loli.net/2018/04/25/5ae01bb4b32a9.gif)

从内存布局的角度看，类对象继承基类的时候只把基类的 nonstatic data member和member function（函数入口，也可以说是函数指针） 放进自己内存里，static data member和static function都在global address里面。然后就是虚函数表是复制了一份基类的虚函数表，然后把virtual实现了的部分替换掉，没实现的就不改，依然用父类的。然后虚函数表指针自然也要不一样，毕竟指向的内存地址不一样，对吧。

## Inside the C++ Object Model 系列笔记向导

- [Inside the C++ Object Model 系列笔记 一 -- Object Lessons](../../19/Inside-the-C++-Object-Model-系列笔记--Object-Lessons)
- [Inside the C++ Object Model 系列笔记 二 -- The Semantics of constructors](../../19/Inside-the-C++-Object-Model-系列笔记--The-Semantics-of-constructors)
- [Inside the C++ Object Model 系列笔记 三 -- The Semantics of Data](../../21/Inside-the-C++-Object-Model-系列笔记--The-Semantics-of-Data)
- [Inside the C++ Object Model 系列笔记 四 -- The Semantics of Function](../../23/Inside-the-C++-Object-Model-系列笔记--The-Semantics-of-Function)
