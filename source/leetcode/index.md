---
title: leetcode合集
---

这里是我的 leetcode 做题笔记，以前是用写一篇文章的方式发布 leetcode 做题笔记的，现在觉得，或许开个专栏更好，因为有每日一题的打算，就不用水那么多篇文章了。自从我开始以时间为分类的方式用专栏来记录自己的每日活动，我发现自己表达的欲望也变强了，记录和回过头来检索这些信息的效率也都提高了，真是不错的方法。

# 2025-06-26

[2311. Longest Binary Subsequence Less Than or Equal to K](https://leetcode.com/problems/longest-binary-subsequence-less-than-or-equal-to-k/?envType=daily-question&envId=2025-06-26)

```typescript
function longestSubsequence(s: string, k: number): number {
  const len = k.toString(2).length;
  for (let i = 1; i <= s.length; i++) {
    if (s.at(-i) === "1") {
      const substr = s.substring(s.length - i);
      if (parseInt(substr, 2) > k) {
        // console.log(s.substring(0, s.length-i), s.substring(s.length-i))
        return (
          s
            .substring(0, s.length - i)
            .split("")
            .filter((x) => x === "0").length +
          substr.length -
          1
        );
      }
    }
  }
  return s.length;
}
```

这个题目的子字符串跟我们平常说的子字符串有点区别，应该说它是任意几个子字符串拼接起来，而不是单个子串。

这个题目我看了官方的解法说是贪心算法

这个题目有以下几个规律：

1. 如果用纯 0，那肯定是符合`<=k`这个条件的，所以这个子字符串的长度一定大于等于纯 0。
2. 前导 0 是不会让数字变大，但是可以让最终子串变长的，所以前导 0 是多多益善。
3. 优先往最终结果中添加低位的 1，可以使最终结果容纳尽可能多的 1

# 2025-06-24

[2200. Find All K-Distant Indices in an Array](https://leetcode.com/problems/find-all-k-distant-indices-in-an-array/description/?envType=daily-question&envId=2025-06-24)

```Typescript
function findKDistantIndices(nums: number[], key: number, k: number): number[] {
    let indexes = []
    for(let i=0;i<nums.length;i++){
        if(nums[i] === key){
            indexes.push(i);
        }
    }
    let res= [];
    for(let i=0;i<nums.length;i++){
        for(let j=0;j<indexes.length;j++){
            if(Math.abs(i-indexes[j])<=k){
                res.push(i);
                break;
            }
        }
    }
    return res;
};
```

在做这题的时候，我莫名其妙认为要加`nums[i]<=nums[indexes[j]]`，看来不止 AI 有幻觉，人也有幻觉。

其实只要判断多少距离内有没有目标数就可以了，只需要一个条件：`Math.abs(i-indexes[j])<=k`。根本就没有大小关系的限制

# 2025-06-23

[3442. Maximum Difference Between Even and Odd Frequency I](https://leetcode.com/problems/maximum-difference-between-even-and-odd-frequency-i/description/?envType=daily-question&envId=2025-06-10)

```Typescript
function maxDifference(s: string): number {
    const map = {};
    let minEven = Infinity;
    let maxOdd = 0;
    for(let i=0;i<s.length;i++){
        if(map[s[i]] !== undefined){
            map[s[i]]++;
        } else {
            map[s[i]]=1;
        }
    }
    for(let k of Object.keys(map||{})){
        if(map[k]%2 === 0){
            minEven = Math.min(map[k], minEven)
        } else {
            maxOdd = Math.max(map[k], maxOdd)
        }
    }
    // console.log('maxOdd: ', maxOdd, 'minEven: ', minEven)
    return maxOdd - minEven;
};
```

这题一开始我有两个误解：

1. 以为偶数也要取最大的
2. 算最值的时候放到遍历字符串的循环里面去了，导致计算偶数的时候也把最大奇数更新了

# 2024-02-18

[589. N 叉树的前序遍历](https://leetcode.cn/problems/n-ary-tree-preorder-traversal/description/?envType=daily-question&envId=2024-02-18)

树的前序遍历

```typescript
/**
 * Definition for node.
 * class Node {
 *     val: number
 *     children: Node[]
 *     constructor(val?: number) {
 *         this.val = (val===undefined ? 0 : val)
 *         this.children = []
 *     }
 * }
 */

function preorder(root: Node | null): number[] {
  if (root == null) {
    return [];
  }
  const res = [root.val];
  root.children.forEach((p) => res.push(...preorder(p)));
  return res;
}
```

# 2023-12-11

[1631. 最小体力消耗路径](https://leetcode.cn/problems/path-with-minimum-effort/description/)

二分查找+BFS

有种以前做过类似题目的感觉

```typescript
function minimumEffortPath(heights: number[][]): number {
  const arr = heights.flat();
  const x = Math.abs(Math.min(...arr) - Math.max(...arr));
  console.log(x);
  return binarySearch(0, x);

  function binarySearch(start: number, end: number) {
    const mid = Math.floor((start + end) / 2);
    if (bfs(heights, [[0, 0]], new Set(), mid)) {
      if (start >= end) {
        return end;
      }
      return binarySearch(start, mid - 1);
    } else {
      if (start >= end) {
        return end + 1;
      }
      return binarySearch(mid + 1, end);
    }
  }
}

function bfs(
  heights: number[][],
  queue: number[][],
  visited: Set<string>,
  x: number
) {
  while (queue.length) {
    const [i, j] = queue.shift();
    if (visited.has(i + "," + j)) {
      continue;
    }
    if (i === heights.length - 1 && j === heights[0].length - 1) {
      return true;
    }
    if (i - 1 >= 0 && Math.abs(heights[i][j] - heights[i - 1][j]) <= x) {
      queue.push([i - 1, j]);
    }
    if (
      i + 1 < heights.length &&
      Math.abs(heights[i][j] - heights[i + 1][j]) <= x
    ) {
      queue.push([i + 1, j]);
    }
    if (j - 1 >= 0 && Math.abs(heights[i][j] - heights[i][j - 1]) <= x) {
      queue.push([i, j - 1]);
    }
    if (
      j + 1 < heights[0].length &&
      Math.abs(heights[i][j] - heights[i][j + 1]) <= x
    ) {
      queue.push([i, j + 1]);
    }
    visited.add(i + "," + j);
  }
  return false;
}
```

# 2023-11-19

[2625. 扁平化嵌套数组](https://leetcode.cn/classic/problems/flatten-deeply-nested-array/description/)

这题是我在整理前端面试题的时候，为了测试我的代码是否正确找出来的。

```typescript
type MultiDimensionalArray = (number | MultiDimensionalArray)[];

var flat = function (
  array: MultiDimensionalArray,
  nums: number
): MultiDimensionalArray {
  if (nums <= 0) {
    return array;
  }
  const res: MultiDimensionalArray = [];
  for (let index = 0; index < array.length; index++) {
    if (Array.isArray(array[index])) {
      res.push(...flat(array[index] as MultiDimensionalArray, nums - 1));
    } else {
      res.push(array[index]);
    }
  }
  return res;
};
```

# 2023-11-15

[2656. K 个元素的最大和](https://leetcode.cn/problems/maximum-sum-with-exactly-k-elements/solutions/2524816/k-ge-yuan-su-de-zui-da-he-by-leetcode-so-0ci1/)

这题太简单了，用到了等差数列和

```typescript
function maximizeSum(nums: number[], k: number): number {
  let maxIndex = 0;
  for (let i = 0; i < nums.length; i++) {
    if (nums[i] > nums[maxIndex]) {
      maxIndex = i;
    }
  }
  return (k * (nums[maxIndex] * 2 + k - 1)) / 2;
}
```

# 2023-11-14

[307. 区域和检索 - 数组可修改](https://leetcode.cn/problems/range-sum-query-mutable/description/?envType=daily-question&envId=2023-11-13)

虽说这是道中等题，但是我是第一次接触线段树，而且离谱的是暴力法居然也能通过（那这题就失去意义了）

线段树是用树的方式存储下区间的一些信息，比如区间和，以空间换时间的方式来优化求区间信息的时间复杂度。构造线段树时间复杂度是 O(n)，更新线段树是 O(logN)，查询是 O(logN)

举个具体的例子来展示一下线段树的原理：

例如我们有个数组：`[10, 11, 12, 13, 14]`，构造成线段树就是如下：

![线段树](https://oi-wiki.org/ds/images/segt1.svg)

用堆来表示线段树那就是如下数组：`[60, 33, 27, 21, 12, 13, 14, 10, 11]`

此 leetcode 题解代码如下：

```typescript
class NumArray {
  segementTree: SegmentTree;
  constructor(nums: number[]) {
    this.segementTree = new SegmentTree(nums);
  }

  update(index: number, val: number): void {
    this.segementTree.update(
      index,
      val,
      0,
      this.segementTree.rawData.length - 1,
      0
    );
  }

  sumRange(left: number, right: number): number {
    return this.segementTree.getSum(
      left,
      right,
      0,
      this.segementTree.rawData.length - 1,
      0
    );
  }
}

class SegmentTree {
  data: number[] = [];
  rawData: number[] = [];

  build(index: number, start: number, end: number) {
    if (start === end) {
      this.data[index] = this.rawData[start];
      return;
    }
    const mid = start + ((end - start) >> 1);
    this.build(index * 2 + 1, start, mid);
    this.build(index * 2 + 2, mid + 1, end);
    this.data[index] = this.data[index * 2 + 1] + this.data[index * 2 + 2];
  }

  constructor(rawData: number[]) {
    this.rawData = rawData;
    this.build(0, 0, rawData.length - 1);
    console.log(rawData, this.data);
  }

  getSum(
    searchStart: number,
    searchEnd: number,
    curStart: number,
    curEnd: number,
    index: number
  ) {
    if (searchStart === curStart && searchEnd === curEnd) {
      return this.data[index];
    }
    const mid = curStart + ((curEnd - curStart) >> 1);
    let sum = 0;
    if (searchEnd <= mid) {
      sum += this.getSum(searchStart, searchEnd, curStart, mid, index * 2 + 1);
    } else if (searchStart > mid) {
      sum += this.getSum(
        searchStart,
        searchEnd,
        mid + 1,
        curEnd,
        index * 2 + 2
      );
    } else {
      sum +=
        this.getSum(searchStart, mid, curStart, mid, index * 2 + 1) +
        this.getSum(mid + 1, searchEnd, mid + 1, curEnd, index * 2 + 2);
    }
    return sum;
  }

  update(
    updateIndex: number,
    value: number,
    curStart: number,
    curEnd: number,
    index: number
  ) {
    if (curStart === curEnd && updateIndex === curStart) {
      this.rawData[updateIndex] = value;
      this.data[index] = value;
      return;
    }
    if (updateIndex >= curStart && updateIndex <= curEnd) {
      const mid = curStart + ((curEnd - curStart) >> 1);
      this.update(updateIndex, value, curStart, mid, index * 2 + 1);
      this.update(updateIndex, value, mid + 1, curEnd, index * 2 + 2);
      this.data[index] = this.data[index * 2 + 1] + this.data[index * 2 + 2];
    }
  }
}
```

# 2023-11-09

[2258. 逃离火灾](https://leetcode.cn/problems/escape-the-spreading-fire/description/?envType=daily-question&envId=2023-11-09)

这道题稍微有点复杂，主要设计到两个算法，**广度优先遍历**和**二分搜索**

我封装出了一个扩散方法：`spread`

```typescript
function maximumMinutes(grid: number[][]): number {
  grid[0][0] = 3;
  const fireSpreadTime = getSpreadTime(grid, 1);
  const peopleSpreadTime = getSpreadTime(grid, 3);
  if (peopleSpreadTime === 1e9) {
    return -1;
  }
  if (fireSpreadTime === 1e9) {
    return 1e9;
  }
  if (!canGetOut(grid)) {
    return -1;
  }
  const time = fireSpreadTime - peopleSpreadTime;
  // console.log(fireSpreadTime, peopleSpreadTime)
  return binarySearch(grid, 0, time);
}

function binarySearch(grid: number[][], left: number, right: number) {
  if (left > right) {
    // console.log('left right', left, right)
    return right;
  }
  const mid = Math.floor((left + right) / 2);
  if (canGetOut(grid, mid)) {
    return binarySearch(grid, mid + 1, right);
  } else {
    return binarySearch(grid, left, mid - 1);
  }
}

function getSpreadTime(g: number[][], flag: number) {
  const n = g.length;
  const m = g[0].length;
  const grid = JSON.parse(JSON.stringify(g));
  const spreadTimeArr = new Array(n).fill(0).map(() => new Array(m).fill(1e9));
  let time = 1;
  // console.log(flag, 1, grid)
  const qqueue = initQqueue(grid, flag);
  while (spread(grid, spreadTimeArr, time, flag, qqueue)) {
    // console.log(flag, 2, grid)
    time++;
  }
  // console.log(flag, 3, grid)
  return spreadTimeArr[n - 1][m - 1];
}

function canGetOut(g: number[][], time: number = 0) {
  const n = g.length;
  const m = g[0].length;
  const grid = JSON.parse(JSON.stringify(g));
  const fireSpreadTimeArr = new Array(grid.length)
    .fill(0)
    .map(() => new Array(grid[0].length).fill(1e9));
  const peopleSpreadTimeArr = new Array(grid.length)
    .fill(0)
    .map(() => new Array(grid[0].length).fill(1e9));
  const fireQqueue = initQqueue(grid, 1);
  const peopleQqueue = initQqueue(grid, 3);
  for (let i = 1; i <= time; i++) {
    spread(grid, fireSpreadTimeArr, i, 1, fireQqueue);
  }
  let curTime = time + 1;
  while (grid[n - 1][m - 1] === 0) {
    spread(grid, fireSpreadTimeArr, curTime, 1, fireQqueue);
    spread(grid, peopleSpreadTimeArr, curTime, 3, peopleQqueue);
    curTime++;
  }
  return grid[grid.length - 1][grid[0].length - 1] === 3;
}

function initQqueue(grid: number[][], flag: number) {
  const curQueue = [];
  for (let i = 0; i < grid.length; i++) {
    for (let j = 0; j < grid[i].length; j++) {
      if (grid[i][j] === flag) {
        curQueue.push([i, j]);
      }
    }
  }
  return [curQueue];
}

function spread(
  grid: number[][],
  timeArr: number[][],
  curTime: number,
  flag: number,
  qqueue: number[][][]
) {
  if (qqueue.length <= 0) {
    return false;
  }
  const queue = qqueue.shift();
  const curQueue = [];
  let spreaded = false;
  while (queue.length > 0) {
    const [i, j] = queue.shift();
    if (i - 1 >= 0) {
      core(i - 1, j, flag);
    }
    if (i + 1 < grid.length) {
      core(i + 1, j, flag);
    }
    if (j - 1 >= 0) {
      core(i, j - 1, flag);
    }
    if (j + 1 < grid[i].length) {
      core(i, j + 1, flag);
    }
    if (grid[grid.length - 1][grid[i].length - 1] === flag) {
      spreaded = false;
      break;
    }
  }
  if (queue.length <= 0) {
    qqueue.push(curQueue);
  }

  return spreaded;

  function core(i: number, j: number, flag: number) {
    if (
      (flag === 1 && ![1, 2].includes(grid[i][j])) ||
      (flag === 3 &&
        (grid[i][j] === 0 ||
          (i === grid.length - 1 && j === grid[0].length - 1)))
    ) {
      grid[i][j] = flag;
      spreaded = true;
      timeArr[i][j] = curTime;
      curQueue.push([i, j]);
    }
  }
}
```

# 2023-11-08

[2609. 最长平衡子字符串](https://leetcode.cn/problems/find-the-longest-balanced-substring-of-a-binary-string/submissions/?envType=daily-question&envId=2023-11-08)

比较简单

```typescript
function findTheLongestBalancedSubstring(s: string): number {
  let max = 0;
  let stack = [];
  for (let i = 0; i < s.length; ) {
    while (i < s.length && s[i] === "1") {
      i++;
    }
    while (i < s.length && s[i] === "0") {
      stack.push(0);
      i++;
    }
    let x = 0;
    while (i < s.length && s[i] === "1" && stack.length > 0) {
      stack.pop();
      x++;
      i++;
    }
    stack.length = 0;
    max = Math.max(x, max);
  }
  return max * 2;
}
```

# 2023-11-07

[2586. 统计范围内的元音字符串数](https://leetcode.cn/problems/count-the-number-of-vowel-strings-in-range/description/?envType=daily-question&envId=2023-11-07)

简单题

```typescript
function vowelStrings(words: string[], left: number, right: number): number {
  const arr = ["a", "e", "i", "o", "u"];
  let count = 0;
  for (let i = left; i <= right; i++) {
    if (
      arr.includes(words[i][0]) &&
      arr.includes(words[i][words[i].length - 1])
    ) {
      count++;
    }
  }
  return count;
}
```

# 2023-11-06

[318. 最大单词长度乘积](https://leetcode.cn/problems/maximum-product-of-word-lengths/)

主要优化点在比较两个字符串，如何在 O(1)时间内完成比较呢？

如果是字符乱序直接比较，那就是 O(n^2)

如果用个 hash 表存下一个字符，那就是 O(n)

用位运算。那就是 O(1)。位运算不仅仅是相当于把字符码好了位置，而且是批量对比（按位与，与一个位和与 N 个位是一个速度），而不是挨个比较。

```typescript
function maxProduct(words: string[]): number {
  let char = new Array(words.length).fill(0);
  for (let i = 0; i < words.length; i++) {
    for (let j = 0; j < words[i].length; j++) {
      char[i] |= 1 << (words[i].charCodeAt(j) - "a".charCodeAt(0));
    }
  }
  let res = 0;
  for (let i = 0; i < words.length; i++) {
    for (let j = 0; j < words.length; j++) {
      if ((char[i] & char[j]) == 0) {
        res = Math.max(words[i].length * words[j].length, res);
      }
    }
  }
  return res;
}
```

# 2023-10-26

[2520. 统计能整除数字的位数](https://leetcode.cn/problems/count-the-digits-that-divide-a-number/description/)

简单题

```typescript
function countDigits(num: number): number {
  let count = 0;
  let n = num;
  while (n !== 0) {
    const a = n % 10;
    if (num % a === 0) {
      count++;
    }
    n = Math.floor(n / 10);
  }
  return count;
}
```

# 2023-10-24

[1155. 掷骰子等于目标和的方法数](https://leetcode.cn/problems/number-of-dice-rolls-with-target-sum/)

这道题一开始没有思路，但简单看了一下答案，发现确实不难，动态规划拿下：

```typescript
function numRollsToTarget(n: number, k: number, target: number): number {
  const MOD = 10 ** 9 + 7;
  const dp = new Array(n + 1).fill(0).map((x) => new Array(target + 1).fill(0));
  dp[0][0] = 1; // 边界条件是dp[1][j]=1, 1<=j<=k，这里可以更进一步简单归纳为dp[0][0]=1
  for (let i = 1; i <= n; i++) {
    for (let j = 1; j <= target; j++) {
      for (let x = 1; x <= k; x++) {
        if (j - x >= 0) {
          dp[i][j] = (dp[i][j] + dp[i - 1][j - x]) % MOD; // 每一步都要取模，否则会溢出
        }
      }
    }
  }
  return dp[n][target];
}
```

# 2023-10-08

[2034. 股票价格波动](https://leetcode.cn/problems/stock-price-fluctuation/description/)

这道题一开始是打算用遍历的方式求 max 和 min，可惜会超时，看了答案知道了要用堆来做。堆更新的时间复杂度是 O(logN)

```typescript
class PriorityQueue1<T> {
  arr: T[];
  compare: (a: T, b: T) => number;
  constructor(props: { compare: (a: T, b: T) => number }) {
    const { compare } = props;
    this.compare = compare;
    this.arr = [];
  }
  swap(arr, index1, index2) {
    const temp = arr[index1];
    arr[index1] = arr[index2];
    arr[index2] = temp;
  }
  enqueue(a) {
    this.arr.push(a);
    this.bubbleUp(this.arr.length - 1);
  }
  dequeue() {
    this.delete(0);
  }
  bubbleUp(index) {
    if (this.arr.length <= 1 || index <= 0) {
      return;
    }
    const pre = Math.floor((index - 1) / 2);
    if (this.compare(this.arr[index], this.arr[pre]) > 0) {
      this.swap(this.arr, pre, index);
      this.bubbleUp(pre);
    }
  }
  delete(index) {
    this.swap(this.arr, index, this.arr.length - 1);
    this.arr.pop();
    this.sinkDown(index);
  }
  sinkDown(index) {
    if (this.arr.length <= 1 || index >= this.arr.length - 1) {
      return;
    }
    if (
      (index * 2 + 1 < this.arr.length &&
        this.compare(this.arr[index], this.arr[index * 2 + 1]) < 0) ||
      (index * 2 + 2 < this.arr.length &&
        this.compare(this.arr[index], this.arr[index * 2 + 2]) < 0)
    ) {
      if (
        index * 2 + 2 >= this.arr.length ||
        this.compare(this.arr[index * 2 + 1], this.arr[index * 2 + 2]) > 0
      ) {
        this.swap(this.arr, index, index * 2 + 1);
        this.sinkDown(index * 2 + 1);
      } else {
        this.swap(this.arr, index, index * 2 + 2);
        this.sinkDown(index * 2 + 2);
      }
    }
  }
  front() {
    return this.arr[0];
  }
  size() {
    return this.arr.length;
  }
}

interface Data {
  index: number;
  value: number;
}

class StockPrice {
  priceArr: number[];
  maxPriorityQueue: PriorityQueue1<{ index: number; value: number }>;
  minPriorityQueue: PriorityQueue1<{ index: number; value: number }>;
  constructor() {
    this.priceArr = [];
    this.maxPriorityQueue = new PriorityQueue1({
      compare: (a: Data, b: Data) => a.value - b.value,
    });
    this.minPriorityQueue = new PriorityQueue1({
      compare: (a: Data, b: Data) => b.value - a.value,
    });
  }

  update(timestamp: number, price: number): void {
    this.priceArr[timestamp] = price;
    this.maxPriorityQueue.enqueue({ index: timestamp, value: price });
    this.minPriorityQueue.enqueue({ index: timestamp, value: price });
  }

  current(): number {
    return this.priceArr[this.priceArr.length - 1];
  }

  maximum(): number {
    while (
      this.maxPriorityQueue.front().value !==
      this.priceArr[this.maxPriorityQueue.front().index]
    ) {
      this.maxPriorityQueue.dequeue();
    }
    return this.maxPriorityQueue.front().value;
  }

  minimum(): number {
    while (
      this.minPriorityQueue.front().value !==
      this.priceArr[this.minPriorityQueue.front().index]
    ) {
      this.minPriorityQueue.dequeue();
    }
    return this.minPriorityQueue.front().value;
  }
}

/**
 * Your StockPrice object will be instantiated and called as such:
 * var obj = new StockPrice()
 * obj.update(timestamp,price)
 * var param_2 = obj.current()
 * var param_3 = obj.maximum()
 * var param_4 = obj.minimum()
 */
```

# 2023-10-09

[2578. 最小和分割](https://leetcode.cn/problems/split-with-minimum-sum/description/?envType=daily-question&envId=2023-10-09)

这道题的思路是**把小的数放高位，把大的数放低位**。可以先排序，然后再把数对半分配，分配规则就是：把小的数放高位，把大的数放低位。

代码:

```typescript
function splitNum(num: number): number {
  let numStr = (num + "").split("").sort();
  let num1 = "";
  let num2 = "";
  for (let i = 0; i < numStr.length; i += 2) {
    num1 += numStr[i];
    if (i + 1 < numStr.length) {
      num2 += numStr[i + 1];
    }
  }
  console.log(num1, num2);
  return +num1 + +num2;
}
```

# 2023-05-09

最近朋友提醒我 leetcode 开了 javascript 专栏，有一道典型的深度判断对象相等的题目，我试了一下

[2628. 完全相等的 JSON 字符串](https://leetcode.cn/problems/json-deep-equal/description/)

代码：

```typescript
function areDeeplyEqual(o1: any, o2: any): boolean {
  if (
    (Array.isArray(o1) && Array.isArray(o2) && o1.length === o2.length) ||
    (Object.prototype.toString.call(o1) === "[object Object]" &&
      Object.prototype.toString.call(o2) === "[object Object]" &&
      Object.keys(o1).length === Object.keys(o2).length)
  ) {
    for (let k in o1) {
      if (!areDeeplyEqual(o1[k], o2[k])) {
        return false;
      }
    }
    return true;
  }
  return Object.is(o1, o2);
}
```

# 2023-04-10

[1019. 链表中的下一个更大节点](https://leetcode.cn/problems/next-greater-node-in-linked-list/description/)

几乎是简单题

```typescript
function nextLargerNodes(head: ListNode | null): number[] {
  let p = head;
  const arr = [];
  while (p != null) {
    let i = p.next;
    while (i != null) {
      if (i.val > p.val) {
        arr.push(i.val);
        break;
      } else {
        i = i.next;
      }
    }
    if (i == null) {
      arr.push(0);
    }
    p = p.next;
  }
  return arr;
}
```

# 2023-04-06

[1017. 负二进制转换](https://leetcode.cn/problems/convert-to-base-2/description/)

这题可以用通用的进制转换方法，先求余数，然后减去余数，然后除以除数，如此循环往复，得出的余数就是每一位上的值。

```typescript
function baseNeg2(n: number): string {
  if (n === 0) {
    return "0";
  }
  let res = [];
  while (n !== 0) {
    const remainder = n & 1;
    res.push(remainder);
    n -= remainder;
    n /= -2;
  }
  return res.reverse().join("");
}
```

# 2023-04-05

[2427. 公因子的数目](https://leetcode.cn/problems/number-of-common-factors/submissions/421361913/)

简单题，时间复杂度 O(n)

```typescript
function commonFactors(a: number, b: number): number {
  let res = 0;
  const min = Math.min(a, b);
  for (let i = 1; i <= min; i++) {
    if (a % i == 0 && b % i == 0) {
      res++;
    }
  }
  return res;
}
```

# 2023-04-03

[1053. 交换一次的先前排列](https://leetcode.cn/problems/previous-permutation-with-one-swap/submissions/420778464/)

今天这题很简单，我用的快排来找最大元素，速度居然击败了 100%

```typescript
function prevPermOpt1(arr: number[]): number[] {
  for (let i = arr.length - 1; i >= 0; i--) {
    let temp = [];
    for (let j = i + 1; j < arr.length; j++) {
      if (arr[j] < arr[i]) {
        temp.push({ index: j, num: arr[j] });
      }
    }
    if (temp.length) {
      temp.sort((a, b) => {
        return b.num - a.num;
      });
      const x = arr[temp[0].index];
      arr[temp[0].index] = arr[i];
      arr[i] = x;
      break;
    }
  }
  return arr;
}
```

# 2023-04-02

[831. 隐藏个人信息](https://leetcode.cn/problems/masking-personal-information/description/)

很简单的字符串处理

```typescript
function maskPII(s: string): string {
  if (s.includes("@")) {
    let [a, b] = s.toLocaleLowerCase().split("@");
    a = a[0] + "*****" + a[a.length - 1];
    return a + "@" + b;
  } else {
    let a = s.replace(/\D/g, "");
    let b = a.split("").reverse();
    let hasPlus = b.length > 10;
    let res = b.slice(0, 4);
    res.push("-");
    for (let i = 4; i < b.length; i++) {
      res.push("*");
      if (i % 3 == 0 && i !== b.length - 1) {
        res.push("-");
      }
    }
    if (hasPlus) {
      res.push("+");
    }
    return res.reverse().join("");
  }
}
```

# 2023-03-06

[1653. 使字符串平衡的最少删除次数](https://leetcode.cn/problems/minimum-deletions-to-make-string-balanced/description/)

随便在一个数组坐标处划一个分界线，左边的 b 的个数+右边的 a 的个数之和最小，即为要删除的最少数目。而这个 a 和 b 的个数，最好是用前后缀和记下来，不然每次都要遍历一遍数组搜集。那就是 O(n^2)的复杂度了。用前缀和记下来，则是 O(n)时间复杂度。

# 2023-01-13

[2287. 重排字符形成目标字符串](https://leetcode.cn/problems/rearrange-characters-to-make-target-string/description/)

这题很简单，不过题目描述和举例不是很清楚。就是我不知道，是不是要连续的字符串去配对。试了一下，结果并不需要连续。

```typescript
function rearrangeCharacters(s: string, target: string): number {
  const mapS = getMap(s);
  const mapTarget = getMap(target);
  const res = [];
  for (let k of Object.keys(mapTarget || {})) {
    if (!mapS[k]) {
      return 0;
    } else {
      res.push(Math.floor(mapS[k] / mapTarget[k]));
    }
  }
  return Math.min(...res);
}

function getMap(s: string): { [key: string]: number } {
  let map = {};
  for (let i = 0; i < s.length; i++) {
    if (!map[s[i]]) {
      map[s[i]] = 1;
    } else {
      map[s[i]]++;
    }
  }
  return map;
}
```

# 2023-01-09

[1806. 还原排列的最少操作步数](https://leetcode.cn/problems/minimum-number-of-operations-to-reinitialize-a-permutation/description/)

这题很简单，按照题目描述进行运算即可，没有任何技术可言。

```typescript
function reinitializePermutation(n: number): number {
  let count = 1;
  let arr = [];
  for (let i = 0; i < n; i++) {
    arr.push(i);
  }
  // console.log(arr)
  while (!action(arr)) {
    count++;
  }
  return count;
}

function action(arr: number[]): boolean {
  let res = true;
  const perm = [...arr];
  for (let i = 0; i < arr.length; i++) {
    if (i % 2 == 0) {
      arr[i] = perm[i / 2];
    } else {
      arr[i] = perm[arr.length / 2 + (i - 1) / 2];
    }
    if (arr[i] !== i) {
      res = false;
    }
  }
  // console.log(arr, res)
  return res;
}
```

# 2023-01-08

[1658. 将 x 减到 0 的最小操作数](https://leetcode.cn/problems/minimum-operations-to-reduce-x-to-zero/description/)

这是昨天的每日一题，用了前缀和+滑动窗口（双指针）

```typescript
function minOperations(nums: number[], x: number): number {
  // 算出前缀和和后缀和，然后用滑动窗口去扫，看前缀+后缀是否等于x
  let lsum = [0];
  for (let i = 0; i < nums.length; i++) {
    lsum.push(nums[i] + lsum[i]);
  }
  let rsum = [0];
  for (let i = 0; i < nums.length; i++) {
    rsum.push(nums[nums.length - 1 - i] + rsum[i]);
  }
  let min = nums.length;
  let hasAnswer = false;
  // 这里先扫左边，左边扫到头，开始一边倒退，一边扫右边
  let state = 0;
  let left = 0;
  let right = 0;
  while (left >= 0 && right >= 0 && left + right <= nums.length) {
    if (lsum[left] + rsum[right] == x) {
      hasAnswer = true;
      // console.log(lsum, rsum, left, right, min)
      min = Math.min(min, left + right);
      left--;
      right++;
      state = 1;
    } else if (lsum[left] + rsum[right] < x) {
      if (state == 0) {
        left++;
      } else {
        right++;
      }
    } else {
      left--;
      state = 1;
    }
  }
  console.log(left, right, state, min);
  return hasAnswer ? min : -1;
}
```

# 2021-06-06

## [474. 一和零](https://leetcode-cn.com/problems/ones-and-zeroes/)

一道动态规划题目。

首先要明白这是一道背包问题，而且是双维度的，可以装 0 和 1。

那么我们就需要一个三维数组 dp 来记录动态规划的子过程的结果，第一个维度代表遍历到第 i 个字符串，第二个维度代表第 j 个 0 的问题规模，第三个维度代表第 k 个 1 的问题规模，依次扩展到我们的目标字符串个数，目标问题规模。

状态转移方程：

1. 如果加入当前字符串，导致背包溢出，则不加：dp[i][j][k] = dp[i-1][j][k]
2. 如果不溢出，则有两种可能，取最优解：dp[i][j][k] = Math.max(dp[i-1][j][k], dp[i-1][j-zeros][k-ones]+1)

这里还需要考虑一些边界问题，比如 i=0 的时候，dp[0][any][any]应该是 0，同理 m=0 和 n=0 也是如此。所以我们的数组空间需要每个维度上都加 1 来存放这些初始值。

JavaScript 代码：

```javascript
/**
 * @param {string[]} strs
 * @param {number} m
 * @param {number} n
 * @return {number}
 */
var findMaxForm = function (strs, m, n) {
  let dp = new Array(strs.length + 1)
    .fill(0)
    .map(() => new Array(m + 1).fill(0).map(() => new Array(n + 1).fill(0)));
  for (let i = 1; i <= strs.length; i++) {
    let [zeros, ones] = getZeros(strs[i - 1]);
    for (let j = 0; j <= m; j++) {
      for (let k = 0; k <= n; k++) {
        dp[i][j][k] = dp[i - 1][j][k];
        if (j >= zeros && k >= ones) {
          dp[i][j][k] = Math.max(
            dp[i - 1][j][k],
            dp[i - 1][j - zeros][k - ones] + 1
          );
        }
      }
    }
  }
  return dp[strs.length][m][n];
};

function getZeros(str) {
  let zeros = [0, 0];
  for (let i = 0; i < str.length; i++) {
    zeros[str[i] - "0"]++;
  }
  return zeros;
}
```

# 2021-06-05

## [203. 移除链表元素](https://leetcode-cn.com/problems/remove-linked-list-elements/)

很简单的一道删除单链表节点题

JavaScript 代码：

```javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val, next) {
 *     this.val = (val===undefined ? 0 : val)
 *     this.next = (next===undefined ? null : next)
 * }
 */
/**
 * @param {ListNode} head
 * @param {number} val
 * @return {ListNode}
 */
var removeElements = function (head, val) {
  let h = new ListNode(0, head);
  index = h;
  while (index.next) {
    if (index.next.val == val) {
      let next = index.next.next;
      index.next = next;
      continue;
    }
    index = index.next;
  }
  return h.next;
};
```

# 2021-06-04

## [160. 相交链表](https://leetcode-cn.com/problems/intersection-of-two-linked-lists/)

这题有两种解法：

1. 哈希表记录指针
2. 双指针

### 哈希表记录指针

JavaScript 代码：

```javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */

/**
 * @param {ListNode} headA
 * @param {ListNode} headB
 * @return {ListNode}
 */
var getIntersectionNode = function (headA, headB) {
  let hashset = new Set([]);
  let index = headA;
  while (index) {
    hashset.add(index);
    index = index.next;
  }
  index = headB;
  while (index) {
    if (hashset.has(index)) {
      return index;
    } else {
      index = index.next;
    }
  }
  return null;
};
```

### 双指针

链表总共分为三部分：

1. headA 到公共节点
2. headB 到公共节点
3. 公共部分

所以如果我们利用双指针，把这三个部分走一遍，就能让双指针碰上。

1. index1 走 A 链，走完 A 链，走 B 链
2. index2 走 B 链，走完 B 链，走 A 链

> 两个指针同时等于 null 只有一种情况，就是两个链不相交。如果相交，想要都在链尾碰上，则两个链长度相等，若两个链长度相等且相交，则非公共部分长度一定相等，那么他们早就在第一次遍历的时候在公共节点遇上了。

```JavaScript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */

/**
 * @param {ListNode} headA
 * @param {ListNode} headB
 * @return {ListNode}
 */
var getIntersectionNode = function(headA, headB) {
    let index1 = headA;
    let index2 = headB;
    while(index1!==index2){
        index1 = index1==null?headB:index1.next;
        index2 = index2==null?headA:index2.next;
    }
    return index1;
};
```

# 2021-06-03

> 凡是涉及到连续子数组的，都可以用前缀和+哈希表来解

## [525. 连续数组](https://leetcode-cn.com/problems/contiguous-array/)

这题要注意的就是，因为要统计元素个数，所以要使用 i+1。

哈希表的 key 的含义是：当前遍历到的 1 与符合标准（一半是 1）之间的差距，而记录的位置则必须是最小位置。所以只在初始化的时候赋值。

JavaScript 代码：

```javascript
/**
 * @param {number[]} nums
 * @return {number}
 */
var findMaxLength = function (nums) {
  let sum = 0;
  let hashmap = {};
  let max = 0;
  for (let i = 0; i < nums.length; i++) {
    sum += nums[i];
    if (i + 1 == sum * 2) {
      max = i + 1;
      continue;
    }
    if (hashmap.hasOwnProperty(i + 1 - sum * 2)) {
      if (max < i - hashmap[i + 1 - sum * 2]) {
        max = i - hashmap[i + 1 - sum * 2];
      }
    } else {
      hashmap[i + 1 - sum * 2] = i;
    }
  }
  return max;
};
```

# 2021-05-31

> 这个问题看起来是个简单题，其实可以从中学到位运算和一些数学知识。

## [342. 4 的幂](https://leetcode-cn.com/problems/power-of-four/)

我自己的解法很简单易懂，但是不够高效：

JavaScript 代码：

```javascript
/**
 * @param {number} n
 * @return {boolean}
 */
var isPowerOfFour = function (n) {
  let i = 1;
  while (i < n) {
    i = i * 4;
  }
  if (i == n) {
    return true;
  }
  return false;
};
```

这个解法的效率很差，只战胜了 55%的选手。说明肯定有更优解，我翻了一下答案。主要是 2 种角度的解法：

1. 位运算
2. 数学

### 位运算

如果是 2 的幂，那么位中只能出现一个 1。如果是 4 的，那么肯定也只有一个 1，且出现的位置是每隔一位出现。那么问题来了，怎么判断位上只有一个 1 呢？操作是：减去 1，然后与。得到的结果必然应该是 0。那如何判断 1 在哪一位上呢？好像只能遍历了。但其实我们不需要知道具体是哪一位，只需要知道是否分布在正确的位上，可以通过 mask 解决：`mask=$(01010101010101010101010101010101)_2$`，因为 1 分布在奇数位。也可以写成更简短的 16 进制形式：`mask=$(55555555)_16$`

JavaScript 代码：

```javascript
/**
 * @param {number} n
 * @return {boolean}
 */
var isPowerOfFour = function (n) {
  return n > 0 && (n & (n - 1)) == 0 && n & 0x55555555;
};
```

奇怪的是这个代码的运行时间居然比上面那个还长，感觉不科学。

### 数学角度

首先依然是按照上面的两个条件：

1. n>0
2. n 只有一个 0

我们观察到所有偶数分为：$4^x \times 2 \times 2$也就是$4^x$，和$4^x \times 2 \times 1$。而 4 的幂次除以 3 的余数必然是 1，而$4^x \times 2$这种除以 3 的余数必然是 2。

我们增加这个条件筛选出$4^x$

JavaScript 代码：

```javascript
/**
 * @param {number} n
 * @return {boolean}
 */
var isPowerOfFour = function (n) {
  return n > 0 && (n & (n - 1)) == 0 && n % 3 == 1;
};
```

# 2021-05-29

> 这个问题需要拆分出子问题才好解决，要不然没有思路。它的子问题是：[560. 和为 K 的子数组](https://leetcode-cn.com/problems/subarray-sum-equals-k/)

## [1074. 元素和为目标值的子矩阵数量](https://leetcode-cn.com/problems/number-of-submatrices-that-sum-to-target/)

当你理解了子问题之后，我们来想想，怎么把这个问题转换到子问题上呢？也就是如何把二维问题变一维问题呢？

我们想象把一个矩阵的列上的元素全部加起来，不就是一个一维数组了吗。这个一维数组可以等效的应用在这个问题上。

那这样的组合有哪些呢？通过简单的二次遍历，就能得出我们想要的组合：

JavaScript 代码：

```javascript
for (let i = 0; i < n; i++) {
  for (let j = i; j < n; j++) {}
}
```

每次 i 到 j 之间的数就是我们想要的组合，拿这些数的和，组成新的一维数组，然后用一维数组的解法去解。这里有个小技巧是这个和也要避免重复计算，所以要把每次计算所得存下来，下次在这个基础上算，这样可以省下从头开始求和的时间。

JavaScript 代码：

```javascript
/**
 * @param {number[][]} matrix
 * @param {number} target
 * @return {number}
 */
var numSubmatrixSumTarget = function (matrix, target) {
  let count = 0;
  for (let i = 0; i < matrix.length; i++) {
    let sum = new Array(matrix[0].length).fill(0);
    for (let j = i; j < matrix.length; j++) {
      for (let k = 0; k < matrix[0].length; k++) {
        sum[k] += matrix[j][k];
      }
      count += subarraySum(sum, target);
    }
  }
  return count;
};

var subarraySum = function (nums, k) {
  let pre = 0;
  let preRecord = { 0: 1 };
  let count = 0;
  for (let i = 0; i < nums.length; i++) {
    pre += nums[i];
    if (preRecord[pre - k]) {
      count += preRecord[pre - k];
    }
    if (preRecord[pre]) {
      preRecord[pre]++;
    } else {
      preRecord[pre] = 1;
    }
  }
  return count;
};
```

> 简化问题的办法有很多，比如降低问题规模，降低维度，二维 -> 一维。

# 2021-05-29

> 这题是在做每日一题中遇到的问题的子问题：[1074. 元素和为目标值的子矩阵数量](https://leetcode-cn.com/problems/number-of-submatrices-that-sum-to-target/)

## [560. 和为 K 的子数组](https://leetcode-cn.com/problems/subarray-sum-equals-k/)

遇到这类问题，首先想的是复杂度，然后复杂度天然是跟问题规模有关的。遍历一遍肯定是必要的，当我们遍历到第 n 这个位置，我们怎么判断从 0 到 n 中有多少个解，进一步的，我们还只要增量数据，n-1 的解不应该去重复计算。第 n 这个位置上的数是一定要考虑进去的，所以我们从后往前寻找。具体代码如下：

JavaScript 代码：

```javascript
/**
 * @param {number[]} nums
 * @return {number}
 */
var subarraySum = function (nums, k) {
  let count = 0;
  for (let start = 0; start < nums.length; ++start) {
    let sum = 0;
    for (let end = start; end >= 0; --end) {
      sum += nums[end];
      if (sum == k) {
        count++;
      }
    }
  }
  return count;
};
```

这样的话，算法的时间复杂度是 O(n^2)。有没有重复计算的问题呢，似乎不太好说，但结果是：有，像此类问题有统一的规律，就是我们可以记录前缀和。如果我们知道前缀和，那么我们只需要用当前和减去 k，看是否等于某个前缀和，如果有，我们不就正好找到一个子数组的和等于 k 了吗？所以基于前缀和，我们一次遍历即可解决问题。

JavaScript 代码：

```javascript
/**
 * @param {number[]} nums
 * @param {number} k
 * @return {number}
 */
var subarraySum = function (nums, k) {
  let pre = 0;
  let preRecord = { 0: 1 };
  let count = 0;
  for (let i = 0; i < nums.length; i++) {
    pre += nums[i];
    if (preRecord[pre - k]) {
      count += preRecord[pre - k];
    }
    if (preRecord[pre]) {
      preRecord[pre]++;
    } else {
      preRecord[pre] = 1;
    }
  }
  return count;
};
```

> 前缀和对过往的遍历总结提取了信息，使我们不用再去进行重复的计算，是非常重要的技巧。

# 2021-05-28

[477. 汉明距离总和](https://leetcode-cn.com/problems/total-hamming-distance/)

这题初看上去特别简单，就是一个 O(n^2)的遍历（组合），对每一组求汉明距离累加起来。不过我一开始就觉得可能会超时，提交后果然超时了。更优的做法是按位遍历，每一位上所有的数要么是 0 要么是 1，把 0 和 1 的个数统计出来，相乘，就是这一位的汉明距离总和。

JavaScript 代码：

```javascript
/**
 * @param {number[]} nums
 * @return {number}
 */
var totalHammingDistance = function (nums) {
  let max = Math.max(...nums);
  let count = 0;
  while (max > 0) {
    count++;
    max >>= 1;
  }
  let res = 0;
  for (let i = 0; i < count; i++) {
    let zero = 0;
    let one = 0;
    for (let j = 0; j < nums.length; j++) {
      let temp = nums[j] >> i;
      if (temp % 2) {
        one++;
      } else {
        zero++;
      }
    }
    res += zero * one;
  }
  return res;
};
```

# 2021-05-27

[1190. 反转每对括号间的子串](https://leetcode-cn.com/problems/reverse-substrings-between-each-pair-of-parentheses/)

这道题一看就知道用栈来解决，但具体到怎么做却依旧不容易想通。直到看过答案后，才发现，实际上真的只需要遍历一遍就能解决问题。

思路如下：

每遇到一个括号块，就需要把里面的字符串翻转（这是单步操作），然后递归翻转每一层。这是我们人的思维，但机器是看不到这种宏观信息的，我们需要安排具体到每一步的任务。代码在遍历的时候只会遇到左括号或者右括号，假如我们遇到左括号的时候开始记录字符串，那么在遇到右括号的时候，就有翻转的目标对象了。但如果连续遇到两个左括号呢？我们将记录的信息先入栈，然后继续上面的步骤即可。

具体步骤（单步）：

1. 遇到左括号：入栈已记录的字符串，清空我们用于记录的变量
2. 遇到普通字符：记录
3. 遇到右括号：翻转记录的字符串，将栈顶字符串 pop 出来拼接上翻转好的字符串

JavaScript 代码：

```javascript
/**
 * @param {string} s
 * @return {string}
 */
var reverseParentheses = function (s) {
  let stack = [];
  let str = "";
  for (let i = 0; i < s.length; i++) {
    if (s[i] == "(") {
      stack.push(str);
      str = "";
    } else if (s[i] == ")") {
      str = stack.pop() + Array.from(str).reverse().join("");
    } else {
      str += s[i];
    }
  }
  return str;
};
```
