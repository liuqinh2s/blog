---
title: 札记
date: 2018-11-03 14:59:45
---

这里主要用来记录我生活中的所思所想，当然大部分可能是跟计算机、编程有关的。这些想法或者摘抄比较短小，不足以形成一篇文章，但仍然值得记录下来反复品味，回顾。它们的编排方式是按日期来的。

# 2018-11-03

No programming language is perfect. There is not even a single best language; there are only languages well suited or perhaps poorly suited for particular purposes.

Shell scripting hearkens back to the classic UNIX philosophy of breaking complex projects into simpler subtasks, of chaining together components and utilities.

> Unix 的哲学就是将复杂的任务打破成多个简单的小任务，然后把工作流拼接起来。甚至在设计软件和工具型的程序时也是遵循这种思想，这种做法对程序员来说是一种直觉，这种思想就蕴含在编程中，但普通用户只喜欢傻瓜式操作。而 Windows 则倾向于迎合普通用户，打造集成环境，尽管许多集成环境都由不少重复的小轮子组成，但我们不缺硬盘空间和内存空间。

运用抽象是走向代码优化的第一步。面向接口编程。面向抽象编程。

消除重复部分。 优秀设计的根本是：消除重复部分！（DRY = Don’t repeat yourself）

回调和多态都是为了解耦，实现更好的模块化，升级代码时候改动更少的代码

我发现我取消 Home、catagories、about、tags 等原生目录之后，打开博客网站的首页，有个点会停留在第一个目录上，也就是目前的“信息科学”这个目录上。所以我想恢复首页这个目录（之前取消这个目录是因为点击我的博客名，也就是我的网名：liuqinh2s 的时候，会跳转到首页，也就是网站根目录，我不想搞两个有相同作用的按钮，但其实我错了，用户并不知道那个可以点击，就像安卓的侧滑出菜单一样，用户并不知道侧滑可以出菜单，所以才需要一个菜单按钮），恢复这个首页目录是设计上的必要。

> 设计思维就是要面向用户，不要以为用户知道那些隐含的功能点。

1. 色彩的概念：色彩是物体发出或反射的光在视觉系统中的形成的反应，这种反应使人们得以从视觉上区分物体的大小、形状、结构和属性等外部特征。
2. 色彩的三特性：亮度 Luminance，色调 Hue，饱和度 Saturation（色调的深浅程度）各种单色光饱和度最高，单色光中掺入白光越多，饱和度越低，白光占绝大部分时，饱和度接近于零，白光的饱和度等于零。注意区分亮度和饱和度。
3. 色彩模型：RGB，CMYK（颜料的三原色：C 青，M 品，Y 黄，+K 黑，应用于印刷工业）。RGB 是加色模型，CMYK 是减色模型。HSV（H 是色相即色调，S 是饱和度（取值 0~100%），V 是亮度值 Value（取值 0~100%））。YUV。

和分治算法比较类似，但不同的是分治算法把原问题划归为几个相互独立的子问题，从而一一解决，而动态规划则是针对子问题有重叠的情况的一种解决方案。

# 2018-11-19

看了某人的 spring boot 代码，发现后台的错误码和错误信息管理的一个优雅的做法：使用一个枚举类封装这两个属性，并使构造函数私有化。代码如下：

```java
public enum ExceptionMsg {
    SUCCESS("000000", "操作成功"),
    FAILED("999999", "操作失败"),
    ParamError("000001", "参数错误！"),

    LoginNameOrPassWordError("000100", "用户名或者密码错误！"),
    EmailUsed("000101", "该邮箱已被注册"),
    UserNameUsed("000102", "该登录名称已存在"),
    EmailNotRegister("000103", "该邮箱地址未注册"),
    LinkOutdated("000104", "该链接已过期，请重新请求"),
    PassWordError("000105", "密码输入错误"),
    UserNameLengthLimit("000106", "用户名长度超限"),
    LoginNameNotExists("000107", "该用户未注册"),
    UserNameSame("000108", "新用户名与原用户名一致"),

    FavoritesNameIsNull("000200", "收藏夹名称不能为空"),
    FavoritesNameUsed("000201", "收藏夹名称已被创建"),

    CollectExist("000300", "该文章已被收藏"),

    FileEmpty("000400", "上传文件为空"),
    LimitPictureSize("000401", "图片大小必须小于2M"),
    LimitPictureType("000402", "图片格式必须为'jpg'、'png'、'jpge'、'gif'、'bmp'");

    private ExceptionMsg(String code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    private String code;
    private String msg;

    public String getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}
```

# 2018-11-28

一切为了可重用。

代码写得能看懂便于维护，这样代码就能更长久的可重用。

代码模块化，是为了降低耦合，减少依赖，模块内部高内聚，模块之间低耦合，模块可重用。

模块的粒度应该以重用的灵活性为指导原则，不能一味追求小，但基本的客观规律是：比较小的模块更灵活，更容易重用。

一个设计良好的模块的客观标准是：可以随意组合，即插即用。

封装是为了更好的把代码的改动控制在模块内部，从而减少外部的改动需求。API 尽量不变，对外的接口尽量不变。[理解 Java 的三大特性之封装](http://wiki.jikexueyuan.com/project/java-enhancement/java-one.html)

继承则是赤裸裸的在重用代码。

# 2019-01-17

一个奇怪的问题，我配置好了 github 的 ssh key，但每次 push 都跟我索要账号密码。原因是我 clone 的时候用的 http 模式，在项目的.git/config 里面可以修改，改为 ssh 模式即可。感谢 stackoverflow 的小哥：[Why is Github asking for username/password when following the instructions on screen and pushing a new repo?](https://stackoverflow.com/questions/10909221/why-is-github-asking-for-username-password-when-following-the-instructions-on-sc)

# 2019-02-19

今天终于解决了一个困扰我一年之久的问题，网易云音乐和知乎账号的登陆异常。我对比了不同的网络环境（IP），不同的账号（别人的知乎账号），不同的浏览器。组合测试最后发现既不是 IP 的单方面的问题，也不是账号的单方面问题，也不是浏览器的单方面的问题。而当我使用无痕浏览的时候并没有任何问题，所以应该是 chrome 浏览器记住了某些东西。最后发现问题出在 chrome 浏览器的账号同步上，可能是因为我的谷歌账号在历史上曾记录了一次知乎异常登陆的 cookie，所以之后的每一次登陆都使用这个 cookie，而且清空都是无效的，在你登陆的时候又会给你自动添加。之后我先登出 chrome 账号，并同时清空所有数据，然后再登陆知乎账号，然后再登陆 chrome 账号同步一次正确的知乎登陆。问题就得到了解决。

知乎问题的根源：

- https://jiasule.v2ex.com/t/533482
- https://www.v2ex.com/t/521180

答案就是：发现一个在开启 IPFS 伴侣时，知乎的大部分接口都会报请求参数异常的 BUG。。

# 2019-02-20

今天联合查询一个 40 万和 1 万的表，发现弄了索引都没啥效果，最后发现是字符集不同导致的。把两个索引的字符集弄成一样的就行了。还有一个问题，mysql8 没有缓存导致查询很慢，mysql5.7 有缓存第二次查询快的飞起。还有同一个语句 mysql8 花了 100 秒，mysql5.7 只花了 10 秒，原因可能是对语句的解释不一样。在将数据库导入到 mysql5.7 的时候遇到一个错误：`2006: mysql server has gone away`。使用：`set global max_allowed_packet=268435456;`解决了。应该是单笔 insert 太大导致的，把配置设高一点就 OK 了。

# 2019-02-27

Java 反射，反射的作用包括，在运行时判断一个对象所属的类，给某个未知的类新建一个对象，获取任意一个类的成员变量和方法，并调用。如果你是初学反射，这么说你一定不知道我在说什么。但举个例子就比较容易理解了。那就是用配置文件动态控制程序要加载的类：

举个例子我们的项目底层有时是用 mysql，有时用 oracle，需要动态地根据实际情况加载驱动类，这个时候反射就有用了，假设 com.java.dbtest.myqlConnection，com.java.dbtest.oracleConnection 这两个类我们要用，这时候我们的程序就写得比较动态化，通过 Class tc = Class.forName("com.java.dbtest.TestConnection");通过类的全类名让 jvm 在服务器中找到并加载这个类，而如果是 oracle 则传入的参数就变成另一个了。这时候就可以看到反射的好处了，这个动态性就体现出 java 的特性了！举多个例子，大家如果接触过 spring，会发现当你配置各种各样的 bean 时，是以配置文件的形式配置的，你需要用到哪些 bean 就配哪些，spring 容器就会根据你的需求去动态加载，你的程序就能健壮地运行。

在使用 Python 的时候我就通过用配置来控制代码。体验非常棒。其实反射的作用就是通过配置控制代码。

## 是否要传数组长度的问题

Java 中数组是一个对象而非像 C++一样的原始类型，所以可以对数组求长度的时候是这么写：`arr.length()`，而 C++则没有这么方便的东西，所以传参的时候，Java 可以不传数组长度，C++必须要传：

```C++
func(arr, lengthOfArr);
```

## spring boot

随着计算机的发展，在应用程序开发中，很多东西都慢慢工具化了，大量简单重复的工作直接交给计算机就好了，留给人们的只是业务逻辑跟架构调优。spring boot 2 就是一个非常好用的 Java web 集成框架。学习最好的方法就是通过 **例子** 来领悟和体会到其中抽象的知识（共性）。对于工具的使用则更加强调动手实践。

先参考一下网上的资料：

- [知乎：Spring Boot 要如何学习？](https://www.zhihu.com/question/53729800)
- [bilibili：【自用】尚硅谷 spring boot 全套视频教程](https://www.bilibili.com/video/av44560321?from=search&seid=7097190869964471137)

<!--more-->

### 第一步快速入门

如果对 spring boot 一点都不了解的话，要先了解一下 spring boot 是什么，它的发展历程，从而建立起一个简单的印象。可以先看 B 站的教学视频的前几个概要介绍的视频。然后大致浏览一下需要学习的内容，你会发现都是按模块划分的，比如：工程配置、日志管理、数据库、缓存等等。

有了大概的了解，就可以动手写一个`hello world`了。

- [Spring Boot 快速入门](http://blog.didispace.com/spring-boot-learning-1/)
- [使用 Intellij 中的 Spring Initializr 来快速构建 Spring Boot/Cloud 工程](http://blog.didispace.com/spring-initializr-in-intellij/)

由于我以前做过`spring+springMVC+mybatis`的项目，所以学习 springboot2 对我来说是比较轻松的。

一般来说后端都会用到数据库，所以一个完整的 Hello World 程序怎么可以不接通数据库呢？

[Springboot 整合 Mybatis 的完整 Web 案例](https://www.bysocket.com/?p=1610)

> 编程思想中有一条很重要的原则就是：**尽量少的改动已有的代码**，原因有很多，比如改动一个被多处使用的函数有可能会对很多地方造成影响。所以我们就要 **尽量让我们的代码灵活起来，可重复用起来**，Java 的反射就起到了这个作用，Spring 框架最重要的作用就是让灵活的部分变成配置，程序动态加载配置就能改变代码的行为。回调也同样是在贯彻这一思想。**可重用** 是编程思想的精髓之一，甚至所有的抽象就都是为了这一目的，无论是`变量`、`函数`、`对象`、`数据结构`、`库`、`API`都是把死的代码变成活的，把不能重复使用的代码变成可以重复使用的代码。[阿里和蚂蚁八荣八耻](#阿里和蚂蚁八荣八耻)

## 阿里和蚂蚁八荣八耻

以动手实践为荣，以只看不练为耻。

以打印日志为荣，以出错不报为耻。

以局部变量为荣，以全局变量为耻。

以单元测试为荣，以手工测试为耻。

以代码重用为荣，以复制粘贴为耻。

以多态应用为荣，以分支判断为耻。

以定义常量为荣，以魔法数字为耻。

以总结思考为荣，以不求甚解为耻。

以可配置为荣 ，以硬编码为耻

以可互备为荣 ，以单点为耻

以可无状态为荣 ，以有状态为耻

以可随便重启为荣 ，以不能迁移为耻

以整体交付为荣，以部分交付为耻

以标准化为荣，以特殊化为耻

以自动化运维为荣，以人肉化运维为耻

以无人值守为荣，以人工值班为耻

# 2022-06-10

今天发现一个 bug 跟 tagName 有关，原因是 document 没有 tagName，**document.tagName 是 undefined**，导致代码报错。

## toJSON()方法

一个对象定义了 toJSON 方法的话，JSON.stringify 就会去调用这个方法，返回定制化的字符串。

官方文档：https://developer.mozilla.org/zh-TW/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify

If an object being stringified has a property named toJSON whose value is a function, then the toJSON() method customizes JSON stringification behavior: instead of the object being serialized, the value returned by the toJSON() method when called will be serialized. JSON.stringify() calls toJSON with one parameter:

- if this object is a property value, the property name
- if it is in an array, the index in the array, as a string
- an empty string if JSON.stringify() was directly called on this object

```JavaScript
const bonnie = {
  name: 'Bonnie Washington',
  age: 17,
  class: 'Year 5 Wisdom',
  isMonitor: false,
  toJSON: function(key) {
    // Clone object to prevent accidentally performing modification on the original object
    const cloneObj = { ...this };

    delete cloneObj.age;
    delete cloneObj.isMonitor;
    cloneObj.year = 5;
    cloneObj.class = 'Wisdom';

    if (key) {
      cloneObj.code = key;
    }

    return cloneObj;
  }
}

JSON.stringify(bonnie);
// Returns '{"name":"Bonnie Washington","class":"Wisdom","year":5}'

const students = {bonnie};
JSON.stringify(students);
// Returns '{"bonnie":{"name":"Bonnie Washington","class":"Wisdom","year":5,"code":"bonnie"}}'

const monitorCandidate = [bonnie];
JSON.stringify(monitorCandidate)
// Returns '[{"name":"Bonnie Washington","class":"Wisdom","year":5,"code":"0"}]'
```

## 大型软件的设计很重要

为 EDA 写了快三年代码了，我的感觉就是对于稍微复杂一点的软件，设计真的很重要。在新加某个需求后，可能因为不好的设计产生很多 bug，也有可能因为原先存在的代码设计不合理，导致新需求很难写，到处都要埋点。

我的 leader 写了这段话，我觉得很对：

> 很多糟糕的设计隶属于某个更大的糟糕设计，而这个更大的糟糕设计可以被一两行精妙的代码整个代替掉，你在局部优化半天毫无意义。

# 2022-06-11

最近想把 wordpress 上的文章迁移到 github.io。今天一打开我的 wordpress 博客，突然直接跳到 wordpress 的安装界面，我感觉挺奇怪的，有种不好的预感。打开数据库一看果然又被黑了，除了 wordpress 数据库，顺带其他几个 mysql 的数据库也被黑了。因为我还在我服务器上跑着我自己写的量化交易的脚本，mysql 的某个数据库里面有币安的 api key，吓得我立马去币安删 api。我担心可能 linux 服务器的账号密码都被黑了，而且也有可能在我服务器放了什么其他可怕的病毒，干脆还是重置一下服务器，以及相关的所有账号密码。

上次我的 wordpress 被攻击还是 2016 年的事了，当时我才没用几个月，写了大概三篇文章，就被黑了，当时黑客留下来的是个 QQ，这次是个比特币地址：

```
readme:
To recover your lost Database send 0.0115 Bitcoin (BTC) to our Bitcoin address: bc1qtr4px3ngv80tz2j9e49jxcmtqthfnw8xhux4as  After this, contact us by email with your Server IP or Domain Name and a Proof of Payment (Payment ID). Your Database is downloaded and backed up on our servers. Backups that we have right now: chaobi, e_business, stock, wordpress. Any email without your server IP Address or Domain Name and a Proof of Payment together will be ignored. If we dont receive your payment in the next 10 Days, we will delete or leak your sensitive information.

BTC_address:
bc1qtr4px3ngv80tz2j9e49jxcmtqthfnw8xhux4as

email:
support@dbrestore2022.to
```

![image.png](https://s2.loli.net/2022/06/11/rbelB5sHhZQLofY.png)

可惜我写了这么多文章都还没有备份
