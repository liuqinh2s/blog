---
title: flex，flex-grow，flex-shrink，flex-basis
tags: [前端, css]
---

面试官问：flex: 2 有用过吗？多列布局怎么实现？

[flex - CSS：层叠样式表 | MDN](https://developer.mozilla.org/zh-CN/docs/Web/CSS/flex)

## flex，flex-grow，flex-shrink，flex-basis

这个东西的计算公式官网没有公布，导致只能查别人写的资料，或者自己推导。经过多次实验后，结论如下：

<!-- more -->

### flex-grow

grow 的计算跟自身宽高无关，直接按比例分配剩余的空间，shrink 的计算是跟自身宽高有关的，需要根据自身宽高，按加权比例平摊（缩减）超出的空间。

假设计算的是水平方向的 flex：

grow 的算法如下：

单个元素需要 grow 的量：`(单个子元素 flex-grow/总的 flex-grow)*(父容器宽度-子元素宽度之和)`

实验地址：

<iframe height="300" style="width: 100%;" scrolling="no" title="示例Pen" src="https://codepen.io/liuqinh2s/embed/qEbNEOV" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
</iframe>

### flex-shrink

shrink 的算法如下：

假设 div1 是 100px, flex-shrink:1；div2 是 200px, flex-shrink:2；div3 是 300px, flex-shrink: 3。容器宽度 400px

- div1 元素需要 shrink 的量：`(100*1)/(100*1+200*2+300*3)*(100+200+300 - 400)`
- div2 元素需要 shrink 的量：`(200*2)/(100*1+200*2+300*3)*(100+200+300 - 400)`
- div3 元素需要 shrink 的量：`(300*3)/(100*1+200*2+300*3)*(100+200+300 - 400)`

也就是加权比例，需要用到自身的宽高

抽象表达：

单个元素需要 shrink 的量：`(自身宽度*单个子元素flex-shrink)/(sum(自身宽度*单个子元素flex-shrink))*(子元素宽度之和-父容器宽度)`

实验地址：

<iframe height="300" style="width: 100%;" scrolling="no" title="示例Pen" src="https://codepen.io/liuqinh2s/embed/vELKYjp" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
</iframe>

### flex-basis

flex-basis 就是宽高的意思，但比宽高优先级高，比如定义了 width: 100px; flex-basis: 0px;那么就是按 0 去进行 flex 的。
