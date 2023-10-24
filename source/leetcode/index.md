---
title: leetcode
date: 2023-01-08
---

这里是我的 leetcode 做题笔记，以前是用写一篇文章的方式发布 leetcode 做题笔记的，现在觉得，或许开个专栏更好，因为有每日一题的打算，就不用水那么多篇文章了。自从我开始以时间为分类的方式用专栏来记录自己的每日活动，我发现自己表达的欲望也变强了，记录和回过头来检索这些信息的效率也都提高了，真是不错的方法。

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
