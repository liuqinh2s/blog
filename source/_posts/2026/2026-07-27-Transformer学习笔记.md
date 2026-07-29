---
title: Transformer学习笔记
tags: [AI, 学习笔记]
categries: [学习笔记]
---

# 大模型自学笔记

大模型就两块内容：

1. 推理原理
2. 训练原理

## Transformer架构图

从论文：《 Attention is all you need 》开始学习。先看看整个 Transformer 架构图：

![Transformer架构图](https://arxiv.org/html/1706.03762v7/Figures/ModalNet-21.png)

<!-- more -->

图中，左边是编码器 Encoder，右边是解码器 Decoder。Transformer 架构的三大流派，本质就是：Encoder-only、Decoder-only、Encoder-Decoder：

- Encoder-only，只有编码器。模型代表：BERT。编码器用于理解、分类等任务。
- Decoder-only，只有解码器。模型代表：GPT、Qwen、Claude、Deepseek 等所有主流大模型。解码器用于预测下一个 token，简单说就是生成文本，跟你聊天。
- Encoder-Decoder，两者都有。模型代表：BART、T5。用于翻译

但是现在基本上都是 Decoder-only Transformer 的天下，因为 **Scaling Law**：参数量越大，数据越多，能力按照规律提升。

图中，无论是左边还是右边，都有 `N×`，意思是多个重复模块，也可以叫：block 。block 之间是串行工作的，前一个 block 的输出会给到后一个 block 作为输入。

> 需要注意的是单个 Block 不包含词嵌入、Positional Encoding、Linear、Softmax 等，只包含 $N \times$ 圈起来的部分

接下来我们来细数一下 Transformer 有哪些模块：

1. **Input Embedding和Output Embedding**，它们分别是 Encoder 和 Decoder 的编码模块，可以统称为 Token Embedding（词嵌入）。
2. **Positional Encoding**（位置编码，简称：PE）。因为 Attention 是不管词之间的顺序的，所以需要额外处理位置信息。
3. **Multi-Head Attention和Masked Multi-Head Attention**（多头注意力和掩码多头注意力）。多头注意力就是把单注意力在向量维度上进行分割（一般是平均分割），然后计算完注意力后，拼接矩阵（把维度又变回来）。
4. **Add & Norm**（Add 就是 Residual，残差连接；Norm 是 Layer Normalization，层归一化，简称：LayerNorm）。残差连接的目的是解决深层网络梯度归零，训练不到深层的问题。层归一化使向量均值变成0，方差变成1，目的是稳定每层输入分布，控制特征分布波动。
5. **Feed Forward**（前馈网络，简称：FFN）。FFN 的目的是引入非线性，存储大量长期知识。
6. **Linear**（Vocab Projection（词表投影））。与 Token Embedding 共享同一个词汇表矩阵。输出 logits（对数得分），再经过 Softmax 就得到最后每个 token 的概率了。
7. **Softmax**：一种归一化函数，可以把一组数变为相加等于1，也就是概率

> 需要注意的是，还有两个环节由于不属于 Transformer 结构没有列出来。
> 1. Tokenizer 生成词汇表
> 2. 解码策略（Decoding Strategy）

## 词汇表

词汇表就是存 token 字符串到 token id 的映射，比如 "cat" 查词汇表得到 token id 是 1245，然后再用 token id 去 $W_E$ 取 token 的特征向量。在训练模型时，$W_E$ 会持续不断的更新，也就是 cat 的特征向量表示会不断的更新，但 cat 的 token id 是不会变的。

## 解码策略

Transformer 只负责输出每个 token 的概率（一个 $V$ 维向量，$V$ 是词汇表大小，每个维度上的数值代表选择该位置的 token 的概率，它们全部加起来等于1），具体采用哪个 token 完全看解码策略。解码策略分很多种：贪心，概率，束搜索（Beam Search），Top-p，Top-k。贪心的意思就是每次直接取概率最大的token；概率的意思是根据每个token的概率来取，概率高的取到可能性更大。

## 词嵌入

Token Embedding 需要依赖一个 $W_E$ 矩阵（列=词汇数，行=$d_{model}$）。每个 token 用一个 $d_{model}$ 维向量表示。

程序上看，这个矩阵是一个数组， token id 就是数组 index，根据它就可以直接取到一条 token。

从数学角度看，Token Embedding 是一个矩阵乘法，输入序列可以看成一个 `one-hot` 矩阵（每一行是一个向量，每一行只有一个维度是1，其余维度是0，这样跟 Embedding 矩阵相乘后，就可以得到输入矩阵 $X$ 了）

文本 → Tokenizer → 字符串 → 查 Vocab → token_id → 用 id 索引 $\boldsymbol{W}_E$ → 得到向量

## 位置编码

由于抛弃了RNN的循环结构，而注意力只关注词之间的关联，而不考虑词之间的位置。所以需要专门做一下位置信息的处理。位置编码PE和RoPE就是用来干这个的。

### PE

先来介绍一下 PE，也就是 Positional Embedding

它要解决的问题是，如何把 token 在输入序列中的位置，编码进 $d_{model}$ 维度的向量中。它的设计思路是把 $d_{model}$ 维，分为两两一组，每组数值用以下公式得出：

$$
\begin{aligned}
PE(pos, 2i) &= \sin\left(\frac{pos}{10000^{2i/d}}\right) \\\\
PE(pos, 2i+1) &= \cos\left(\frac{pos}{10000^{2i/d}}\right)
\end{aligned}
$$

然后把得出的位置编码向量直接加到对应 token 向量上。

这个编码方式的特性有：

1. 两组不同位置，如果偏移 k 相同，那么它们之间的换算矩阵就相同。从而可以让模型学习到它们的相对距离是相同的：

$$
\begin{bmatrix}
\sin\big((pos + k)\omega\big) \\\\
\cos\big((pos + k)\omega\big)
\end{bmatrix}
=
\begin{bmatrix}
\cos(k\omega) & \sin(k\omega) \\\\
-\sin(k\omega) & \cos(k\omega)
\end{bmatrix}
\begin{bmatrix}
\sin(pos\omega) \\\\
\cos(pos\omega)
\end{bmatrix}
$$

2. 每组奇偶维度，就像一个二维平面的时钟，它们的周期是不一样的，低维周期短，便于注意力观察相邻较近的 token 之间的关系，高维周期长，便于注意力观察相隔较远的 token 之间的关系。
3. 标准正弦位置编码 **不存在有限周期**，不会出现有限位置 P 使得 $\boldsymbol{PE}(pos+P)=\boldsymbol{PE}(pos)$ 对所有 pos 成立。

### RoPE

RoPE 旋转矩阵

$$
R_{\theta}(pos,i)
=
\begin{bmatrix}
\cos(pos\cdot\omega_i) & -\sin(pos\cdot\omega_i) \\\\
\sin(pos\cdot\omega_i) & \cos(pos\cdot\omega_i)
\end{bmatrix}
$$
$$
\tilde{\boldsymbol{q}}_m = R_m \boldsymbol{q},\quad \tilde{\boldsymbol{k}}_n = R_n \boldsymbol{k}
$$
$$
\tilde{\boldsymbol{q}}_m^\top \tilde{\boldsymbol{k}}_n
= \boldsymbol{q}^\top R_m^\top R_n \boldsymbol{k}
= \boldsymbol{q}^\top R_{n-m}\boldsymbol{k}
$$

$$
R_m^\top R_n 
= R_{n-m}
$$

$$
R_{n-m}=
\begin{bmatrix}
R\big((n-m)\omega_0\big) & & & \\\\
& R\big((n-m)\omega_1\big) & & \\\\
& & \ddots & \\\\
& & & R\big((n-m)\omega_{\frac{d}{2}-1}\big)
\end{bmatrix},\quad
R(\theta)=
\begin{bmatrix}
\cos\theta & -\sin\theta \\\\
\sin\theta & \cos\theta
\end{bmatrix}
$$

$$
\omega_i = \frac{1}{10000^{2i/d}}
$$

> 需要注意的是，RoPE 不同于 PE，PE 只需要加一次，而 RoPE 在每一层 Block 的注意力计算都要计算

## 注意力

注意力矩阵就是一个 $N \times N$ 矩阵，标志着 N 个 token 之间的关系。那它是怎么计算出来的呢？

首先需要构造三个集合：Q、K、V。

- Q 代表 Query，查询集
- K 代表 Key，键值对中的键
- V 代表 Value，键值对中的值

每一个注意力计算模块都有自己独特的 $W_Q$、$W_K$、$W_V$ 三个权重矩阵（$d_{model} \times d_{model}$），用输入矩阵 $X$ （$N \times d_{model}$） 与它们相乘可以得到上述三个集合（矩阵），即：

$$
Q = XW_Q
$$

$$
K = XW_K
$$

$$
V = XW_V
$$

然后再用注意力公式，算出注意力矩阵：

$$
\text{Attention}(Q,K,V)=\text{softmax}\left(\frac{QK^\top}{\sqrt{d_k}}\right)V
$$

## 残差连接

首先区分两个概念：恒等式、恒等映射。

### 恒等式（Identity equation）

永远成立的等式（关系），属于 **等式、代数表达式**

> 一个等式，变量取定义域内任意值，等式永远成立。

例子：

$x+1=1+x$

$\sin^2x+\cos^2x=1$

重点：**是一条等式，描述两个表达式相等关系，没有 “输入→输出” 的变换。**

### 恒等映射（Identity mapping / Identity function）

属于 **函数 / 映射**

重点：是 **变换规则**：输入是什么，输出就原样返回什么；存在输入、输出。

- 标量场景：$f(x)=x$
- 矩阵场景：单位矩阵 $\boldsymbol{I}$，$\boldsymbol{I}\boldsymbol{x}=\boldsymbol{x}$

### 残差连接的目的

残差连接的目的是为了让恒等映射天然存在，不用学习就可以直接拿来使用，当一层梯度为0的时候，就是恒等映射，相当于跳过这一层网络。如果没有残差连接，随着网络层数变深，梯度相乘最后会趋近0。

Plain 网络（普通堆叠网络） vs ResNet 残差网络梯度直观对比

先统一模型形式：
- Plain：$y = \mathcal{F}(x)$
- ResNet：$y = \mathcal{F}(x)+x$

一、梯度数学推导（极简版）

假设我们连续堆叠 L 层变换。

1）Plain 网络每一层：$x_{l+1}=F_l(x_l)$

链式求导：
$$
\frac{\partial x_L}{\partial x_0}= \prod_{l=0}^{L-1} \frac{\partial F_l(x_l)}{\partial x_l}
$$

激活函数导数值域大多小于 1（sigmoid/tanh/ 早期 ReLU）。

几十层连续相乘 → 梯度指数衰减 → 梯度消失。

深层梯度几乎为 0，浅层权重得不到有效更新。

2）ResNet 残差块单层残差块：

$x_{l+1}=F_l(x_l)+x_l$

求导：
$$
\frac{\partial x_{l+1}}{\partial x_l}= \frac{\partial F_l}{\partial x_l} + I
$$

堆叠 L 个残差块后：

$$
\frac{\partial x_L}{\partial x_0}= \prod_{l=0}^{L-1}\left( \frac{\partial F_l}{\partial x_l}+I \right)
$$

关键区别：每一层导数至少包含单位矩阵 I 这一项。

即便 $\partial F_l/\partial x_l \approx 0$，单项导数≈I，连乘之后依旧不会趋近 0。

梯度拥有一条直达浅层的恒等通路。

## LayerNorm

全称：Layer Normalization，中文翻译：层归一化，简称：LN

计算公式：

$$
\text{LayerNorm}(x) = \gamma \cdot \frac{x-\mu}{\sqrt{\sigma^2+\epsilon}} + \beta
$$

> 公式含义：均值、方差归一化 + 可学习缩放 γ、偏移 β

### 层归一化的目的

1. **稳定每层输入分布，缓解内部协变量偏移（Internal Covariate Shift）**
网络不断前向传播时，参数持续更新，每层输入的数据分布一直在剧烈变化。
模型需要持续适应新分布，学习变慢、梯度容易爆炸 / 消失。
归一化把特征强制调整到均值≈0，方差≈1，让后续层不用持续适应变化的数据分布。
“防止输出越传越大” 只是现象之一；本质是控制特征分布波动，不只限制幅值变大，也防止幅值持续变小。
2. **加速训练、允许使用更大学习率**
分布稳定后梯度更加平滑，优化器收敛更快。
3. **缓解梯度消失 / 梯度爆炸**
激活输入不会持续偏移到激活函数饱和区域（比如 sigmoid 两端梯度接近 0）。
4. **降低参数初始化、学习率调参压力**

> 注意：现代 GPT 采用的是 Pre-LN，而非论文中提到的 Post-LN，二者有非常大的差别

## FFN

全称：Feed Forward Network，中文翻译：前馈网络

### SwiGLU

$\text{SwiGLU}(x,W,V,b,c) = (\boldsymbol{x}W + b) \odot \text{Swish}(\boldsymbol{x}V + c)$

$\odot$：逐元素哈达玛积（element-wise multiply）

$\text{Swish}(z) = z\cdot\sigma(z),\quad \sigma=\text{sigmoid}$

省略偏置的写法：

$\text{SwiGLU}(\boldsymbol{x}) = (W_1\boldsymbol{x}) \odot \big((W_2\boldsymbol{x})\cdot\sigma(W_2\boldsymbol{x})\big)$

伪代码：

```python
def swiglu(x, W1, W2, W3):
    a = x @ W1
    b = x @ W2
    h = a * (b * torch.sigmoid(b))  # b*sigmoid(b) = swish(b)
    out = h @ W3
    return out
```

#### sigmoid

$\sigma(z) = \frac{1}{1 + e^{-z}}$

关键性质

值域：$\sigma(z) \in (0,1)$
中心：$\sigma(0) = \dfrac{1}{2}$
导数（常用）：

$\sigma'(z) = \sigma(z)\cdot\big(1-\sigma(z)\big)$

## linear



## 概念汇总：

1. 论文：《Attention is all you need》
2. Transformer
3. RNN、CNN、DN
4. 注意力公式：$\text{Attention}(Q,K,V)=\text{softmax}\left(\frac{QK^\top}{\sqrt{d_k}}\right)V$
5. QKV，`softmax()`，$d_k$，归一化，方差（Var()），标准差，平均绝对误差 MAE，期望，独立，同分布
6. 矩阵，向量，向量点积，矩阵乘法，矩阵转置，轴对称，中心对称，镜像
7. Token ID，词嵌入矩阵X（Embedding），词汇表，$W_Q$，$W_K$，$W_V$
8. 编码器，解码器，Input Embedding，Output Embedding，Positional Encoding（位置编码，PE），Multi-Head Attetion多头注意力，Masked Multi-Head Attention带掩码多头注意力，Feed Forward Network（前馈网络，FFN），Add & Norm（Add是残差连接(Residual)，Norm是Layer Normalization 层归一化），block堆叠N层，超参数（Hyperparameter），模型参数
9. FP32、FP16、BF16
10. 解码器输出的是词汇表上每个词的概率。之后还要用采样算法得到真实输出的词汇，采样算法有很多种：贪心（取概率最大的）、随机（按输出概率随机取）
11. 正弦、余弦、两角和公式