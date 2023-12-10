---
title: C++ map的remove函数实现
tags: [C++]
---

今天同学群里面讨论了这样一段代码，说是产品出了 bug，现场急着修复。

<!--more-->

```c++
#include <iostream>
#include <map>
#include <string>

int main()
{
    std::cout << "hello world" << std::endl;
    std::map<int, std::string> mapPeople;
    mapPeople[1] = "hexu1";
    mapPeople[2] = "hexu2";
    // mapPeople[3] = "hexu3";
    // mapPeople[4] = "hexu4";

    std::map<int, std::string>::iterator iter = mapPeople.begin();
    for (; iter != mapPeople.end(); iter++)
    {
        if (iter->first == 2)
        {
            std::cout << "id : " << iter->first << ", name : " << iter->second << std::endl;
            mapPeople.erase(iter++);
            std::cout << (iter != mapPeople.end()) << std::endl;
        }
    }


    //for (; iter != mapPeople.end();)
    //{
    //	if (iter->first == 2)
    //	{
    //		std::cout << "id : " << iter->first << ", name : " << iter->second << std::endl;
    //		mapPeople.erase(iter++);
    //		if (iter == mapPeople.end())
    //			break;
    //	}
    //	iter++;
    //}

//    getchar();
    return 0;
}
```

说是第一个 for 循环会崩溃，第二个 for 循环可以通过。经过分析，主要问题其实是出在对迭代器和 erase 的不熟悉上，导致错误的使用，这个程序的错误很明显，就是在 erase 这条分支中，iter++了两次。那么如何写一个正确的 remove 函数呢？代码如下：

```c++
#include <iostream>
#include <map>
#include <string>

int main()
{
    std::cout << "hello world" << std::endl;
    std::map<int, std::string> mapPeople;
    mapPeople[1] = "hexu1";
    mapPeople[2] = "hexu2";
    mapPeople[3] = "hexu3";
    mapPeople[4] = "hexu4";

    std::map<int, std::string>::iterator iter = mapPeople.begin();
    while (iter != mapPeople.end())
    {
        if (iter->first == 2)
        {
            std::cout << "id : " << iter->first << ", name : " << iter->second << std::endl;
            iter = mapPeople.erase(iter);
            continue;
        }
        iter++;
    }

    return 0;
}
```

另外，碰到删除的时候，要小心，可以这么写：`iter = mapPeople.erase(iter);`，也可以这么写：`mapPeople.erase(iter++);`（必须在删除前给迭代器++，否则迭代器会失效，这个问题那位程序员倒是考虑到了）。

最后我想说的一点是，根据指定 key 删除 map 中的元素，这个功能在其他语言中都有库函数可以调用，而 C++却没有，还要自己动手写，而且需要对 map 的原理有一定的了解。这就从侧面反映了 C++可能并不是一个高效的生产工具。
