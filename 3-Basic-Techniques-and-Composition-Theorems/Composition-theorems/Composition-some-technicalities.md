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
D_{\infty}(Y||Z) = \max_{S \subseteq \text{Supp}(Y)}\Big[\ln\frac{\text{Pr}[Y\in S]}{\text{Pr}[Z \in S]}\Big]
$$

$Y$ 和 $Z$ 之间的 $\delta$-近似最大散度定义为：

$$
D_{\infty}^{\delta}(Y||Z) = \max_{S \subseteq \text{Supp}(Y):\text{Pr}[Y \in S] \geq \delta}\Big[\ln\frac{\text{Pr}[Y\in S]-\delta}{\text{Pr}[Z \in S]}\Big]
$$

**备注3.1** 请注意，机制 $\mathcal{M}$ 为：

- 1.当且仅当在每对相邻数据库 $x,\enspace y,\enspace D_{\infty}(\mathcal{M}(x)||\mathcal{M}(y)) \leq \varepsilon, \enspace D_{\infty}(\mathcal{M}(y)||\mathcal{M}(x)) \leq \varepsilon$时，机制为 $\varepsilon$ -差分隐私。
- 2.当且仅当在每两个相邻的数据库 $x,\enspace y \enspace D_{\infty}^{\delta}(\mathcal{M}(x)||\mathcal{M}(y)) \leq \varepsilon \enspace D_{\infty}^{\delta}(\mathcal{M}(y)||\mathcal{M}(x)) \leq \varepsilon$ 时，机制为 $(\varepsilon,\delta)$ -差分隐私。

另一个有用的距离度量是两个随机变量 $Y$ 和 $Z$ 之间的统计距离，定义为:

$$
\Delta(Y,Z) \overset{\text{def}}{=} \max_{S}|\text{Pr}[Y \in S]-\text{Pr}[Z \in S]|
$$

如果 $\Delta(Y,Z)\leq \delta$,我们说 $Y,Z$ 是δ-接近（原文“δ-close”）的，

我们将根据确切的最大散度和统计距离重新制定最大散度公式：

**引理 3.17**

- 1.当且仅当存在一个随机变量 $Y'$ 满足 $\Delta(Y,Y')\leq \delta,\enspace D_{\infty}(Y'||Z)\leq \varepsilon$ 时，$D_{\infty}^{\delta}(Y||Z)\leq \varepsilon$ 成立
- 2.当且仅当存在随机变量 $Y',Z'$ 满足 $\Delta(Y,Y')\leq \delta/(e^{\varepsilon}+1),\enspace\Delta(Z,Z')\leq \delta/(e^{\varepsilon}+1),\enspace D_{\infty}(Y'||Z')\leq \varepsilon$ 时，$D_{\infty}^{\delta}(Y||Z)\leq \varepsilon,\enspace D_{\infty}^{\delta}(Z||Y)\leq \varepsilon$ 成立。

【证明】略

**引理 3.18** 假设随机变量 $Y,\enspace Z$ 满足 $D_{\infty}(Y||Z)\leq \varepsilon \enspace D_{\infty}(Z||Y)\leq \varepsilon$，则 $D(Y||Z)\leq \varepsilon\cdot(e^{\varepsilon}-1)$。

【证明】由KL散度性质可知：任意 $Y,\enspace Z$ 有 $D(Y||Z)\geq0$，所以 $D(Y||Z)$ 可以被 $D(Y||Z) + D(Z||Y)$ 约束：

$$
\begin{aligned}
    D(Y||Z) &\leq D(Y||Z) + D(Z||Y)\\
    &= \sum_y \text{Pr}[Y=y]\cdot\Big(\ln\frac{\text{Pr}[Y=y]}{\text{Pr}[Z=y]}+\ln\frac{\text{Pr}[Z=y]}{\text{Pr}[Y=y]}\Big)\\
    &\enspace \enspace + (\text{Pr}[Z=y]-\text{Pr}[Y=y])\cdot \Big(\ln\frac{\text{Pr}[Z=y]}{\text{Pr}[Y=y]}\Big)\\
    &\leq \sum_y[0+|\text{Pr}[Z=y]-\text{Pr}[Y=y]|\cdot\varepsilon]\\
    &= \varepsilon\cdot\sum_y[\max\{\text{Pr}[Y=y],\text{Pr}[Z=y]\}\\
    &\enspace \enspace -\min\{\text{Pr}[Y=y],\text{Pr}[Z=y]\}]\\
    &\leq \varepsilon\cdot\sum_y[(e^\varepsilon-1)\cdot\min\{\text{Pr}[Y=y],\text{Pr}[Z=y]\}]\\
    &\leq \varepsilon(e^\varepsilon-1)
\end{aligned}
$$

**引理3.19（Azuma不等式）** 令 $C_1,...C_k$ 为实值变量满足任意一个 $i\in[k],\text{Pr}[|C_i|\leq \alpha]=1$，且对于每一个 $(c_1,...,c_{i-1})\in \text{Supp}(C_1,...C_{i-1})$ 我们有：

$$
\mathbb{E}[C_i|C_1=c_1,...,C_{i-1}=c_{i-1}]\leq\beta
$$

对于任一 $z > 0$，我们有：

$$
\text{Pr}\Big[\sum_{i=1}^kC_i>k\beta + z\sqrt{k}\cdot\alpha\Big] \leq e^{-z^2/2}
$$
