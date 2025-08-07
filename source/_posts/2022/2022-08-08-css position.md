---
title: css position
tags: [css]
---

# 参考

https://developer.mozilla.org/zh-CN/docs/Web/CSS/position

可选项有四种：

1. static
2. relative
3. absolute
4. sticky

# static

默认就是 static，在这个选项下，设置 top, bottom, left, right, z-index 无效。

# relative

设置了 relative，也就是说会在该元素原本的位置留白，不会改变页面原来的布局。

# absolute

设置了 absolute，就不会在原本的位置留白，就会影响到页面原来的布局了。相对偏移的对象是最近的非 static 祖先元素。一般是父元素用 relative，子元素用 absolute 这样搭配着来使用，让子元素根据父元素进行绝对定位。

# fixed

固定在视口（viewport）的某个位置，也就是说相对于视口来偏移。元素的位置在屏幕滚动时不会改变。

# sticky

相对于最近的滚动祖先（当该祖先的`overflow` 是 `hidden`, `scroll`, `auto`, 或 `overlay`时）偏移。sticky 一般用来实现表格的表头固定

# 总结

强烈建议用 MDN Web Docs 的例子，亲身体会一下。
