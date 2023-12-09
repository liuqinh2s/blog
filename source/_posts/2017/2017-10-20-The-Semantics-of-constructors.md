---
title: Inside the C++ Object Model 系列笔记 二 -- The Semantics of constructors
tags: [C++]
---

这一章详细的讨论了 constructor 如何工作，讨论构造一个对象的过程以及构造一个对象给程序带来的影响。

## 区分 trivial 和 notrivial

1. 只有编译器需要的时候(为什么会需要?后面讲的很清楚)，合成操作才是 nontrivial 的， 这样的构造函数才会被真正的合成出来;
2. 如果编译器不需要，而程序员又没有提供，这时的默认构造函数就是 trivial 的。虽然它在概念上存在，但是编译器实际上根本不会去合成出来，因为他不做任何没有意义的事情，所以当然可以忽略它不去合成。trivial 的函数只存在于概念上，实际上不存在这个函数。

<!-- more -->

## default constructor

A default constructor is a constructor which can be called with no arguments (either defined with an empty parameter list, or with default arguments provided for every parameter).

### 通常很多 C++程序员存在两种误解

- 没有定义默认构造函数的类都会被编译器生成一个默认构造函数。
- 编译器生成的默认构造函数会明确初始化类中每一个数据成员。

**被声明：declared，被定义：defined**。声明代表分配内存空间，定义代表初始化，也就是分配具体的值。

> 注意如果声明的是一个指针（或者在其他语言里声明了一个对象或者数组的引用），那么只会开辟一个指针的空间，真正的对象要到定义的时候，也就是初始化的时候，分配内存并初始化。

所以所有成员都在声明的时候被分配内存，构造函数的作用是初始化它们，non-object 成员需要程序员自己初始化，编译器不帮忙。

C++中对于默认构造函数的解释是:
**默认的构造函数会在需要的时候被编译器产生出来。**
这里非常重要的一点是:
谁需要?是程序的需要还是编译器的需要?如果是程序的需要，那是程序员的责任;
只有在是编译器的需要时，默认构造函数才会被编译器产生出来，而且被产生出来的默认构造函数只会执行编译器所需要的行动，而且这个产生操作只有在默认构造函数真正被调用时才会进行合成。

例如:成员变量初始化为 0 操作，这个操作就是程序的需要，而不是编译器的需要。

总结变量的初始化:

Global objects are guaranteed to have their associated memory “zeroed out” at program start-up. Local objects allocated on the program stack and heap objects allocated on the free-store do not have their associated memory zeroed out; rather, the memory retains the arbitrary bit pattern of its previous use.

只有全局变量和静态变量才会保证初始化，其中静态变量可以视为全局变量的一种，因为静态变量也是保存在全局变量的存储空间上的。
Golbal objects 的内存保证会在程序激活的时候被清 0；Local objects 配置于程序的栈中，Heap objects 配置于自由空间中，都不一定会被清为 0,它们的内容将是内存上次被使用后的痕迹!

全局变量和静态变量都放在 global data Segment 上，且在类被声明的时候就已经分配内存和初始化，也就是 **在任何对象被定义之前静态变量就已经存在了（即使该 class 没有任何 object 实体，static data members 也已经存在）。**

```C++
class Foo { public: int val; Foo *pnext; };
void foo_bar()
{
   // Oops:  program needs bar's members zeroed out
   Foo bar;
   if ( bar.val || bar.pnext )
      // ... do something
   // ...
}
```

When is a default constructor synthesized, then? Only when the implementation needs it. Moreover, the synthesized constructor performs only those activities required by the implementation. That is, even if there were a need to synthesize a default constructor for class Foo, that constructor would not include code to zero out the two data members val and pnext. For the previous program fragment to execute correctly, the designer of class Foo needs to provide an explicit default constructor that properly initializes the class’s two members.

意思是初始化 val 和 pnext 是程序员的责任，编译器不负责，所以你这里不初始化它们，它们存储的结果就是内存遗留的痕迹。

### 什么时候编译器会给你生成默认构造函数

首先你得没有写默认构造函数，编译器才会给你生成。有四类情况，编译器会给你加代码：

1. 类中有一个对象（成员变量），这个对象包含了默认构造函数
2. 继承自带有默认构造函数的基类的类
3. 带有虚函数的类
4. 继承自虚基类的类

如果 class A 内含一个或以上的 member objects，那么 A 的 constructor 必须调用每一个 member class 的默认构造函数。
具体方法是:编译器会扩张 constructors（注意：是所有的构造函数，不仅仅是默认构造函数会被扩张），在其中安插代码使得在 user code 被调用之前先调 用 member objects 的默认构造函数(当然如果需要调用基类的默认构造函数，则放在基类的 默认构造函数调用之后:基类构造函数->成员构造函数->user code)。
C++要求以“member objects 在 class 中的声明次序”来调用各个 construtors。这就是声明的次序决定了初始化次序的根本原因!(构造函数初始化列表一直要求以声明顺序来初始化)
所以你打乱 member initialization list 的顺序根本没有用哦~

理解了初始化列表中的实际执行顺序中“以 member 声明的次序”来决定的，就可以理解一些很 微妙的错误了。比如:

```C++
A() : i(99), j(66), value(foo()) {... }
int i, value, j;
```

这会不会产生错误取决于成员函数 foo()是依赖于 i 还是 j:
如果 foo 依赖于 i，由于 i 声明在 value 之前，所以不会产生错误;
如果 foo 依赖于 j，由于 j 声明在 value 之后，就产生了使用未初始化成员的错误。

带有 virtual functions 的类的默认构造函数毫无疑问是 nontrivial 的，需要编译器安插额外的
成员 vptr 并在构造函数中正确的设置好 vptr，这是编译器的重要职责之一。
继承自 virtual base class 的类的默认构造函数同样也毫无疑问的 nontrivial，编译器需要正确设置相关的信息以使得这些虚基类的信息能够在执行时准备妥当，这些设置取决于编译器实现虚基类的手法。

编译器有 4 种情况会使得编译器真正的为 class 生成 nontrivial 的默认构造函数，这个 nontrivial 的默认构造函数只满足编译器的需要(调用 member objects 或 base class 的默认构造函数、初始化 virtual function 或 virutal base class 机制)。其它情况时，类在概念上拥有默认构造函数，但是实际上根本不会被产生出来(前面的区分 trivial 和 nontrivial)。

对于一个 trivial 默认构造函数，编译器的态度是，既然它全无用处，干脆就不合成它。在这儿要厘清的是概念与实现的差别，概念上追求缜密完善，在实现上则追求效率，可以不要的东西就不要。

## copy constructor

有一个参数的类型是其类类型的构造函数是为拷贝构造函数。如下：

```C++
X::X( const X& x);
Y::Y( const Y& y, int =0 );
//可以是多参数形式，但其第二个即后继参数都有一个默认值
```

### 什么时候编译器会给你生成拷贝构造函数

> 其实和前面默认构造函数一样，四种情况

如果一个类没有定义拷贝构造函数，通常按照“成员逐一初始化(Default Memberwise Initialization)”的手法来解决“一个类对象以另一个同类实体作为初值”——也就是说把内建或派生的数据成员从某一个对象拷贝到另一个对象身上，如果数据成员是一个对象，则递归使用“成员逐一初始化(Default Memberwise Initialization)”的手法。

成员逐一初始化(Default Memberwise Initialization)具体的实现方式则是位逐次拷贝（Bitwise copy semantics）

Copy constructors 和默认构造函数一样，只有在必须的时候才会被产生出来，对于大部分的 class 来说，拷贝构造函数仅仅需要按位拷贝就可以。满足 bitwise copy semantics 的拷贝构造函数是 trivial 的，就不会真正被合成出来(与默认构造函数一样，只有 nontrivial 的拷贝构 造函数才会被真正合成出来)。对大多数类按位拷贝就够了，什么时候一个 class 不展现出 bitwise copy semantics 呢? 分为 4 种情况，前 2 种很明显，后 2 种是由于编译器必须保证正确设置虚机制而引起的。

- 当 class 内含一个 member object 而后者声明了(也可能由于 nontrivial 语意从而编译器 真正合成出来的)一个 copy constructor 时;
- 当 class 继承自一个存在有 copy constructor 的 base class(同样也可能是合成)时;
- 当 class 声明了一个或多个 virtual functions 时;(vf 影响了位语意，进而影响效率)
- 当 class 派生自一个继承串链，其中一个或多个 virtual base classes 时。

对于前两种情况，不论是基类还是对象成员，既然后者声明有拷贝构造函数时，就表明其类的设计者或者编译器希望以其声明的拷贝构造函数来完成“一个类对象以另一个同类实体作为初值”的工作，而设计者或编译器这样做——声明拷贝构造函数，总有它们的理由，而通常最直接的原因莫过于因为他们想要做一些额外的工作或“位逐次拷贝”无法胜任。

对于有虚函数的类，如果两个对象的类型相同那么位逐次拷贝其实是可以胜任的。但问题将出现在，如果基类由其继承类进行初始化时，此时若按照位逐次拷贝来完成这个工作，那么基类的 vptr 将指向其继承类的虚函数表，这将导致无法预料的后果——调用一个错误的虚函数实体是无法避免的，轻则带来程序崩溃，更糟糕的问题可能是这个错误被隐藏了。所以对于有虚函数的类编译器将会明确的使被初始化的对象的 vptr 指向正确的虚函数表。因此有虚函数的类没有声明拷贝构造函数，编译将为之合成一个，来完成上述工作，以及初始化各数据成员，声明有拷贝构造函数的话也会被插入完成上述工作的代码。

```C++
#include <iostream>
using namespace std;

class A {
public:
  virtual void f() { cout << "A::f()" << endl; }
  int i;
};

class B : public A {
public:
  void f(){ cout << "B::f()" << endl; }
};
int main(int argc, char const *argv[])
{
  B b;
  b.i=1;
  A a = b;
  A *p = &a;
  p->f();
  cout << p->i << endl;
  return 0;
}
```

上面例子可以看出，如果 A a = b;是 bitwise copy semantics 的话，a 内放置的就是 b 的 vptr。但其实不是，编译器给 a 生成了拷贝构造函数，初始化了 a 的 vptr。b 的 vptr 是由编译器给 b 生成的默认构造函数初始化的。但对于其他成员变量 bitwise copy semantics 依然有效，所以 i 的结果是 1。我在做这个试验的时候发现了一个有趣的现象：

```C++
#include <iostream>
using namespace std;

class A {
public:
  virtual void f() { cout << "A::f()" << endl; }
  int i;
};

class B : public A {
public:
  void f(){ cout << "B::f()" << endl; }
  int i;
};
int main(int argc, char const *argv[])
{
  B b;
  b.i=1;
  A a = b;
  A *p = &a;
  p->f();
  cout << p->i << endl;
  return 0;
}
```

两个 i 不是同一个 i，b.i=1;优先给 b 中的同名变量赋值了。这样的代码简直可怕。那么怎么访问到从 A 继承来的成员变量 i 呢，请看：

```C++
#include <iostream>
using namespace std;

class A {
public:
  virtual void f() { cout << "A::f()" << endl; }
  int i;
};

class B : public A {
public:
  void f(){ cout << "B::f()" << endl; }
  int i;
};
int main(int argc, char const *argv[])
{
  B b;
  b.A::i=6;
  b.B::i=1;
  A a = b;
  A *p = &a;
  cout << p->i << endl;
  return 0;
}
```

## 命名返回值优化

对于一个如 foo()这样的函数，它的每一个返回分支都返回相同的对象，编译器有可能对其做 Named return Value 优化（下文都简称 NRV 优化），方法是以一个参数 result 取代返回对象。

foo()的原型：

```C++
X foo()
{
    X xx;
    if(...)
        return xx;
    else
        return xx;
}
```

优化后的 foo()以 result 取代 xx：

```C++
void  foo(X &result)
{
    result.X::X();
    if(...)
    {
        //直接处理result
        return;
    }
    else
    {
        //直接处理result
        return;
    }
}
```

对比优化前与优化后的代码可以看出，对于一句类似于 X a = foo()这样的代码，NRV 优化后的代码相较于原代码节省了一个临时对象的空间（省略了 xx）,同时减少了两次函数调用（减少 xx 对象的默认构造函数和析构函数，以及一次拷贝构造函数的调用，增加了一次对 a 的默认构造函数的调用）。
