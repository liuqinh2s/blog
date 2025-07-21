---
title: 常用 react hooks 总结
tags: [react]
---

最近又开始面试了，然后发现基础还是不牢固，工作中用到的技术确实是比较有限的，平常还要多夯实基础，查漏补缺，不然面试的时候很多东西答不上来。今天面试官问 useCallback，我发现平常不用它，加上好久没复习，我已经全然不记得了。

<!-- more -->

## useState

useState 返回包含两个值的数组，第一个值是变量 state，第二个值是用来更新这个变量的函数 setState，每当 state 的值改变，就会触发重新渲染（re-render）。

示例：

```JavaScript
const [appleCount, setAppleCount] = useState(1);
console.log(appleCount); //1

setAppleCount(prev => prev + 1);
console.log(appleCount) // 2
```

### 注意事项

1. 不要直接去修改 state，只有用 setState 函数去改，才会触发重新渲染。
2. 并不是调用 setState 就一定会重新渲染，如果设置的 state 跟上次一样，就不会重新渲染。
3. setState 并不会立即更新 state，而是等收集完所有的 setState 最后再统一更新，若想用上个 setState 更新后的值，就要用回调函数的方式写：

```JavaScript
function A () {
    const [count, setCount] = useState(4);

    setCount(count + 1);
    setCount(count + 1);
    console.log('A: ', count) // ?
}

function B () {
    const [count, setCount] = useState(4);

    setCount(prev => prev + 1);
    setCount(prev => prev + 1);
    console.log('B: ', count) // ?
}

// Answer
// A: 5
// B 6
```

4.

## useEffect

## useLayoutEffect

## useRef

## useCallback

## useMemo

## useContext

## useReducer
