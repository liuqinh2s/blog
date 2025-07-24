---
title: 扁平数组嵌套化（flat to nest）
tags: [编程题]
---

## 扁平数组嵌套化(flat to nest)

1. 菜单数组转换为嵌套树形结构，但示例只有两级

```javascript
[
  { id: 1, menu: '水果', level: 1 },
  { id: 2, menu: '橘子', level: 2, parentId: 1 }
  // ...
]
// 转换为
[
  {
    id: 1, menu: '水果', level: 1, children: [{ id: 2, menu: '橘子', level: 2, parentId: 1 }]
  },
  // ...
]
```

以下是我给出的解答，未经过严格测试

<!-- more -->

```javascript
const a = [
  {
    id: 2,
    menu: "橘子",
    level: 2,
    parentId: 1,
  }, // ...
  {
    id: 1,
    menu: "水果",
    level: 1,
  },
];

function flat2nest(array) {
  const res = [];
  const map = {};
  for (let index = 0; index < array.length; index++) {
    if (map[array[index].id]) {
      map[array[index].id] = {
        ...array[index],
        children: map[array[index].id].children,
      };
    } else {
      map[array[index].id] = { ...array[index] };
    }
    if (!array[index].parentId) {
      res.push(map[array[index].id]);
    } else {
      if (!map[array[index].parentId]) {
        map[array[index].parentId] = {};
      }
      if (!map[array[index].parentId].children) {
        map[array[index].parentId].children = [];
      }
      map[array[index].parentId].children.push({ ...array[index] });
    }
  }
  return res;
}

const b = flat2nest(a);
console.log(b);
```
