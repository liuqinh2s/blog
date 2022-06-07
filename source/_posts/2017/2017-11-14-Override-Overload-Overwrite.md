---
title: Override Overload Overwrite
date: 2017-11-14
categories: [计算机基础]
comments: true
---

我们都知道有些东西容易混淆，在加上中文翻译得乱七八糟，更加让人困惑。今天我要讲的这三位可就真是绝了。

它们是：Override、Overload、Overwrite。

<!-- more -->

这是我查有道词典时候看到的可怕一幕：

![006zFO3ggy1flhl8a9e69j312w0tatf9.jpg](https://i.loli.net/2019/12/09/LAIVFxpekMXyogD.jpg)

Override 一个把三个名字都占了，你怕不怕？反正我是看的心里一紧。

如果把概念都煮成了一锅粥，那还不如不要记这些概念，你应该向更深层次去探寻。就这三个的区别来说，我觉得主要理解两个概念就行了：

1. 函数签名（signature）
2. 多态（polymorphism、polymorphic）

## 函数签名

函数签名是什么，其实就是用来区别函数的，两个函数怎么样认定是不同的两个函数呢，只有两个方面：

1. 函数名
2. 参数

有人说还有返回值啊，不行，返回值不能作为函数签名的一部分，因为你调用一个函数的时候，返回值根本不能帮助编译器来识别你用的是哪个函数，比如：

```C++
int func(int a, int b);
float func(int a, int b);

func();
```

请问我使用的是哪个函数？你看返回值确实不行吧。

## 多态

多态是面向对象编程的概念，你可以看看它的准确定义：

Polymorphism，定义很简短：polymorphism is the provision of a single interface to entities of different types.

如果父类有一个函数，子类也定义了一个完全相同的函数（函数签名相同），那么你可以用父类指针（或者说父类对象）作为统一的接口，来调用子类的方法。比如：

```C++
class Vehicle{
    public void move(){
        System.out.println(“Vehicles can move!!”);
    }
}

class MotorBike extends Vehicle{
    public void move(){
        System.out.println(“MotorBike can move and accelerate too!!”);
    }
}
class Car extends Vehicle{
    public void move(){
        System.out.println(“Hi! I am a car!”);
    }
}

class Test{
    public static void main(String[] args){
        Vehicle vh = new MotorBike();
        vh.move();    // prints MotorBike can move and accelerate too!!
        vh = new Vehicle();
        vh.move();    // prints Vehicles can move!!
        vh = new Car();
        vh.move();   // prints Hi! I am a car!
    }
}
```

多态的好处是可以扩展啊，比如我后来又多了个 truck 类，我不需要去动已经写好的代码，只要把 truck 模块写好，加进去就行了。

## Override、Overload、Overwrite 的区别

好了，知道了这两个概念，我们再来看看上面的那三个混在一起的东西：

- Override（推翻，对英文意思就是这个）subclass method overrides base class method means:
  - in different range (in derived class and base class)
  - the same function signature
  - the base class method is virtual（if in C++）
- overload（超载）function overloading means:
  - the same range (in the same class)
  - the same function name
  - but different function signature
- overwrite（重写）subclass method hides base class method means:
  - in different range (in derived class and base class)
  - the same function name

我们应该记住只有 Override 才跟多态有关。

Overload 是本 class 里面的不同函数（只不过函数名一样罢了，其实是两个不同的函数，看两个函数是否是同一个函数就看函数签名就行了），其实没啥稀奇的，不就是函数名一样嘛。函数签名一样，区分出是用父类还是子类的函数，这才是面向对象和多态要解决的问题。

## Override 和 Overwrite 的区别

> 比较容易混淆的其实是 Override 和 Overwrite，但你只要死记住：Override 必须函数签名要一样，而 Overwrite 只需函数名一样即可。另外 C++ 中一定要用 virtual 才算 Override，而 Java 默认就是 Override，不需要修饰词。

> 这里关于 Java 和 C++ 面向对象的细节区别可以写一大堆，比如：C++ class 后面是要加分号的，而 Java 不需要；但 Java 的类名是和文件名要一致的，而且只能有一个 public 类，而 C++不需要；Java 直接就能用 Override，而 C++必须要使用 virtual 关键字才能使用 Override（虚函数）；Java 的抽象方法跟 C++的纯虚函数对应。Java 是单继承，由接口来实现“多继承”，C++是多继承，没有接口，只有抽象类。C++还有个虚基类的概念。具体的写法上还有很多的不同，多用这两种语言写面向对象的代码，就慢慢会知道了。

C++ 有一个 virtual 关键字和 virtual table 这个概念，没有加 virtual 的父类函数是不可能形成多态的，如果这时候你碰到父类和子类两个里面有同名的函数，那么就属于 Overwrite 这个概念了，你其实也可以称这种覆盖掉父类函数的行为为：hide 隐藏。Java 这种语言里面没有 virtual 这一套，Java 也可以表现出 Overwrite，但要注意函数签名如果一样的话，那又不叫 Overwrite 了，应该叫 Override 了（Java 如果要在子类中使用父类的同函数签名方法，则必须使用 super 关键字）。而 C++ 不一样，即便是函数签名一样，如果前面不加 virtual 是不能叫 Override 的，仍然属于 Overwrite 的概念。请看下面的例子：

用 C++ 写的话：

```C++
#include <iostream>

using std::cout;
using std::endl;

class A{
public:
    void func(int a){
        cout << "A" << endl;
    }
};

class B:public A{
public:
    void func(int a){
        cout << "B" << endl;
    }
};

int main(){
    A *a = new B();
    a->func(1);
    ((B*)a)->func(1);
    return 0;
}
```

结果输出：

```
A
B
```

可以看到，C++必须要用子类类型的指针才能访问到子类的部分（建议看一本书，叫：Inside the C++ Object Model，中文叫：深入 C++对象模型，里面讲对象的内存布局讲的很清楚），java 也一样，必须转成子类型的指针才能访问，否则 IDE 会报错提示你。

Java 代码：

```C++
public class test {

    class A{
        void func(int a){
            System.out.println("A");
        }
    }
    class B extends A{
        void func(int a, int b){
            System.out.println("B");
        }
    }

    public static void main(String[] args){
        test t = new test();
        A a = t.new B();
        a.fun(1);
        ((B)a).func(1,2);
    }
}
```

结果输出：

```
A
B
```

为什么 Java 代码里不像 C++ 代码里面那样，使用两个函数签名相同的函数？因为前面说过了，那样的话就变成 Override 了，只有在 C++ 里才能实现函数签名相同的 Overwrite（不使用 virtual 即可）。
