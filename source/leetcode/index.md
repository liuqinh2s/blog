---
title: leetcode
date: 2023-01-08
---

这里是我的 leetcode 做题笔记，以前是用写一篇文章的方式发布 leetcode 做题笔记的，现在觉得，或许开个专栏更好，因为有每日一题的打算，就不用水那么多篇文章了。自从我开始以时间为分类的方式用专栏来记录自己的每日活动，我发现自己表达的欲望也变强了，记录和回过头来检索这些信息的效率也都提高了，真是不错的方法。

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
