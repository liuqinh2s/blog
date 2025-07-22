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

4. 多次 setState 只会触发一次重新渲染。
5. `useState(func)`，中的 func 函数只会在组件第一次渲染的时候执行，重新渲染不会执行。

## useEffect

useEffect 有两个参数，第一个参数是副作用函数，第二个参数是依赖数组。在组件渲染的时候，如果发现依赖数组中某项变了，就会在组件渲染结束后调用副作用函数。如果不传第二个参数，则每次组件渲染都会调用副作用函数。如果传入空数组，则只在第一次渲染的时候调用副作用函数。

## useLayoutEffect

useLayoutEffect 和 useEffect 是 react 中用于处理副作用的两个核心 Hook，它们两个的区别在于**执行时机**和**对页面渲染的影响**

### 执行时机

- useEffect 在浏览器完成**布局（DOM 更新）和绘制（屏幕渲染）后异步执行**。这意味着它不会阻塞浏览器的渲染流程，用户会先看到页面更新，再执行副作用逻辑。
  ```JavaScript
  useEffect(() => { console.log("异步执行，不阻塞渲染"); }, []);
  ```
- useLayoutEffect 在浏览器完成**布局后，绘制前同步执行**。它会阻塞浏览器的渲染，确保副作用在用户看到屏幕前完成。
  ```JavaScript
  useLayoutEffect(() => { console.log("同步执行，阻塞渲染"); }, []);
  ```

### 对页面渲染的影响

- useEffect
  - 不阻塞渲染，适合非紧急操作（如数据请求，事件订阅）
  - 可能导致闪烁：若副作用修改了 DOM 样式（如调整元素位置），用户可能先看到初始状态，再看到更新后的状态，出现视觉跳动
- useLayoutEffect
  - 阻塞渲染，确保 DOM 修改在绘制前完成，避免闪烁问题
  - 性能风险：若副作用逻辑耗时较长（如循环更新状态），会延迟页面渲染，导致卡顿

### 示例

```JavaScript
// 示例：防止闪烁（useLayoutEffect）
function Tooltip() {
  const ref = useRef(null);
  const [height, setHeight] = useState(0);

  useLayoutEffect(() => {
    // 同步获取元素高度，避免用户先看到未调整的布局
    setHeight(ref.current.getBoundingClientRect().height);
  }, []);

  return <div ref={ref}>高度: {height}px</div>;
}
```

### 注意事项

1. useEffect 和 useLayoutEffect 均可返回清理函数（如移除事件监听），但 useLayoutEffect 的清理在绘制前同步执行
2. useLayoutEffect 在 服务端渲染(SSR) 中会触发警告（因无 DOM 环境），需替换为 useEffect

## useRef

函数内部定义的变量，在每次调用函数的时候，都会重新创建。如果不想重新创建，要么在组件外定义变量，要么使用 useRef 定义变量。

useRef 的参数只在组件第一次渲染的时候作为返回值，useRef 返回的值，在组件每次渲染的时候都保持引用地址不变。

示例：[useRef-example-1](https://codesandbox.io/p/sandbox/jgzkxl)

## useCallback

函数中的函数，每次调用外层函数时，内层函数都会重新创建，会有 CPU 和内存开销。怎么证明内层函数被重新创建了呢，直接对比函数引用即可：`func1 === func2`，若不相等，则不是同一个函数。

useCallback 就是用来防止组件内的函数被重复创建的。useCallback 的第一个参数就是需要被缓存的函数，第二个参数是依赖项，只有依赖项发生变化，才会返回新的函数引用。

```JavaScript
const memoizedFn = useCallback(Fn, [dependencies]);
```

如果没有用到组件中的变量，可以直接把函数写到组件外，这样连 useCallback 都不必使用了。

### 适用场景

1. 函数作为 props 传递给用`React.memo`包裹的子组件，可以避免子组件重新渲染
2. 函数被其他 Hook 依赖 ​​（如 useEffect、useMemo）
3. 自定义 Hook 返回的函数 ​​，确保调用方可优化
4. 对于频繁触发的函数（如表单输入、滚动事件），缓存可降低重复创建函数的性能损耗

## useMemo

useMemo 和 useCallback 的唯一区别在于，useMemo 返回函数的计算结果的缓存，useCallback 返回函数本身的缓存。即：`useCallback(fn, depsArray)等价于 useMemo(()=>fn, depsArray)`。React 分开设计是为了**语义清晰**和**减少误用**（如 useMemo 直接返回函数易出错）

```JavaScript
const memoizedFn = useCallback(() => {}, [deps]);      // 缓存函数
const memoizedValue = useMemo(() => compute(), [deps]); // 缓存值
```

- 语义意图：useMemo 表达“缓存计算”，useCallback 表达“缓存函数”
- ​​ 优化对象 ​​：useMemo 减少计算开销，useCallback 减少渲染开销；
- ​​ 设计目的 ​​：分离二者可提升代码可读性，降低误用风险

## useContext

## useReducer

## 一些疑问

像 useEffect，useCallback，useMemo 这类有依赖项的 Hook，是怎么记录上一次的依赖项的，在组件重新渲染时不是要对比上一次的依赖项和此次依赖项是否相同吗。
