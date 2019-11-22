# 3.5.1 组成：一些组成技术

在本节的剩余部分，我们将证明一个更复杂的组成定理。为此，我们需要一些定义和引理，用分布之间的距离度量重新表述差异隐私。在下面的分数量中，如果分母为零，那么我们将分数的值定义为无穷大（分子总是正的）。

**定义3.5（KL散度）** KL-散度（Kullback-Leibler divergence），又称为 **相对熵**。两个随机变量 $Y$ 和 $Z$（取同一域的值）之间的 KL-散度定义为：

$$
\begin{aligned}
    D(Y||Z) = \mathbb{E}_{y \backsim Y}\Big[\ln\frac{Pr[Y=y]}{Pr[Z=y]}\Big] &= \sum_{y \backsim Y}Pr(y)\ln\frac{Pr[Y=y]}{Pr[Z=y]}\\
    &=\int_{-\infty}^{\infty}p_Y(y)\ln\frac{p_Y(y)}{p_Z(y)}dy
\end{aligned}
$$

(*注：增加离散和连续的两种相对熵等价定义*)

已知 $D(Y||Z)\geq 0$ ，且当且仅当 $Y$ 和 $Z$ 分布相同时具有相等性。然而，$D$ 是非对称的，不满足三角不等式，甚至可以是无限的，特别是当 $\text{Supp}(Y)$ 不包含在 $\text{Supp}(Z)$ 中时。

（*注：**支撑集 $\text{Supp}()$**：其实就是函数的非零部分子集，比如 ReLU 函数的支撑集就是 $(0, +\infty)$，一个概率分布的支撑集就是所有概率密度非零部分的集合。具体定义见* [维基百科](https://zh.wikipedia.org/wiki/%E6%94%AF%E6%92%91%E9%9B%86)）