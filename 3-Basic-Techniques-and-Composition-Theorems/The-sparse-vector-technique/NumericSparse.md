# 3.6.3 数值稀疏算法

最后，我们给出了 **Sparse** 算法的一个版本，它实际上输出了高于阈值查询的数值，我们只需要在精度上损失一个常数因子就可以做到这一点。我们称这种算法为 **NumericSparse**，它是一种简单的使用 **Laplace** 机制组成的 **Sparse** 算法。它不是输出向量 $a \in \{\top,\bot\}^*$ ，而是输出向量 $a \in (\mathbb{R} \cup \{\bot\})^*$。

我们发现 **NumericSparse** 算法是具有隐私性的：

**定理 3.27** **NumericSparse** 算法是$(\varepsilon,\delta)$- 差分隐私的。

**【证明】** 我们发现，如果$\delta=0$，则**NumericSparse**算法 $(D,\{f_i\},T,c,\varepsilon,0)$ 就是 **Sparse** 算法 $(D,\{f_i\},T,c,\frac{8}{9}\varepsilon,0)$ 的自适应组合，其中输出具体数值使用了具有隐私参数 $(\varepsilon',\delta)=(\frac{1}{9}\varepsilon,0)$ 的  **Lapalace** 机制。如果 $\delta>0$，则 **NumericSparse** 算法 $(D,\{f_i\},T,c,\varepsilon,\delta)$ 是 **Sparse** 算法 $(D,\{f_i\},T,c,\frac{\sqrt{512}}{\sqrt{512}+1}\varepsilon,\delta/2)$ 的自适应组合， 其中输出具体数值使用了具有隐私参数 $(\varepsilon',\delta)=(\frac{1}{\sqrt{512}}\varepsilon,\delta/2)$ 的  **Lapalace** 机制。
因此，**NumericSparse** 算法的隐私来自简单的组合。

要讨论准确性，我们必须定义一种机制的准确性，这是指响应一系列数值查询而输出流 $a \in (\mathbb{R} \cup \{\bot\})^*$ 的含义：

![NumericSparse](/3-Basic-Techniques-and-Composition-Theorems/The-sparse-vector-technique/img/NumericSparse.png)

**定义3.10（数值精度）** 一个响应 $k$ 个查询流 $f_1,...,f_k$ 并输出应答流 $a_1,...,\in(\mathbb{R} \cup \{\bot\})^*$ 的算法，如果除概率最大为 $\beta$ 之外，算法不会在 $f_k$ 之前停止，并且对于所有 $a_i \in \mathbb{R}$ 有：

$$
|f_i(D)-a_i|\leq \alpha
$$

对于所有 $a_i =\bot$，有：

$$
f_i(D) \leq T + \alpha
$$

则这个算法是相对于阈值 $T$ 的 $(\alpha,\beta)$ 准确。

**定理3.28**。 对于 $k$ 个查询的任何序列 $f_1,...f_k$ 使得 $L(T)\equiv|\{i:f_i(D)\geq T-\alpha\}|\leq c$ ，如果 $\delta>0$，当：

$$
\alpha = \frac{(\ln k+\ln \frac{4c}{\beta})\sqrt{c\ln \frac{2}{\delta}}(\sqrt{512}+1)}{\varepsilon}
$$

**NumericSparse** 算法是相对于阈值 $T$ 的 $(\alpha,\beta)$ 准确的。

如果 $\delta=0$，当：

$$
\alpha = \frac{9c(\ln k + \ln(4c/\beta))}{\varepsilon}
$$

**NumericSparse** 算法是相对于阈值 $T$ 的 $(\alpha,\beta)$ 准确的。

**【证明】** 精度需要两个条件：首先，对于所有 $a_i =\bot:f_i(D)\leq T$： **Sparse** 准确定理以 $1-\beta/2$ 概率成立。另外，对于所有 $a_i\in \mathbb{R}$ ，它要求 $|f_i(D)-a_i|\leq \alpha$ 。 这通过 **Laplace** 机制的精度以 $1-\beta/2$ 概率成立。

我们到底显示了什么？如果给我们一系列查询，并保证只有最多 $c$ 个答案的答案高于 $T+\alpha$，我们就可以回答高于给定阈值 $T$ 的那些查询，直至误差 $\alpha$。如果我们事先知道进行这些高于阈值查询的身份，并使用拉普拉斯机制进行回答，那么在给定相同的隐私保证的情况下，此精度等于（等于常数和$\log k$）。也就是说，稀疏向量技术允许我们几乎“免费”地辨别这些大型查询的身份，只为这些不相关的查询进行对数精度的响应。这种算法与另一种形式（通过指数机制找到造成隐私损失大的查询，然后通过拉普拉斯机制响应这些查询）提供相同的保证。然而，这个稀疏向量算法运行起来很简单，而且最关键的是，它允许我们自适应地选择查询。