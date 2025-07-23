---
title: 常用 react hooks 总结
tags: [react]
---

最近又开始面试了，然后发现基础还是不牢固，工作中用到的技术确实是比较有限的，平常还要多夯实基础，查漏补缺，不然面试的时候很多东西答不上来。今天面试官问 useCallback，我发现平常不用它，加上好久没复习，我已经全然不记得了。

<!-- more -->

## useState

useState 返回包含两个值的数组，第一个值是变量 state，第二个值是用来更新这个变量的函数 setState，每当 state 的值改变，就会触发重新渲染（re-render）。

示例：

```jsx
const [appleCount, setAppleCount] = useState(1);
console.log(appleCount); //1

setAppleCount((prev) => prev + 1);
console.log(appleCount); // 2
```

### 注意事项

1. 不要直接去修改 state，只有用 setState 函数去改，才会触发重新渲染。
2. 并不是调用 setState 就一定会重新渲染，如果设置的 state 跟上次一样，就不会重新渲染。
3. setState 并不会立即更新 state，而是等收集完所有的 setState 最后再统一更新，若想用上个 setState 更新后的值，就要用回调函数的方式写：

   ```jsx
   function A() {
     const [count, setCount] = useState(4);

     setCount(count + 1);
     setCount(count + 1);
     console.log("A: ", count); // ?
   }

   function B() {
     const [count, setCount] = useState(4);

     setCount((prev) => prev + 1);
     setCount((prev) => prev + 1);
     console.log("B: ", count); // ?
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
  ```jsx
  useEffect(() => {
    console.log("异步执行，不阻塞渲染");
  }, []);
  ```
- useLayoutEffect 在浏览器完成**布局后，绘制前同步执行**。它会阻塞浏览器的渲染，确保副作用在用户看到屏幕前完成。
  ```jsx
  useLayoutEffect(() => {
    console.log("同步执行，阻塞渲染");
  }, []);
  ```

### 对页面渲染的影响

- useEffect
  - 不阻塞渲染，适合非紧急操作（如数据请求，事件订阅）
  - 可能导致闪烁：若副作用修改了 DOM 样式（如调整元素位置），用户可能先看到初始状态，再看到更新后的状态，出现视觉跳动
- useLayoutEffect
  - 阻塞渲染，确保 DOM 修改在绘制前完成，避免闪烁问题
  - 性能风险：若副作用逻辑耗时较长（如循环更新状态），会延迟页面渲染，导致卡顿

### 示例

```jsx
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

核心特性：

- 持久性：存储的值在组件重新渲染时不会重新创建
- 无重渲染：修改.current 属性不会触发组件重新渲染，适用于与 UI 无关的数据
- 同步更新：对.current 的修改立即生效，无需等待渲染周期

### 使用场景案例

1. 访问 DOM 元素
   通过将 ref 绑定到 JSX 元素，直接操作 DOM：

   ```jsx
   import { useRef } from "react";
   function InputFocus() {
     const inputRef = useRef(null);
     const handleClick = () => inputRef.current.focus(); // 聚焦输入框
     return (
       <>
         <input ref={inputRef} />
         <button onClick={handleClick}>聚焦</button>
       </>
     );
   }
   ```

2. 存储可变数据（不触发重新渲染）
   保存与渲染无关的变量（如定时器 ID、缓存数据）

   ```jsx
   function Timer() {
     const timerRef = useRef(null);
     const startTimer = () => {
       timerRef.current = setInterval(() => console.log("Running..."), 1000);
     };
     const stopTimer = () => clearInterval(timerRef.current);
     return (
       <div>
         <button onClick={startTimer}>开始</button>
         <button onClick={stopTimer}>停止</button>
       </div>
     );
   }
   ```

3. 跨渲染持久化数据 ​
   记录前一次状态或渲染次数

   ```jsx
   function Counter() {
     const [count, setCount] = useState(0);
     const prevCountRef = useRef();
     useEffect(() => {
       prevCountRef.current = count; // 更新前保存当前值
     }, [count]);
     return (
       <div>
         当前值: {count}, 之前值: {prevCountRef.current}
         <button onClick={() => setCount(count + 1)}>增加</button>
       </div>
     );
   }
   ```

### 高级应用模式

1. 跨组件传递 Ref（forwardRef）
   父组件访问子组件的 DOM 节点：

   ```jsx
   const Child = forwardRef((props, ref) => <input ref={ref} />);
   const Parent = () => {
     const inputRef = useRef(null);
     return <Child ref={inputRef} />; // 父组件通过 inputRef 操作子组件输入框
   };
   ```

2. 暴露子组件方法（useImperativeHandle）
   自定义子组件暴露给父组件的方法：
   ```jsx
   const Child = forwardRef((props, ref) => {
     const inputRef = useRef(null);
     useImperativeHandle(ref, () => ({
       focus: () => inputRef.current.focus(),
     }));
     return <input ref={inputRef} />;
   });
   ```

### useRef 和组件外部定义的变量对比

useRef 的生命周期绑定于组件实例，组件挂载时创建，卸载时自动释放内存。useRef 的作用域仅限当前组件实例内部访问，不同组件不同实例互不干扰。外部定义的变量存在以下问题：

1. 无法绑定 DOM
2. 易污染全局状态
3. 可能忘记销毁，造成内存泄漏
4. 全局共享，所有组件实例均可访问和修改，易造成污染，多组件并发操作时可能导致逻辑混乱，多组件之间会相互影响

## useCallback

函数中的函数，每次调用外层函数时，内层函数都会重新创建，会有 CPU 和内存开销。怎么证明内层函数被重新创建了呢，直接对比函数引用即可：`func1 === func2`，若不相等，则不是同一个函数。

useCallback 就是用来防止组件内的函数被重复创建的。useCallback 的第一个参数就是需要被缓存的函数，第二个参数是依赖项，只有依赖项发生变化，才会返回新的函数引用。

```jsx
const memoizedFn = useCallback(Fn, [dependencies]);
```

如果没有用到组件中的变量，可以直接把函数写到组件外，这样连 useCallback 都不必使用了。

### 适用场景

1. 函数作为 props 传递给用`React.memo`包裹的子组件，可以避免子组件重新渲染
2. 函数被其他 Hook 依赖 ​​（如 useEffect、useMemo）
3. 自定义 Hook 返回的函数 ​​，确保调用方可优化
4. 对于频繁触发的函数（如表单输入、滚动事件），缓存可降低重复创建函数的性能损耗

### React.memo

React.memo 是 react 提供的高阶组件（HOC），专门用于优化函数组件的性能。它通过记忆组件的渲染结果，避免在父组件重新渲染时触发不必要的子组件重新渲染，从而提高应用性能。

1. 浅比较（Shallow Comparison）：
   默认情况下，React.memo 会对组件的 props 进行浅比较（比较引用地址而非深层内容），若 props 未变化，则跳过重新渲染，直接复用上一次的渲染结果。
   ```jsx
   const MemoizedComponent = React.memo(MyComponent); // 包装后组件仅在 props 变化时渲染
   ```
   示例：[React.memo-example-1](https://codesandbox.io/p/sandbox/2m6n5x)
2. 自定义比较函数：
   若 props 包含复杂对象或数组，可通过第二个参数传入自定义比较函数，手动控制渲染逻辑：
   ```jsx
   const areEqual = (preProps, nextProps) =>
     preProps.user.name === nextProps.user.name;
   const MemoizedComponent = React.memo(MyComponent, areEqual); // 仅当 name 变化时重新渲染
   ```

若组件依赖全局状态（Context）或内部状态（State），React.memo 无法阻止其更新

## useMemo

useMemo 和 useCallback 的唯一区别在于，useMemo 返回函数的计算结果的缓存，useCallback 返回函数本身的缓存。即：`useCallback(fn, depsArray)等价于 useMemo(()=>fn, depsArray)`。React 分开设计是为了**语义清晰**和**减少误用**（如 useMemo 直接返回函数易出错）

```jsx
const memoizedFn = useCallback(() => {}, [deps]); // 缓存函数
const memoizedValue = useMemo(() => compute(), [deps]); // 缓存值
```

- 语义意图：useMemo 表达“缓存计算”，useCallback 表达“缓存函数”
- ​​ 优化对象 ​​：useMemo 减少计算开销，useCallback 减少渲染开销；
- ​​ 设计目的 ​​：分离二者可提升代码可读性，降低误用风险

## useContext

如果不是父组件传递 props 给子组件，而是隔了好几层组件，层层传递 props 的方案就显得太麻烦了。这时候就可以用到 useContext，在函数组件中**跨层级共享状态**，解决深层嵌套组件的数据传递问题，无需中间组件透传 props。

> 典型场景：主题切换，用户登录状态，多语言文本等全局数据

作用机制：

- 通过`createContext`创建上下文对象，此对象包含 Provider（提供数据）和 Consumer（消费数据，已被 useContext 替代）
- Provider 组件通过 value 属性传递数据，子组件通过 useContext(Context)直接获取数据
- 当 Provider 的 value 变化时，所有使用该上下文的组件自动重新渲染

示例：

```jsx
// 1. 创建上下文
const ThemeContext = createContext("light");

// 2. 提供数据（通常在顶层组件）
const App = () => {
  return (
    <ThemeContext.Provider value="dark">
      <Child />
    </ThemeContext.Provider>
  );
};

// 3. 消费数据（任意子组件）
function Child() {
  const theme = useContext(ThemeContext); // 获取值"dark"
  return <div>当前主题：{theme}</div>;
}
```

### 常见用法

1. 动态更新能力
   结合状态管理 Hook（useState/useReducer），子组件可直接修改上下文数据：

   ```jsx
   // Provider中传递状态和更新函数
   <UserContext.Provider value={{ user, setUser }}>
     {children}
   </UserContext.Provider>;

   // 子组件调用更新
   const { setUser } = useContext(UserContext);
   setUser({ name: "张三" });
   ```

2. 多上下文嵌套
   支持多个 Provider 嵌套，组件可以同时消费多个上下文：

   ```jsx
   <ThemeContext.Provider>
     <UserContext.Provider>
       <App />
     <UserContext.Provider>
   </ThemeContext.Provider>
   ```

3. 避免不必要的渲染
   问题：value 变化时所有消费者组件重新渲染，可能引发性能问题。
   优化方案：

   - 拆分 Context：将频繁更新和不常更新的数据分离到不同上下文（如 UserContext 和 ThemeContext）
   - 缓存 value：使用 useMemo 缓存，避免每次渲染重新创建对象：
     ```jsx
     const value = useMemo(()=>{user, login}, [user])
     <AuthContext.Provider value={value}>
     ```
   - 组件优化：使用 React.memo 避免子组件无意义渲染

4. 类型安全（Typescript）
   通过泛型定义上下文类型，避免运行时错误：
   ```typescript
   interface ThemeControl {
     mode: "light" | "dark";
     toggleMode: () => void;
   }
   const ThemeContext = createContext<ThemeControl | null>(null);
   ```

### 常见问题

1. 默认值生效条件
   当组件没有被 Provider 包裹时，useContext 返回 createContext 的默认值
2. 使用限制
   只能在函数组件或自定义 Hook 中调用，不可在类组件中使用
3. Provider 嵌套覆盖
   组件始终使用最近一层 Provider 提供的值

## useReducer

useReducer 是 React 提供的管理复杂状态逻辑的 Hook，其设计灵感来源于 Redux 的状态管理模型，集中化状态更新逻辑。

### 基本用法

1. 基本结构

```jsx
const [state, dispatch] = useReducer(reducer, initialState);
```

- reducer 函数：接收当前状态 state 和描述操作的对象 action，返回新状态：
  ```jsx
  function reducer(state, action){
    switch(action.type) {
      case: 'INCREMENT': {
        return {count: state.count+1};
      }
      case: 'DECREMENT': {
        return {count: state.count -1};
      }
      default: {
        return state;
      }
    }
  }
  ```
- dispatch 函数：用于触发状态更新（如 `dispatch({type: 'INCREMENT'})`）
- 初始状态：支持通过初始化函数惰性计算（如 `useReducer(reducer, 0, initFunc)`）

2. 工作流程
   组件通过`dispatch(action)`发送操作指令 -> reducer 根据 action.type 计算新状态 -> 组件使用新状态重新渲染

## 一些疑问

像 useEffect，useCallback，useMemo 这类有依赖项的 Hook，是怎么记录上一次的依赖项的，在组件重新渲染时不是要对比上一次的依赖项和此次依赖项是否相同吗。

答：react 为每个组件创建一个 Fiber 节点，Fiber.memoizedState 属性指向一个单向链表，链表中的每个节点对应一个 Hook。useEffect 的 Hook 节点也有一个 memoizedState 属性，指向一个 effect 对象（包含 create、destroy、deps 等字段，其中 deps 就是依赖项）。useCallback 和 useMemo 的 Hook 节点也有一个 memoizedState 属性，指向一个数组（如 [callback, deps]）。react 严格按照 Hook 的调用顺序匹配链表节点，因此必须在顶层调用 Hook，不能把 Hook 写到条件中。
