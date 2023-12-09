---
title: Inside the C++ Object Model 系列笔记 三 -- The Semantics of Data
tags: [C++]
---

C++对象模型的细节，讨论了 data members 的处理。

## 空类在内存中有空间吗

<!-- more -->

一个实例引出的思考：

```C++
class X{};
class Y:virtual public X{};
class Z:virtual public X{};
class A:public Y, public Z{};
```

猜猜 sizeof 上面各个类都为多少？

Lippman 的一个法国读者的结果是：

```
sizeof X yielded 1
sizeof Y yielded 8
sizeof Z yielded 8
sizeof A yielded 12
```

Lippman 自己的结果是：

```
sizeof X yielded 1
sizeof Y yielded 4
sizeof Z yielded 4
sizeof A yielded 8
```

事实上，对于像 X 这样的一个空类，编译器会对其动点手脚——隐晦的插入一个字节。为什么要这样做呢？插入了这一个字节，那么 X 的每一个对象都将有一个独一无二的地址。
如果不插入这一个字节呢？哼哼，那对 X 的对象取地址的结果是什么？两个不同的 X 对象间地址的比较怎么办？

我们再来看 Y 和 Z。首先我们要明白的是实现虚继承，将要带来一些额外的负担——额外需要一个某种形式的指针。到目前为止，对于一个 32 位的机器来说 Y、Z 的大小应该为 5，而不是 8 或者 4。我们需要再考虑两点因素：内存对齐（alignment—）和编译器的优化。

空类也有 1Byte 的大小，因为这样才能使得这个 class 的 2 个 objects 在内存中有独一无二的地址。

## The Binding of a Data Member

考虑下面这样的代码：

```C++
extern float x;

class Point3d{
public:
   Point3d(float, float, float);
   //问题是 x 到底是哪个 x 呢
   float X() const {return x;}
   void X(float new_x) const{x = new_x;}
private:
   float x;
}
```

对 member functions 本身的分析会直到整个 class 的声明都出现了才开始（直到看到代表 class 结束的}右大括号）。所以 class 的 member functions 可以引用声明在后面的成员，C 语言就做不到。

和 member functions 对比，需要十分注意的一点是:
class 中的 typedef 并不具备这个性质。
因此，类中的 typedef 的影响会受到函数与 typedef 的先后顺序的影响。

```C++
typedef int length;
class Point3d{
public:
   void f1(length l){ cout << l << endl; }
   typedef string length;
   void f2(length l){ cout << l << endl; }
};
```

这样 f1 绑定的 length 类型是 int;
而 f2 绑定的 length 类型才是 string。

所以，对于 typedef 需要防御性的程序风格:
始终把 nested type 声明(即 typedef)放在 class 起始处!

## Data Member Layout

C++只保证处于同一个 access section（也就是 private,public,protected 片段）的数据，一定会以声明的次序出现在内存布局当中(要求较晚出现的数据成员处在较大的内存地址中)。
C++标准只提供了这一点点的保证。
允许编译器将多个 Acess Section 的顺序自由排列，而不必在乎它们的声明次序。但似乎没有编译器这样做。
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

数据 i 一定在 j 之前，k 一定在 n 之前。具体什么顺序就看编译器了。

传统上，vptr 被安放在所有被明确声明的 member 的最后，不过也有些编译器把 vptr 放在最前面(MSVC++就是把 vptr 放在最前面，而 G++ 是把 vptr 放在最后面)。

## Access of a Data Member

在 C++中，直观上来说，由一个对象存取一个 member 会比由一个指针存取一个 member 更快捷。
但是对于经由一个对象来存取和由一个指针来存取一个静态的 member 来说，是完全一样的，都会被编译器所扩展。

经由 member selection operators（也就是 “.” 运算符）对一个 static data member 进行存取操作只是一种语法上的便宜行事而已。member 其实并不在 class object 中，因此存取并不需要通过 class object。

经由一个函数调用的结果来存取静态成员，C++标准要求编译器必须对这个函数进行求值，虽然这个求值的结果并无用处。

foo().static_member = 100;

foo()返回一个类型为 X 的对象，含有一个 static_member，foo()其实可以不用求值而直接访 问这个静态成员，但是 C++标准保证了 foo()会被求值，可能的代码扩展为:

```C++
(void) foo();
X::static_member = 100;
```

## static data members

如果有两个 class ，每个都声明了一个 static member freelist，那么当他们都被放在程序的 data segment 时，就会导致名称冲突。编译器的解决方法是暗中对每一个 static data member 编码（这种手法有个很美的名称：name-mangling），以获得一个独一无二的程序识别代码。有多少种编译器就有多少种 name-mangling 做法！通常不外乎是表格啦，语法措辞啦等等。任何 name-mangling 都有两个要点：

1. 一种算法，推导出独一无二的名称。
2. 万一编译系统（或环境工具）必须和使用者交谈，那些独一无二的名称可以轻易被推导回原来的名称。

## nonstatic data members

Nonstatic data members are stored directly within each class object and cannot be accessed except through an explicit or implicit class object. An implicit class object is present whenever the programmer directly accesses a nonstatic data member within a member function. For example, in the following code:

```C++
Point3d
Point3d::translate( const Point3d &pt ) {
   x += pt.x;
   y += pt.y;
   z += pt.z;
}
```

the seemingly direct access of x, y, and z is actually carried out through an implicit class object represented
by the this pointer. Internally, the function is augmented as follows:

```C++
// internal augmentation of member function
  Point3d
  Point3d::translate( const Point3d* this, const Point3d &pt ) {
     this->x += pt.x;
     this->y += pt.y;
     this->z += pt.z;
}
```

地址：`&origin._y;`和`&origin + ( &Point3d::_y - 1 );`是一样的。指向 data member 的指针，其 offset 值总是被加上 1。这样可以使编译系统区分出 “一个指针 data member 的指针，用以指向 class 的第一个 member”和“一个指向 data member 的指针，但是没有指向任何 member”两种情况(成员指针也需要有个表示 NULL 的方式，0 相当于用来表示 NULL 了，其它的就都要加上 1 了)。

## Inheritance and the Data Member

C++ Standard 保证:“出现在派生类中的 base class subobject 有其完整原样性!” 子类会被放在父类的对齐空白字节之后，因为父类的完整性必须得以保证，父类的对齐空白字节 也是父类的一部分，也是不可分割的。

请看下面例子：

```C++
class X{
public:
    int x;
    char c;
};
class X2:public X
{
public:
    char  c2;
};
```

X2 的布局应当是 x(4),c(1),c2(1),这么说来 sizeof(X2)的值应该是 8？错了，实际上是 12。原因在于 X 后面的三个字节的填充空白不能为 c2 所用。也就是说 X2 的大小实际上为：X(8)+c2(1)+填补（3）=12。这样看来编译器似乎是那么的呆板，其实不然，看一下下面的语句会发生什么？

```C++
X2 x2;
X x;
x2=x;
```

如果 X 后面的填充空白可以被 c2 使用的话，那么 X2 和 X 都将是 8 字节。上面的语句执行后 x2.c2 的值会是多少？一个不确定的值！这样的结果肯定不是我们想要的。

在多重继承的派生体系中，将派生类的地址转换为第 1 基类时成本与单继承是相同的，只需要改换地址的解释方式而已；而对于转换为非第 1 基类的情况，则需要对地址进行一定的 offset 操作 才行。
C++ Standard 并未明确 base classes 的特定排列次序，但是目前的编译器都是按照声明的次序来安放他们的。(有一个优化:如果第 1 基类没有 vtable 而后继基类有，则可能把它们调 个位置)。
多重继承中，可能会有多个 vptr 指针，视其继承体系而定:派生类中 vptr 的数目最多等于所有基
类的 vptr 数目的总和。
