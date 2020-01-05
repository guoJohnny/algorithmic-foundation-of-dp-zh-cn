# 5.1 𝞪-nets 机制

给定一个查询集 $\mathcal{Q}$，下面我们开始定义 $\alpha$-nets。

**定义 5.2（$\alpha$-nets。）** 关于查询类 $\mathcal{Q}$ 的数据结构 $\alpha$-nets 为集合 $\mathcal{N}\subset \mathbb{N}^{|\mathcal{X}|}$。对于所有 $x\in \mathbb{N}^{\mathcal{|X|}}$，都存在一个 $\alpha$-nets 的元素 $y\in \mathcal{N}$，使得：

$$
\max_{f\in\mathcal{Q}}|f(x)-f(y)|\leq \alpha
$$

我们用 $\mathcal{N}_\alpha(\mathcal{Q})$ 表示在 $\mathcal{Q}$ 的所有 $\alpha$-nets 集合中最小的 $\alpha$-nets 基数。

也就是说，对于每个可能的数据库 $x$ 及 $\mathcal{Q}$ 中的所有查询，都存在一个 $\alpha$-nets 的元素，该元素“看起”来像 $x$，直到容错度为 $\alpha$。

小 $\alpha$-nets 对我们很有用，因为当与指数机制配对时，它们将为查询带来高精度。给定一类函数 $\mathcal{Q}$，我们将定义一个指数机制的实例化，称之为 **Net 机制**。我们首先观察到 **Net 机制** 保留了 $\varepsilon$-差分隐私。

![NetMachanism](/5-Generalizations/img/NetMachanism.png)

**命题 5.1** **Net 机制** 是 $(\varepsilon,0)$-差分隐私的。

**【证明】** **Net 机制** 只是指数机制的实例化。因此，隐私定理遵循 [**定理 3.10**](/3-Basic-Techniques-and-Composition-Theorems/The-exponential-mechanism.html)。

**【命题 5.1 证毕】**

我们可以类似地对指数机制进行分析，以开始理解 **Net 机制** 的效用保证：

**命题 5.2** 令 $\mathcal{Q}$ 为敏感度 $1/\Vert x \Vert_1$ 查询的任何类别。令 $y$ 为 **Net 机制** $\text{NetMechanism}(x,\mathcal{Q},\varepsilon,\alpha)$ 输出的数据库。然后有 $1-\beta$ 的概率使得：

$$
\max _{f \in \mathcal{Q}}|f(x)-f(y)| \leq \alpha+\frac{2\left(\log \left(\left|\mathcal{N}_{\alpha}(\mathcal{Q})\right|\right)+\log \left(\frac{1}{\beta}\right)\right)}{\varepsilon\|x\|_{1}}
$$

**【证明】**通过应用**定理 3.11**并注意到 $S(q)=\frac{1}{\Vert x \Vert_1}$，并且根据 **α-net** 的定义有 $\text{OPT}(D)\leq \alpha$，我们发现：

$$
\operatorname{Pr}\left[\max _{f \in \mathcal{Q}}|f(x)-f(y)| \geq \alpha+\frac{2}{\varepsilon\|x\|_{1}}\left(\log \left(\left|\mathcal{N}_{\alpha}(\mathcal{Q})\right|\right)+t\right)\right] \leq e^{-t}
$$

当 $t=\log(\frac{1}{\beta})$ 则完成证明命题 5.2。

**【命题 5.2 证毕】**