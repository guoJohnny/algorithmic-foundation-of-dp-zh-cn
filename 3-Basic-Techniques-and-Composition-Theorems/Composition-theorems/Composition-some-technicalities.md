# 3.5.1 组成：一些技术细节

在本节的剩余部分，我们将证明一个更复杂的组成定理。为此，我们需要一些定义和引理，用分布之间的距离度量重新表述差异隐私。在下面的分数量中，如果分母为零，那么我们将分数的值定义为无穷大（分子总是正的）。

**定义3.5（KL散度）** KL-散度（Kullback-Leibler divergence），又称为 **相对熵**。两个随机变量 $Y$ 和 $Z$（取同一域的值）之间的 KL-散度定义为：

$$
\begin{aligned}
    D(Y||Z) = \mathbb{E}_{y \backsim Y}\Big[\ln\frac{\text{Pr}[Y=y]}{\text{Pr}[Z=y]}\Big] &= \sum_{y \backsim Y}\text{Pr}(y)\ln\frac{\text{Pr}[Y=y]}{\text{Pr}[Z=y]}\\
    &=\int_{-\infty}^{\infty}p_Y(y)\ln\frac{p_Y(y)}{p_Z(y)}dy
\end{aligned}
$$

(*注：增加离散和连续的两种相对熵等价定义*)

已知 $D(Y||Z)\geq 0$ ，且当且仅当 $Y$ 和 $Z$ 分布相同时具有相等性。然而，$D$ 是非对称的，不满足三角不等式，甚至可以是无限的，特别是当 $\text{Supp}(Y)$ 不包含在 $\text{Supp}(Z)$ 中时。

（*注：**支撑集 $\text{Supp}()$**：其实就是函数的非零部分子集，比如 ReLU 函数的支撑集就是 $(0, +\infty)$，一个概率分布的支撑集就是所有概率密度非零部分的集合。具体定义见* [维基百科](https://zh.wikipedia.org/wiki/%E6%94%AF%E6%92%91%E9%9B%86)）

**定义3.6（最大散度）** 取自同一域的两个随机变量 $Y$ 和 $Z$ 之间的最大散度定义为：

$$
D(Y||Z)_{\infty} = \max_{S \subseteq \text{Supp}(Y)}\Big[\ln\frac{\text{Pr}[Y\in S]}{\text{Pr}[Z \in S]}\Big]
$$

$Y$ 和 $Z$ 之间的 $\delta$-近似最大散度定义为：

$$
D(Y||Z)_{\infty}^{\delta} = \max_{S \subseteq \text{Supp}(Y):\text{Pr}[Y \in S] \geq \delta}\Big[\ln\frac{\text{Pr}[Y\in S]-\delta}{\text{Pr}[Z \in S]}\Big]
$$

**备注3.1** 请注意，机制 $\mathcal{M}$ 为：

- 1.当且仅当在每对相邻数据库 $x,\enspace y,\enspace D(\mathcal{M}(x)||\mathcal{M}(y))_{\infty} \leq \varepsilon, \enspace D(\mathcal{M}(y)||\mathcal{M}(x))_{\infty} \leq \varepsilon$时，机制为 $\varepsilon$ -差分隐私。
- 2.当且仅当在每两个相邻的数据库 $x,\enspace y \enspace D(\mathcal{M}(x)||\mathcal{M}(y))_{\infty}^{\delta} \leq \varepsilon \enspace D(\mathcal{M}(y)||\mathcal{M}(x))_{\infty}^{\delta} \leq \varepsilon$ 时，机制为 $(\varepsilon,\delta)$ -差分隐私。

另一个有用的距离度量是两个随机变量 $Y$ 和 $Z$ 之间的统计距离，定义为:

$$
\Delta(Y,Z) \overset{\text{def}}{=} \max_{S}|\text{Pr}[Y \in S]-\text{Pr}[Z \in S]|
$$