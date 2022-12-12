---
title: 札记
date: 2018-11-03 14:59:45
---

这里主要用来记录我生活中的所思所想，当然大部分可能是跟计算机、编程有关的。这些想法或者摘抄比较短小，不足以形成一篇文章，但仍然值得记录下来反复品味，回顾。它们的编排方式是按日期倒序来的。

# 2022-12-12

## 深入对比对象

怎么深入比较两个对象是否相等（不管引用是否相等，只看值），最简单的办法就是使用`JSON.stringify`。

`===`和`Object.is()`有什么区别？

```javascript
NaN === NaN; // false
Object.is(NaN, NaN); // true

-0 === +0; // true
Object.is(-0, +0); // false
```

## 文本溢出常用处理手段

```css
.ellipsis {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
```

## width 100%和 auto 的区别

[difference between width auto and width 100 percent](https://stackoverflow.com/questions/17468733/difference-between-width-auto-and-width-100-percent)

实验:https://replit.com/@liuqinh2s1/css-textOverflow#src/App.tsx

## 一个单词是不会换行的

发现行内元素居然不会换行，原来是因为被当成一个单词了

实验：https://replit.com/@liuqinh2s1/cssTest2#src/App.tsx

# 2022-12-09

## Http 请求的数据格式

Http 请求中，dataType 和 ContentType 的区别

http 的头其实是可以随意书写的，只要服务器能适配就行，当然大部分是约定的。我只看到 Content-Type，request 和 response 都有，但没有 dataType。dataType 用于客户端通知服务器，客户端需要什么类型的返回数据。说有用也有用，说没用也没啥用，服务器会返回什么类型的数据，客户端肯定是知道的啊，一开始就约定了

常见的数据格式：

1. `application/json`
2. `application/x-www-form-urlencoded`

## flex，flex-grow，flex-shrink，flex-basis

这个东西的计算公式官网没有公布，导致只能查别人写的资料，或者自己推导。经过多次实验后，结论如下：

grow 的计算跟自身宽高无关，直接按比例分配剩余的空间，shrink 的计算是跟自身宽高有关的，需要根据自身宽高，按加权比例平摊（缩减）超出的空间。

假设计算的是水平方向的 flex：

grow 的算法如下：

单个元素需要 grow 的量：`(单个子元素 flex-grow/总的 flex-grow)\*(父容器宽度-子元素宽度之和)`

shrink 的算法如下：

假设 div1 是 100px, flex-shrink:1；div2 是 200px, flex-shrink:2；div3 是 300px, flex-shrink: 3。容器宽度 700px

div1 元素需要 shrink 的量：`(100*1)/(100*1+200*2+300*3)\*(700-100-200-300)`

也就是加权比例，需要用到自身的宽高

flex-basis 就是宽高的意思，但比宽高优先级高，比如定义了 width: 100px; flex-basis: 0px;那么就是按 0 去进行 flex 的。

实验地址：https://replit.com/@liuqinh2s1/css-flex#src/App.tsx

# 2022-12-08

## react 怎么区分父组件发起的渲染，还是子组件自身发起的渲染

用 react 的过程中遇到一个需求：子组件渲染的时候，需要知道是父组件发起的，还是子组件自身发起的渲染。如果是父组件发起的，就用父组件传过来的数据，如果是子组件发起的，就用子组件自身的数据。

那么怎么达到这个目的呢，有两种方案：

（1）增加一个变量`xxx`标志父组件的刷新，然后子组件 useEffect 监听这个变量

代码如下：

```javascript
useEffect(() => {
  setData(props.data);
}, [props.xxx]); // 确保每次父组件渲染的时候xxx跟上次不同
```

（2）还有一个方案是使用不同的 key 去渲染子组件（这样就能强制刷新子组件了）

```javascript
<Child key={xxx}></Child> // 确保每次父组件渲染的时候xxx跟上次不同
```

这两种做法，还有本质上的区别，因为第二种方法会导致 react 的虚拟 dom 中直接干掉子组件（以及它的子节点），这会导致整个子节点刷新，而第一种方案则不会，第一种方案比较高效。

测试案例：https://replit.com/@liuqinh2s1/whereIsRerenderComeFrom#src/Sub.tsx

## 如何打包 chrome 扩展程序

在 chrome 扩展程序管理中找到了，开发者模式->打包扩展程序，但是提示我：`打包扩展程序错误 指定扩展程序的私有密钥已存在。请重复使用该密钥，或者先删除它。`

上网查了一下，都说已经打包过了，要我找到第一次打包的位置，鬼记得啊，但最后还是借助一定的手段找到了。扩展程序都有自己的 id，然后我用 everything（一个很好用的搜文件软件支持 Windows 系统）搜索一下这个 id，居然真的找到了，是个目录名，还好我没有手贱去改目录名。

# 2022-12-07

没想到疫情说放开就放开了，现在开始准备个人防控，但药物却买不到，以前没有做准备，从别处抄了个清单：

```
前期吃这个：
1. 四季抗病毒合剂
2. 复方一支蒿颗粒
浑身疼吃：复方氨酚烷胺胶囊
发烧吃：
低于38.5°吃：乙烯氨基酚片
高于38.5°吃：布洛芬缓释胶囊
后期吃：
1. 连花清瘟胶囊
2. 蒲地蓝消炎片
咳嗽吃：消炎止咳片
```

# 2022-12-06

[react 父组件调用子组件的函数](https://juejin.cn/post/6844903937468792846)：`useImperativeHandle`

子组件：

```javascript
function children(props, ref) {
  // 用useImperativeHandle暴露一些外部ref能访问的属性
  useImperativeHandle(props.onRef, () => {
    // 需要将暴露的接口返回出去
    return {
      xxx: () => {
        console.log("执行子组件方法xxx()");
      },
    };
  });
  return <h1>children</h1>;
}
export default forwardRef(children);
```

父组件：

```javascript
const childrenRef = useRef(null);
childrenRef.current.xxx();
return <children ref={childrenRef} />;
```

很多时候，父组件需要设置子组件的 state，那么就可以这样做

# 2022-12-05

## css 边框是否计入宽高

```css
box-sizing: border-box; // 这个会把边框的宽度计入width和height
box-sizing: content-box; // 这个不会把边框的宽度计入width和height，且这个是默认值
```

## react 受控组件和非受控组件

使用 react 的过程中发现，有的时候需要写很多的更新代码，比如 Input 标签，需要在 onBlur 的时候更新 value，需要在 onKeyUp（按 enter）的时候更新 value，如此会非常麻烦，远不如以前用 jquery 的时候，直接获取 dom 的值。

如果对于一个组件，我们用 useState 来存储状态，并在每个更新事件中更新值，这种我们叫：受控组件

还有一种写法是，直接不使用 useState，也就不用更新值，需要拿值的时候，直接从 dom 获取（怎么获取 dom？用 useRef）。

官方文档：https://zh-hans.reactjs.org/docs/uncontrolled-components.html

# 2022-12-02

react 怎么获取 children，比如`<Button><span>AA</span></Button>`

https://reactjs.org/docs/glossary.html#propschildren

但问题来了，既然 children 占了 props 的一个键，如果这样写呢：`<Button children="BB"><span>AA</span></Button>`

如果是 ts 的话会报错：`'children' are specified twice. The attribute named 'children' will be overwritten.`

然后 node 控制台也会发出警告，但依旧是可以运行的，且 children 最终结果会是：`<span>AA</span>`

顺带说一句 replit.com 是真好用啊，比 codepen 强太多了。

# 2022-12-01

安装免费的正版的激活的 office，官方提供的白嫖渠道：

https://www.youtube.com/watch?v=VSjRx7Hoa60&t=319s&ab_channel=%E9%9B%B6%E5%BA%A6%E8%A7%A3%E8%AF%B4

# 2022-11-27

用了 7 年的 macbook pro A1398 款，最近想换个屏幕以及键帽，F 键帽被磨掉漆了。尝试自己拆了一下键帽，还真是复杂，开机键的键帽支架差点装不回去了。上淘宝搜了一下价格，单 F 键帽和下面的软垫就要 20 块，F 键帽+开机键键帽要 30，胶水要 5 块。但是一个键盘带 C 壳总成才 130，加上我装回 F 键后，发现这个键的手感和其他键居然不一样。仔细试了一下，F 键的手感最软榻，感觉几乎快要坏了。据说要给软垫下面涂胶水固定，不过我也不清楚是不是涂了胶水，手感就好了，或者换了软垫就好了。

还是换键盘吧，最稳妥的决定。

# 2022-11-26

最近发现 surface 上推送的 blog，内容居然是空的，经过调查发现，是生成的 index.html 内容为空，再上网查发现了原来是 node 版本太高，hexo 版本太低，不匹配。我选择了升级 hexo 到 4.2.1。

https://alanlee.fun/2021/02/28/hexo-empty-html/

光改 package.json 中的版本还不够，生成的内容样式丢了。所以决定用 hexo 官网推荐的方式来解决：

```javascript
npm install hexo-cli -g
hexo init blog
cd blog
npm install
hexo server
```

在 hexo init 的时候发现没有权限创建文件夹：

```bash
$ hexo init
INFO  Cloning hexo-starter https://github.com/hexojs/hexo-starter.git
fatal: unable to access 'https://github.com/hexojs/hexo-starter.git/': Failed to connect to github.com port 443 after 21114 ms: Timed out
WARN  git clone failed. Copying data instead
FATAL {
  err: [Error: EPERM: operation not permitted, mkdir 'C:\'] {
    errno: -4048,
    code: 'EPERM',
    syscall: 'mkdir',
    path: 'C:\\'
  }
} Something's wrong. Maybe you can find the solution here: %s http://hexo.io/docs/troubleshooting.html
```

在网上查了一圈，没找到合适的答案，不过我自己知道问题的原因，就是因为权限不够需要用管理员身份运行 mkdir 而已，我试着以管理员方式启动 vscode，没想到真的成功了，估计权限向下传递给了 vscode 的 bash，然后又传给了 bash 中运行的 hexo，以及由 hexo 启动的 mkdir。

但是在用了 hexo 最新版后各种问题，而且 next 新版主题我也不喜欢，为了避免折腾，还是决定保留 hexo 旧版，把 node 切回低版本：12.22.12。使用 nvm 可以很方便的切换版本，下载 node 等操作。

# 2022-11-25

安装 Android 子系统：https://www.cnblogs.com/frank-link/p/16390714.html

安装 linux 子系统，遇到内核升级的问题，从 WSL1 升级到 WSL2，需要下载一个升级内核的程序：

- https://github.com/microsoft/WSL/issues/5393
- https://learn.microsoft.com/zh-cn/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package

下载地址：https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_arm64.msi

其他相关资料：

- https://www.cnblogs.com/aedjesse/p/14085217.html
- https://cloud.tencent.com/developer/article/1632713
- https://zhuanlan.zhihu.com/p/258563812

安装的 kali linux 是最小型的，如果想扩充工具库，看这里：

- https://www.kali.org/docs/troubleshooting/common-minimum-setup/

# 2022-11-24

## 安装 win11 arm64 位

我拿到的 surface pro x 默认装的是 win10，但是 arm 版的 win10 不支持 x64 程序，导致很多软件都无法使用，经过一番上网查找发现 win11 是可以支持 x64 程序的模拟的，而且还支持安卓模拟，简直太棒。搞了一晚上终于安装好了 win11，我没有使用 U 盘来安装，而是直接下载 ISO 文件，然后点击 setup.exe 直接安装。安装完后，原先的程序和设置全都在，非常的方便（这样都不用管驱动的问题了，一直听说 surface pro x 的驱动不好找）。

windows11 arm64 版下载地址：https://next.itellyou.cn/，这么多年一直是在itellyou下载正版软件的，真的非常方便。如果觉得下载慢，可以使用迅雷。

## 激活 jetbrains 家的软件

- https://www.cnblogs.com/nihaorz/p/16517730.html
- https://www.binfoo.com/2820

头一次发现激活这么简单，真的强烈推荐。

操作步骤：

1. 打开激活破解官方网站：https://search.censys.io/
2. 搜索框输入：services.http.response.headers.location: account.jetbrains.com/fls-auth。
3. 点击搜索，在返回的结果随便找一个点进去，查找到 HTTP/302。
4. 复制网址到 Jetbrains，选择许可证服务器/License server，粘贴刚刚复制的网址，激活。
5. 如果发现服务器不可用，可以继续尝试更换一个进行激活。

可以愉快的开始编程了

# 2022-11-23

新买了个 surface pro x，发现 windows 商店挂代理访问不了，解决办法：

https://zhuanlan.zhihu.com/p/55906778

不用其他软件，以管理员权限启动 powershell 敲下面命令即可：

```
foreach ($n in (get-appxpackage).packagefamilyname) {checknetisolation loopbackexempt -a -n="$n"}
```

如果只想对某个特定 UWP 应用设置代理，用 $n=(get-appxpackage *应用名的独特部分，比如邮件应用是commu*).packagefamilyname | checknetisolation loopbackexempt -a -n="$n"

npm i 之后遇到 hexo 找不到的问题：`bash: hexo: command not found`

其实就是需要全局安装一下 hexo：`npm install -g hexo`

还可以使用 npx 来执行，这样就不用全局安装了：`npx hexo`

# 2022-11-22

如何通过局域网把电子书传输到 kindle 呢？

- https://www.bilibili.com/read/cv9457950

答案是使用 calibre，通过这个软件搭建一个局域网服务器，然后用 kindle 的浏览器功能访问服务器网址，就可以下载电子书啦，非常的方便实用。我原先一直是通过发送到邮箱的方式来传输电子书的，这个是要走公网的，但这种方式对文件大小有限制，必须要小于 50M，而且传输速度也大不如局域网。

# 2022-11-17

js 中??是什么表达式

```javascript
alert(username ?? "Guest");
```

这里的双引号称为**空值合并运算符**，它是 ES2020 的一个新特性，它的作用是当一个表达式是 null 或者 undefined 时为变量设置一个默认值。

比||更精确一点。像`''`，`0`，`false`这些都是实际值。有的时候是希望使用这些值的。这个语法糖的作用更自己定义的 isUndef 差不多：

```javascript
alert(isUndef(username) ? "Guest" : username);
```

终于可以不用自己实现一个函数来做这件事了。

# 2022-11-16

## trigger 和 Event

jquery 写法：

```javascript
$("xxx").trigger("blur");
```

原生 js 写法：

```javascript
dom.dispatchEvent(new Event("blur"));
```

# 2022-11-15

try catch 能捕获异步的错误吗，答案是不能。但如果用 await 就可以。

参考资料：https://juejin.cn/post/6850418110907088910

以下代码能捕获到：

```javascript
async function f() {
  // 异步，微任务
  try {
    await new Promise(() => {
      throw new Error("gadsgsdg");
    });
  } catch (error) {
    console.log(error);
  }
}

f();
```

以下代码不能捕获到：

```javascript
async function f() {
  // 异步，微任务
  try {
    new Promise(() => {
      throw new Error("gadsgsdg");
    });
  } catch (error) {
    console.log(error);
  }
}

f();
```

# 2022-11-14

一直以来都只会 import 和 export 的语法，但是不会 require 的。今天学习了一下：

```javascript
function test(str) {
  console.log(str);
}
// module.js
module.exports = {
  a: function () {
    console.log("exports from module");
  },
  test,
};
```

```javascript
// sample.js
var obj = require("./module.js");
obj.a(); // exports from module
let { test } = require("./module.js");
test("this is a test");
```

# 2022-11-07

## clientHeight

最近 eda 项目在进行两个重构，重构完就是 2.0 版了，一个是原理图的数据驱动重构，一个是 UI 的 react 重构，我打算做个 List 组件，需要上虚拟滚动。

先来了解一下：[clientHeight](https://developer.mozilla.org/zh-CN/docs/Web/API/Element/clientHeight)

clientHeight = CSS height + CSS padding - 水平滚动条高度（如果存在）

## 连续点击鼠标次数

在写 onClick 事件的时候，学到一个东西：`event.detail`，这个是个 number 类型，代表连续点击鼠标的次数，学习资料如下：

- https://bobbyhadz.com/blog/react-double-click-event
- https://developer.mozilla.org/en-US/docs/Web/API/Element/click_event

```javascript
const handleClick = (event) => {
  console.log(event.detail);
  switch (event.detail) {
    case 1: {
      console.log("single click");
      break;
    }
    case 2: {
      console.log("double click");
      break;
    }
    case 3: {
      console.log("triple click");
      break;
    }
    default: {
      break;
    }
  }
};
```

## useState 的坑

```javascript
import React, { useState, useEffect } from "https://esm.sh/react@18";
import ReactDOM from "https://esm.sh/react-dom@18";
const obj = { text: "2" };
const Hello = ({ props }) => {
  const [bb, setBB] = useState(props);
  useEffect(() => {
    // let one = JSON.parse(JSON.stringify(obj))
    // one.text='3'
    // setBB(one);
    setBB((obj) => {
      if (bb === obj) {
        console.log(true);
      }
      obj.text = "3";
      return obj;
    });
  }, []);
  return <div>{bb.text}</div>;
};
const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(<Hello props={obj}></Hello>);
```

运行地址：https://codepen.io/liuqinh2s/pen/eYKdqeo?editors=0010

如果 useState 传入的对象的引用没有发生变化，它就不会更新。所以修改对象就只能深拷贝了。

# 2022-11-06

github 突然抽风，push 的时候报错：

```bash
➜  blog git:(master) git push
kex_exchange_identification: read: Connection reset by peer
fatal: 无法读取远程仓库。

请确认您有正确的访问权限并且仓库存在。
```

之前也遇到过一次，主要参考这两篇文章：

- https://getiot.tech/github/github-errata-port-443-connection-refused.html
- https://www.jianshu.com/p/61b12cc1f818

上次是新建了一个本地配置文件：`~/.ssh/config`：

```
Host github.com
Hostname ssh.github.com
Port 443
```

当然这次是它自己又好了

# 2022-11-05

[WeakMap](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakMap)，[WeakSet](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WeakSet)是什么？

1. 它们的键都只能是对象
2. 键如果没有被引用的话，会被回收（容器本身的引用不算），防止内存泄露
3. 键都不可遍历（因为随时会被回收）

# 2022-11-02

同事分享了一个案例，返回的是值类型，但依旧可以修改属性：

```javascript
const lib = (() => {
  const profile = {
    version: "1.0.1",
    name: "clouser",
  };
  return {
    get(key) {
      return profile[key];
    },
  };
})();
```

上例中，如果不动已有的代码，要修改 profile 的 name，怎么修改？

增量代码如下：

```javascript
const a = Symbol(1);
Object.defineProperty(Object.prototype, a, {
  get() {
    return this;
  },
});
const profile = lib.get(a);
profile.name = "changed name";
```

通过在 profile 的原型链上定义一个属性，然后属性的 get 方法中返回 profile 对象本身。

修复这个漏洞，可以这样：

```javascript
const profile = Object.create(null);
```

这样就让 profile 的原型是 null 了，要让 profile 的原型是 Object.prototype 则这样写：`const profile = Object.create(Object.prototype);`

# 2022-10-27

遇到一个比较难的题目，看了答案才解出来。先是看了讨论里面的提示说用前缀和+单调队列，但其实跟单调队列没啥关系，毕竟队列本身存的是下标 `i`，却要转换成 `preSum[i]` 再去讨论单调性。而且这题一定要经过精妙的分析才能维护好这个查询队列（用于替代暴力解法中的第二层 for 循环，减少查找范围），最后才勉强发现这个查询队列类似单调队列，如果先直接写好单调队列的数据结构再去解题，怕是根本就想不清题目了。

另外时隔多年后，我又自己手写了[双链表](https://gist.github.com/liuqinh2s/2a419b21947b55a1f77f88c8082f9cf6)，但用在这题上居然反而超时了（用 js 自带的数组不会超时）

发现原来是因为搜索的时候，固定从前往后搜导致的，但像头尾操作的时候，应该直接指定节点根本就不用搜索，解决掉这个问题后，速度非常快了。

# 2022-10-26

.then 的优先级比 await 高，所以这样写是有区别的：

```javascript
await func().then(); // 先执行.then
(await func()).then(); // 先执行await
```

# 2022-10-19

AI 作画现在很火，我也小玩了一把：https://6pen.art/

AI 作画网站收集：https://github.com/hua1995116/awesome-ai-painting

# 2022-10-17

怎么验证，浏览器的 localStorage 是单个字段限制为 5M，还是整个 localStorage 限制为 5M。可以自己写代码验证：

```javascript
localStorage.setItem(
  "a",
  Array(5 * 1024 * 1024 - 1)
    .fill("0")
    .join("")
); // 通过
localStorage.setItem(
  "a",
  Array(5 * 1024 * 1024)
    .fill("0")
    .join("")
); // 不通过
localStorage.setItem(
  "aa",
  Array(5 * 1024 * 1024 - 1)
    .fill("0")
    .join("")
); // 不通过
```

找到空的 tab 输入上面的代码，再找个有 localStorage 的网站输入上面的代码，得到的验证结果是：

有 localStorage 的网站 tab 三个都通不过，空的 tab 能通过第一个。

由此得到结论，5M 的限制是针对整个 localStorage 而言的（不是单个字段），且是 key+value，而非单纯的 value。

另外我们还顺带验证了 js 的'0'是 1 字节大小。

# 2022-10-13

js 中的字符都是两字节的，怎么查看一个字符的编码呢，用`str.charCodeAt(0)`，从编码变字符用：`String.fromCharCode(code)`

```javascript
const code = "中".charCodeAt(0);
console.log(code, code.toString(16), escape("中"));
const str = String.fromCharCode(code);
console.log(str);
```

js 字符编码的故事：[Unicode 与 JavaScript 详解 - 阮一峰的网络日志](https://www.ruanyifeng.com/blog/2014/12/unicode.html)

# 2022-10-11

正则表达式中，圆括号是捕获里面的匹配项的意思，那么怎么不捕获呢？这样写：

```
(?:x)
```

官方文档：[正则表达式](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Regular_Expressions)

# 2022-10-10

昨天做了一道 leetcode，最后需要用 eval 来解析四则运算：[856. 括号的分数](https://leetcode.cn/problems/score-of-parentheses/)

那么怎么手写一个四则运算解析器呢？答案是需要用到 AST，在网上看到一篇非常不错的文章：[四则运算表达式如何转换成 AST](https://juejin.cn/post/6844903977667002375)，看完之后感觉我也会了，虽然代码比较多，但非常简单易懂，值得学习其中的编程思维。

解决了一道动态规划题：https://leetcode.cn/problems/minimum-swaps-to-make-sequences-increasing/

了解了一下[window.parent](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/parent)

# 2022-09-21

拉远端分支 git 命令：

```
git fetch origin
git checkout -b pro-ui/dev origin/pro-ui/dev
```

删除本地分支 git 命令：

```
git branch -D pro-ui/dev
```

# 2022-09-15

最近感觉自己 git 方面的知识还是比较少，今天看到一个--no-track 参数，不懂什么意思。

```
1. 创建新分支 git checkout -b name/newbranch --no-track origin/pro-xxx/dev
2. 在远端创建并跟踪分支 git push --set-upstream origin name/newbranch
```

一开始猜--no-track 是针对后面那个参数`origin/pro-xxx/dev`，但总感觉没要必要不跟踪这个分支呀，应该是要跟踪才对。后来才了解到，--no-track 是指不跟踪当前所在分支，而去跟踪`origin/pro-xxx/dev`，另外这个不是远端的分支，而是远端分支在本地对应的分支，因为经过试验，通过这个创建的分支并不是最新的代码，所以在创建新分支之前，最好先拉一下`pro-xxx/dev`的代码。

在不切换分支的情况下，拉指定远端分支的代码到本地指定分支：

```
git pull origin pro-ui/dev:pro-ui/dev
```

# 2022-09-14

关于 git 工作流，我们团队推了一个工作流方式，采用：

1. 新建临时分支
2. git rebase
3. merge request
   的方式进行开发。

之前一直都没用过 git rebase（不了解不敢用），今天抽空看了这篇文章：https://morningspace.github.io/tech/git-merge-stories-6/，对git rebase 算是基本理解了。

# 2022-09-06

看零度解说的时候，他讲到一个语音转文字的网站，我突然想起来微信好像自带了一个这个功能，于是试了一下，真的很方便，在输入语音的时候说完话往右上滑动就能以文字的形式发送出去了。而且微信好像还有自带的翻译，可以翻译英文，韩文什么的。微信都这么方便了，那就没有必要用其他的网站工具了。

## 关于 git 工作习惯

最好的习惯是开自己的分支，合并用 merge request。

如果硬要在 dev 分支开发的话，一定要贯彻远端优先原则，每次准备提交自己的代码了都做如下操作：

1. git stash
2. git pull
3. git stash pop
4. 解决可能存在的冲突
5. git commit
6. git push

顺便说一下 git revert 会产生一条新的提交记录，如果不想产生提交记录就用 git reset。

今天发生了一个合并事故，我先 git commit，然后 pull 发现有冲突，但看起来很奇怪（多了 100 多个文件需要提交），我就想哪里出问题了，就 git revert 了一下，然后再 git pull，git cherry-pick 之前的 commit，然后 git push。最终导致的结果是另一位同事在 merge 时删除了某位同事的代码。总之这套做法很不好，以后还是用回上面提到的流程。

# 2022-09-01

当 cherry-pick 产生冲突，怎么退出 cherry-pick？

答案是用：`git cherry-pick --abort`

cherry-pick 的参数挺多的，可以自己在命令行看一下：

```
$ git cherry-pick
usage: git cherry-pick [<options>] <commit-ish>...
   or: git cherry-pick <subcommand>

    --quit                end revert or cherry-pick sequence
    --continue            resume revert or cherry-pick sequence
    --abort               cancel revert or cherry-pick sequence
    --skip                skip current commit and continue
    --cleanup <mode>      how to strip spaces and #comments from message
    -n, --no-commit       don't automatically commit
    -e, --edit            edit the commit message
    -s, --signoff         add Signed-off-by:
    -m, --mainline <parent-number>
                          select mainline parent
    --rerere-autoupdate   update the index with reused conflict resolution if possible
    --strategy <strategy>
                          merge strategy
    -X, --strategy-option <option>
                          option for merge strategy
    -S, --gpg-sign[=<key-id>]
                          GPG sign commit
    -x                    append commit name
    --ff                  allow fast-forward
    --allow-empty         preserve initially empty commits
    --allow-empty-message
                          allow commits with empty messages
    --keep-redundant-commits
                          keep redundant, empty commits
```

# 2022-08-31

git 合并的时候，如果本地代码过旧（比如本地代码是两个月前的），可能会发生一些意想不到的问题，合并的时候抛弃了线上分支的许多代码和文件，但 commit 记录里面却没有体现。这个时候想要 revert 发现报错了：

`git revert is a merge but no -m`

> 因为需要回滚的 commit 是一个 merge 动作，需要显示给出-m（mainline）选择告诉 git 回滚具体哪一个 mainline。

解决办法有两种，一种是 git reset 到合并前，然后 force push（这种办法的好处是不会产生多于的 commit），但如果开了分支保护，无法强推，就只好换另一种办法，还是 git revert，但要多加一个-m 参数：https://blog.csdn.net/yanlaifan/article/details/115761272

先看看用:`git show commitHash`查看 merge 了哪两个 mainline，然后指定回滚到哪个 mainline：

`git revert commitHash -m 2`，回滚到第二个 mainline。

这样的话就能成功 revert 了，虽然找回了之前 mainline2 的代码，但这种做法的缺点是 mainline1 和 mainline2 的所有不同的代码行的 commit 信息全部变成 revert 这个 commit 的信息了

# 2022-08-25

> 原理：const 限定引用不可更改，as const 限定内容不可更改，当内容可以改的时候，显然 typeof 无法准确限定（只能限定到 string,number 这些通用的类型，没办法限定到'a', 1 这些具体的值），当内容不可改了，自然会帮你缩减到具体值。

typescript 的一些常见用法：

## 使用数组中限定的 string

```javascript
let a = ['a', 'b'] as const;
let b: typeof a[number] = 'c';
```

上述代码会报错，因为 `typeof a[number]` 限定了 b 的类型是`'a'|'b'`，`as const`既可以让 a 是 readonly 类型，又可以让 `typeof a[number]` 从 string 类型缩窄到 `'a'|'b'`

> typeof a 类型是 readonly ['a', 'b']

可以将上面的代码改写为：

```javascript
let a: readonly ['a', 'b'] = ['a', 'b'];
let b: typeof a[number] = 'c';
```

但这个要写两遍数组，看起来不太好看

## 使用对象中限定的 string

```javascript
let obj = {
  'a': 'a',
  'b': 'b'
} as const;
let b: Item<typeof obj> = 'c';
```

这样可以获取对象的 value，每多一层，就可以多加一个 Item。

那怎么获取对象的 key 呢？代码如下：`keyof typeof`

```javascript
let obj = {
  'a': 'a',
  'b': 'b'
  'c': {
    'd': 'd'
  }
} as const;
let b: keyof typeof obj = 'd';
```

而且这个是不用 as const 也可以的

## 限定一个对象的 key 与另一个对象的 key 完全匹配

```javascript
const enum DOCTYPE {
  DEVICE: 1,
  SYMBOL: 2
}
let a: Record<DOCTYPE, string> = {
  [DOCTYPE.DEVICE]: 'aaaa'
}
```

这样写会报错，应该少了一个 key。这个 Record 的作用就是新建一个对象，对象的 key 完全沿用旧对象的。

## 怎么获取 enum 的 key 和 value 类型

```typescript
export const enum Direction {
  a = "vertical",
  b = "horizontal",
}
type k = keyof typeof Direction;
type v = `${Direction}`;
```

# 2022-08-23

没什么用，但用起来很爽的快捷键，Vscode 清除没有用到的 import 语句：

Mac:
option+shift+O

windows:
Alt+shift+O

## 高内聚，低耦合

- 高内聚是减少了代码量，增加复用，避免改了这里还要改那里
- 低耦合是增加了代码量，减少复用，避免改了这里却动到了那里

本质上都是为了少修改代码，减少工作量

# 2022-08-01

重新做了一遍这个 CSS 选择器训练：[CSS Speedrun | Test your CSS Skills](https://css-speedrun.netlify.app/)

有些我还是用的挺少的，比如`:nth-child(2n+3)`，`img ~ p`，`a + span`，`:enable`，平常用的最多的应该就是属性选择器了，都还是靠加属性来标记的

# 2022-07-25

HTTP3.0 居然都有了，而且居然放弃了 TCP 作为传输层协议：[HTTP 3.0 彻底放弃 TCP，TCP 到底做错了什么？](https://mp.weixin.qq.com/s/LMjVtUshf67i1gbJI2zDSA)

## npm 的依赖版本问题: `^`，`~`，`*`以及不带前缀的区别

- `~`会匹配最近的小版本依赖包，比如~1.2.3 会匹配所有 1.2.x 版本，但是不包括 1.3.0
- `^`会匹配最新的大版本依赖包，比如^1.2.3 会匹配所有 1.x.x 的包，包括 1.3.0，但是不包括 2.0.0
- 写`*`，这意味着安装最新版本的依赖包
- 版本号不带前缀，则固定安装这个版本

最后 package-lock.json 会锁住版本，所以如果想要重新安装，要删掉里面的相关配置

# 2022-07-22

翻自己的豆列发现收藏了 15 篇文章，但没啥印象，于是一个一个打开看，其中有一篇是讲消费品味的，一直觉得自己在穿衣打扮方面注意得比较晚，上面推荐的几款东西，看起来还不错，到时候挑一些买。

[大学四年必备单品清单——男生篇](https://www.douban.com/note/540009246/?_i=8412550refpEge,8470363refpEge)

[活动--CHH 第三届桌面 Show 活动](https://www.chiphell.com/article-25725-1.html)

# 2022-07-21

帮组员解决一个 tinymce.js 在 nextjs 中报错的问题，原因是 tinymc.js 中使用了 navigator，服务端没有这个对象。

nextjs 遇到必须在客户端渲染的内容，要怎么办呢？答案是判断环境：

```Javascript
if(typeof window !== 'undefined'){
  // 执行必须在客户端执行的代码
  require('tinymce')
}
```

# 2022-07-17

猫砂要怎么选？今天做了一下功课

首先要知道猫砂的四个重要属性：

- 易结块
- 吸味，除臭
- 尘少
- 不粘底，不粘铲

然后是猫砂分类，主要分为这四类：

- 膨润土猫砂
  - 优点：**膨润土猫砂是历史最悠久的猫砂，在结团上面有非常出色的表现**。膨润土猫砂的吸水性是不错的，可以将粪便里的水分和尿液完全吸收，凝结成一个大硬团，清理起来比较方便，而且比较符合猫咪在野外的感觉，**对猫咪的脚感也比较好。且便宜。**
  - 缺点：便宜的粉尘特别大，并且**不能冲厕所**。
- 松木猫砂
- 水晶猫砂
- 豆腐猫砂
  - 优点：可以直接冲厕所

如果不考虑直接冲厕所的话，肯定是膨润土和混合猫砂最好。

## 参考资料

- [新手膨润土猫砂推荐（含详细清单攻略）](https://zhuanlan.zhihu.com/p/308486564)
- [2022 年猫砂选购推荐（膨润土、豆腐砂、混合砂）- 知乎](https://zhuanlan.zhihu.com/p/437674365)

第二篇文章的测试手法挺有意思的。

# 2022-07-06

目前 lceda 的原理图和面板项目都还是用的 svg 来做画布，但对于 svg 的很多东西其实我并不熟悉，今天看了一篇文章了解了一下 text 和 tspan 的 dx 和 dy 的用法：

[SVG 文本（一）text、tspan 的基本使用](https://blog.csdn.net/zz00008888/article/details/121099382)

dx 和 dy 可以是一串以空格分界的数字，这样就可以微调每个字符了，每个数字会影响之后的所有字符，而且多个 tspan 的 dx 和 dy 前一个 tspan 会影响后面的。这个设计看起来还不错。

# 2022-07-05

crypto.subtle 在不安全的上下文中是 undefined，比如当网站是 http 的时候。

[How to use SubtleCrypto in chrome (window.crypto.subtle is undefined)](https://stackoverflow.com/questions/46468104/how-to-use-subtlecrypto-in-chrome-window-crypto-subtle-is-undefined)

# 2022-06-30

textarea 中按住 ctrl，alt，shift 以及 win 这几个键，再按 enter，有的能换行有的不能：

能换行的：

- shift

不能换行的（什么都不触发）：

- ctrl
- alt
- win

> 怎么控制光标位置：让输入框的 selectionStart 等于 selectionEnd

# 2022-06-23

## 异或交换

```JavaScript
function swapTwoNumber(a, b){
  a ^= b;
  b ^= a;
  a ^= b;
}
```

异或交换在交换同一个数（内存地址相同，而非仅仅数值相同）的时候，会把这个数变成 0，比如 swap(x,x)，由于执行第一步`a ^= b;`的时候，已经让 x 变成了 0，所以后面再执行剩下两步的时候也变不回来了。

# 2022-06-17

## 弹框等待用户交互

如何实现：在一个弹框的回调（用户点击是或者否）之后才执行接下来的逻辑？

答案是：**用 Promise 就可以阻断代码流程**，弹框之后的逻辑必须等待弹框的回调函数中的 resolve 或 reject 被执行，才能接着执行，而回调函数则必须等待用户的点击，这样就实现了一个等待用户交互的逻辑。

## TS 表达一个对象类型

TS 我一直用的比较少，之前还想一个对象 key 和 value 都是 string，用 ts 怎么表示：`let v: {[key:string]:string}`

# 2022-06-16

在使用 [HTMLInputElement.setSelectionRange()](https://developer.mozilla.org/zh-CN/docs/Web/API/HTMLInputElement/setSelectionRange)时发现一个问题，超出 input 的宽度的位置无法被定位到，也就是说它不会滚动文本，如果想滚动到指定位置怎么办呢？目前还不知道怎么解决。

# 2022-06-15

最近工作很杂乱，事情很多，今天了解了一下斜切是什么，我原先以为是平移+旋转，没想到根本不是，斜切其实是倾斜。最近同事在做斜切椭圆的四点控制，这是他写的关于图形变换的基础的博客：https://zengxiaoluan.com/matrix-image 。从今天开始打算把之前 wordpress 被黑丢失的博客补一补了，主要是一些前端的面试考察点以及工作中遇到的问题和解决方案，大部分可能都想不起来了，能补多少是多少吧。浏览器书签和我来笔记都有点乱，有空也要整理一下。

# 2022-06-12

今早上一起来发现服务器居然连不上了，试了一下居然 ping 不通了，估计是这个 ip 又被墙了。为了尽快弄好翻墙的，我试了朋友发给我的 clashX 以及翻墙配置，真的不错，速度非常快。

主要参考了这篇文章：https://github.com/Hackl0us/SS-Rule-Snippet

Clash 项目地址：https://github.com/Dreamacro/clash

ClashX 项目地址：https://github.com/yichengchen/clashX/

ClashX windows 下载地址：https://github.com/Fndroid/clash_for_windows_pkg/releases/tag/0.19.25

ClashX Pro macOS 下载地址：https://install.appcenter.ms/users/clashx/apps/clashx-pro/distribution_groups/public

ClashX Android 下载地址：https://github.com/Kr328/ClashForAndroid/releases/tag/v2.5.9

购买链接：https://portal.shadowsocks.nz/login

Clash 文档：https://lancellc.gitbook.io/clash/

发现修改 ClashX 的端口不生效，后来找到了原因，原来必须要修改 config.yaml 文件才行：https://github.com/yichengchen/clashX/#Advance Config，其实默认配置里的注释也写了这个坑，但是我瞎了没看到：

![ClashX默认配置](../images/2022/ClashX默认配置.jpg)

我是在 github 的 issue 里面搜到的，反正万事解决不了提 issue。

# 2022-06-11

## wordpress 博客被黑

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

## 办理身份证

今天顺带把身份证重新办了一下，办理身份证前首先需要去照相馆照一张身份证证件照，然后再去派出所户政室办理。证件照需要上传到一个照片质量检测网站上进行核对，并产生一个编号。去户政室的时候提供这个编号他们就可以找到这个照片了。

我是在深圳本地宝上面查到当地派出所户政室的地址的：

http://m.bendibao.com/bsy616684.html

景田的户政室已经从原来的地方搬到香蜜湖了，在高德地图上可以搜得到香蜜湖的户政室地址：`福田公安分局香蜜湖户政服务中心`，另外他们的办公时间也改了，下午 4 点就收摊了。

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

# 2019-02-20

今天联合查询一个 40 万和 1 万的表，发现弄了索引都没啥效果，最后发现是字符集不同导致的。把两个索引的字符集弄成一样的就行了。还有一个问题，mysql8 没有缓存导致查询很慢，mysql5.7 有缓存第二次查询快的飞起。还有同一个语句 mysql8 花了 100 秒，mysql5.7 只花了 10 秒，原因可能是对语句的解释不一样。在将数据库导入到 mysql5.7 的时候遇到一个错误：`2006: mysql server has gone away`。使用：`set global max_allowed_packet=268435456;`解决了。应该是单笔 insert 太大导致的，把配置设高一点就 OK 了。

# 2019-02-19

今天终于解决了一个困扰我一年之久的问题，网易云音乐和知乎账号的登陆异常。我对比了不同的网络环境（IP），不同的账号（别人的知乎账号），不同的浏览器。组合测试最后发现既不是 IP 的单方面的问题，也不是账号的单方面问题，也不是浏览器的单方面的问题。而当我使用无痕浏览的时候并没有任何问题，所以应该是 chrome 浏览器记住了某些东西。最后发现问题出在 chrome 浏览器的账号同步上，可能是因为我的谷歌账号在历史上曾记录了一次知乎异常登陆的 cookie，所以之后的每一次登陆都使用这个 cookie，而且清空都是无效的，在你登陆的时候又会给你自动添加。之后我先登出 chrome 账号，并同时清空所有数据，然后再登陆知乎账号，然后再登陆 chrome 账号同步一次正确的知乎登陆。问题就得到了解决。

知乎问题的根源：

- https://jiasule.v2ex.com/t/533482
- https://www.v2ex.com/t/521180

答案就是：发现一个在开启 IPFS 伴侣时，知乎的大部分接口都会报请求参数异常的 BUG。。

# 2019-01-17

一个奇怪的问题，我配置好了 github 的 ssh key，但每次 push 都跟我索要账号密码。原因是我 clone 的时候用的 http 模式，在项目的.git/config 里面可以修改，改为 ssh 模式即可。感谢 stackoverflow 的小哥：[Why is Github asking for username/password when following the instructions on screen and pushing a new repo?](https://stackoverflow.com/questions/10909221/why-is-github-asking-for-username-password-when-following-the-instructions-on-sc)

# 2018-11-28

一切为了可重用。

代码写得能看懂便于维护，这样代码就能更长久的可重用。

代码模块化，是为了降低耦合，减少依赖，模块内部高内聚，模块之间低耦合，模块可重用。

模块的粒度应该以重用的灵活性为指导原则，不能一味追求小，但基本的客观规律是：比较小的模块更灵活，更容易重用。

一个设计良好的模块的客观标准是：可以随意组合，即插即用。

封装是为了更好的把代码的改动控制在模块内部，从而减少外部的改动需求。API 尽量不变，对外的接口尽量不变。[理解 Java 的三大特性之封装](http://wiki.jikexueyuan.com/project/java-enhancement/java-one.html)

继承则是赤裸裸的在重用代码。

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
