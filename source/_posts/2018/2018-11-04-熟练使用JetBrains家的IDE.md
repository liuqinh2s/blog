---
title: 熟练使用JetBrains家的IDE
categories: [工具]
comments: true
---

## 通用快捷键

1. 格式化代码（reformat code）:
   win: ctrl+alt+L
   mac: command+option+L
2. 在一行的任意位置使用： shift + enter，新建下一行并跳到下一行。
3. 善用代码自动补全功能，变量名和方法名等可以用 enter 补全。导入包可以用 alt + enter。
4. 上下移动代码，ctrl+shift+上下键
5. Android Studio 生成函数注释：你在方法前输入/\*\*然后一回车，自动帮你生成方法和参数的注释。

<!-- more -->

## Intellj Idea

快速打出常用语句：

1. **sout**：`System.out.println();`
2. **psvm**：

```java
public static void main(String[] args) {

}
```

3. 使用 IDE 的右键中的生成 Getter Setter 选项自动生成 Getter Setter，使用 toString 自动生成 toString。

4. 跳转到接口：`ctrl+b`； 跳转到实现类：`ctrl + alt +B`

5. ![](../../../../images/2018/idea图解.png)

上面这个按钮可以快速的在目录树中定位到当前类所在的路径

6. ctrl+alt+t

![idea-ctrl+alt+t.png](../../../../images/2018/idea-ctrl+alt+t.png)
