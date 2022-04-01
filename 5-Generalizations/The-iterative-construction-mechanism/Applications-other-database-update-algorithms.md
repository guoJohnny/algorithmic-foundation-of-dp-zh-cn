# 5.2.1 应用：其他数据库更新算法

这里我们给出几个其他的数据库更新算法。第一个是在$\alpha-\text{nets}$上直接工作，因此，即使对于非线性查询也能获得非平凡界限（不同于可乘权重，其只能对线性查询使用）。第二个是对线性查询的另一个数据库更新算法，但和可乘权重算法的界限不可比较。（一般来说，当数据集的大小接近于数据域的大小时，它将产生更好的界限，而当数据集比数据域小得多时，乘法权重将产生更好的界限）。

我们首先讨论中位数机制，它利用了$\alpha-\text{nets}$的优势。中位数机制不对数据库进行操作，而是对中位数数据结构进行操作。

**定义 5.6** （中位数数据结构）中位数据结构$\textbf{D}$是一个数据库的集合：$\textbf{D}\subset\mathbb{N}^{|\mathcal{X}|}$。任何查询$f$都可以在中位数数据结构上进行如下评估：$f(\textbf{D})=\text{Median}(\{f(x):x\in\textbf{D}\})$。

换句话说，中位数数据结构只是一个数据库的集合。为了评估一个查询，我们只需在集合中的每一个数据库上评估该查询，然后返回中位数值。请注意，中位数数据结构给出的答案不需要与 *任何* 数据库保持一致！然而，它将有一个有用的特性，即每当它出错时，它将排除其集合中至少一半的数据集，因为它们与真正的数据集不一致。

中位数机制是十分简单的：

![median mechanism](/5-Generalizations/img/MedianMechanism.png)

中位数机制的直观来看是这样的：它维护了一组数据库，这些数据库与迄今为止它所看到的区分性查询的答案一致。每当它收到一个与真实数据库有实质上的不同的查询和回答，其就会自我更新来删除所有与新信息不一致的数据库。因为它总是选择它的答案作为它所维护的一致数据库集合中的中位数数据库，每一个更新步骤都会删除至少一半的一致数据库！此外，由于它最初选择的数据库集是一个关于$\mathcal{Q}$的$\alpha-\text{net}$，总有一些数据库从未被删除，因为它在所有的查询中都保持一致。这限制了该机制可以执行多少轮更新。那么中位数机制是如何做的？

**定理 5.8** 对于任何查询类$\mathcal{Q}$，中位数机制是一个$T(\alpha)-$数据库更新算法，$T(\alpha)=\log|N_\alpha(\mathcal{Q})|$

【证明】我们必须说明对于带有特性$|f^{t}(\textbf{D}^t)-f^t(x)|>\alpha$和$|v_t-f^t(x)|<\alpha$的任何序列$\{(D^t,f_t,v_t)\}_{t=1,...,L}$不可能有$L>\log|\mathcal{N}(\mathcal{Q})|$。首先观察到，因为$\textbf{D}^0=\mathcal{N}_\alpha(\mathcal{Q})$对$\mathcal{Q}$是一个$\alpha-\text{net}$，根据定义，对于所有$t$至少有一个$y$，$y\in\textbf{D}^t$（回顾一下，更新规则只在错误率至少为$\alpha$的查询中被调用。由于保证有一个数据库$y$在所有查询中的误差都小于$\alpha$，所以它永远不会被更新步骤所删除）。因此，我们总是可以用$\textbf{D}^t$回答查询，并且对于所有$t$，都有$|\textbf{D}^t|\geq1$。然后观察到对于每一个$t$，$|\textbf{D}^t|\leq|\textbf{D}^t|/2$。这是因为每次更新步骤删除至少一半的元素：所有元素相对于查询$f_t$至少与$D_t$中的中位元素一样大，或最多与$D_t$中的中位元素一样大。因此，经过$L$次更新步骤后，$|\textbf{D}^L|\leq1/2^L\cdot|\mathcal{N}_\alpha(\mathcal{Q})|$。如果设置$L>\log|\mathcal{N}_\alpha(\mathcal{Q})|$，就会得到$|\textbf{D}^L|\leq1$，与条件矛盾。

**备注 5.2** 对线性类$\mathcal{Q}$，我们可以参考[**定理 4.2**](/4-Releasing-Linear-Quries-with-Correlated-Error/An-offline-algorithm-SmallDB/An-offline-algorithm-SmallDB.html)中给的$\mathcal{N}_\alpha(\mathcal{Q})$的上界来了解中位数机制是对于$T(\alpha)=\log|\mathcal{Q}|\log|\mathcal{X}|/\alpha^2$的$T(\alpha)$数据库更新算法。这比我们为可乘权重算法给出的界限差$\log|\mathcal{Q}|$倍。另一方面，中位数机制算法的任何内容都不是特定于线性查询的——它同样适用于允许小型网络的任何类型的查询。 我们可以利用这一事实来处理非线性低灵敏度查询。

**定理 5.9** 每一种查询类$\mathcal{Q}$和每一个$\alpha\geq0$，对于大小为$||x||_1=n$的数据库都有一个大小为$\mathcal{N}_\alpha(\mathcal{Q})\leq|\mathcal{X}|^n$的$\alpha-\text{net}$。

【证明】我们可以简单的令$\mathcal{N}_\alpha(\mathcal{Q})$为所有大小为$||y||_1=n$的$|\mathcal{X}|^n$数据库的集合。然后对于所有$x$，$||x||_1=n$，我们有$x\in \mathcal{N}_\alpha(\mathcal{Q})$，并且十分明确：$\min_{y\in \mathcal{N}_\alpha(\mathcal{Q})}\max_{f\in \mathcal{Q}}|f(x)-f(y)|=0$

我们可以利用这个事实来获得任意低敏感度查询的查询发布算法，而不仅仅是线性查询。 将[**定理 5.7**](5-Generalizations/The-iterative-construction-mechanism/The-iterative-construction-mechanism.html)应用于上述界限，我们发现：

**定理 5.10** 使用中位数机制和指数机制区分器，IC机制是$(\varepsilon,\delta)-$差分隐私的且以至少$1-\beta$的概率，IC算法返回一个数据库$y$使得：$\max_{f\in\mathcal{Q}}|f(x)-f(y)|\leq\alpha$，其中：
$$
\alpha\leq\frac{16\sqrt{\log|\mathcal{X}|\log(\frac{1}{\delta})}}{\sqrt{n}\varepsilon}\big(\log\frac{2|\mathcal{Q}|n\log{\mathcal{X}}}{\beta}\big)
$$
其中$\mathcal{Q}$可以是任何灵敏度为$1/n$的查询系列，不一定是线性的。

【证明】这简单地通过结合**定理 5.8**和**5.9**来发现中位数机制是对于大小为$||x||_1=n$的数据库，对于每个$\alpha>0$和每一类查询$\mathcal{Q}$的$T(\alpha)=n\log|\mathcal{X}|$的$T(\alpha)-$数据库更新算法。将其带入[**定理5.7**](/5-Generalizations/The-iterative-construction-mechanism/The-iterative-construction-mechanism.html)得到所需的界限。

请注意，这个界限几乎与我们在[**定理 4.15**](/4-Releasing-Linear-Quries-with-Correlated-Error/An-online-mechanism-private-multiplicative-weights/The-OnlineMW-via-NumericSparse-algorithm.html)中线性查询的特殊情况下所能达到的一样好！ 然而，与线性查询不同的是，因为任意查询可能没有明显小于此处使用的平凡网络$\alpha-\text{net}$，所以如果我们想要$(\varepsilon,0)$差分隐私，我们无法获得非平凡的准确度保证。

我们提出的下一个数据库更新算法还是用于线性查询，但实现了可乘权重数据库更新算法无法比拟的界限。它是基于在线学习的感知器（Perceptron）算法（就像可乘权重来自在线学习的对冲算法一样）。因为该算法用于线性查询，我们将每个查询$f_t\in \mathcal{Q}$视为一个向量$f_t\in [0,1]^{|\mathcal{X}|}$。请注意，不是进行可乘更新，而是和MW数据库更新算法一样，这里我们做一个附加更新。在分析中，我们将看到这种数据库更新算法对数据库域大小的依赖性（与可乘权重相比）呈指数级差，但对数据库大小的依赖性更强。因此，与数据域的大小相比，大型数据库的性能将更好，而与数据域的大小相比，小型数据库的性能会更差。

![Perceptron](/5-Generalizations/img/perceptron.png)

**定理 5.11** Perceptron是一种$T(\alpha)-$数据库更新算法，对于：
$$
\begin{aligned}
T(\alpha)=\left(\frac{||x||_2}{||x||_1}\right)^2\cdot\frac{|\mathcal{X}|}{\alpha^2}
\end{aligned}
$$
【证明】与可乘权重不同，分析感知器算法将更方便，无需将数据库归一化为概率分布，然后证明他是一个$T(\alpha')=\frac{||x||_2^2|\mathcal{X}|}{\alpha'^2}$的$T(\alpha')$数据库更新算法。代入$\alpha'=\alpha||x||_1$就能完成证明。回顾下，因为每个查询$f_t$都是线性地，我们可以把$f_t\in [0,1]^{|\mathcal{X}|}$视为一个评价$f_t(x)$等于$\langle f_t,x\rangle$的向量。

我们必须说明对于任何序列$\{(x^t,f_t,v_t\}_{t=1,...,L}$满足特征$|f_t(x^t)-f_t(x)|>\alpha'$和$|v_t-f_t(x)|<\alpha'$不能有$L>\frac{||x||_2^2|\mathcal{X|}}{\alpha'^2}$。

我们使用一个潜在的参数来证明对于每个$t = 1,2,...,L$，$x^{t+1}$比$x^t$更接近$x$。 具体来说，我们的潜在函数是数据库$x - x^t$的$L_2^2$范数，定义为：
$$
||x||_2^2=\sum_{i\in\mathcal{X}}x(i)^2.
$$
观察到$||x-x^1||_2^2=||x||_2^2$，因为$x^1=0$，且$||x||_2^2\geq0$。因此，足以证明在每一步中，这个潜在参数都降低了$\alpha'^2/|\mathcal{X}|$。我们分析了$f_t(x^t)>v_t$的情况，对相反情况的分析将是类似的。令$R^t=x^t-x$。观察到这种情况我们有：
$$
f_t(R^t)=f_t(x^t)-f_t(x)\geq\alpha'.
$$
现在我们可以分析潜在参数中的下降。
$$
\begin{aligned}
||R^t||_2^2-||R^{t+1}||_2^2&=||R^t||_2^2-||R^t-(\alpha'/|\mathcal{X}|)\cdot f_t(i)||_2^2\\
&=\sum_{i\in\mathcal{X}}((R^t(i))^2-(R^t(i)-(\alpha'/|\mathcal{X}|)))\\
&=\sum_{i\in\mathcal{X}}\left(\frac{2\alpha'}{|\mathcal{X}|}\cdot R^t(i)f_t(i)-\frac{\alpha'^2}{|\mathcal{X}|^2}f_t(i)^2\right)\\
&=\frac{2\alpha'}{|\mathcal{X}|}f_t(R^t)-\frac{\alpha'^2}{|\mathcal{X}|^2}\sum_{i\in\mathcal{X}}f_t(i)^2\\
&\geq\frac{2\alpha'}{|\mathcal{X}|}f_t(R^t)-\frac{\alpha'^2}{|\mathcal{X}|^2}|\mathcal{X}|\\
&\geq\frac{2\alpha'^2}{|\mathcal{X}|}-\frac{\alpha'^2}{|\mathcal{X}|}=\frac{\alpha'^2}{|\mathcal{X}|}.
\end{aligned}
$$
这通过$||x||_2^2|\mathcal{X|}/{\alpha'^2}$限制了步骤数，完成证明。我们现在可以将这个界限代入[**定理5.7**](/5-Generalizations/The-iterative-construction-mechanism/The-iterative-construction-mechanism.html)以获得迭代构造机制的以下界限：

**定理 5.12** 使用感知器数据库更新算法，配合指数机制区分器，IC机制是$(\varepsilon,\delta)-$差分隐私的并且以至少$1-\beta$的概率，IC 算法返回一个数据库$y$有：$\max_{f\in\mathcal{\mathcal{Q}}}|f(x)-f(y)|\leq\alpha$，其中：
$$
\alpha\leq\frac{\sqrt[4]{4}\sqrt{||x||_2}(4|\mathcal{X}|\ln(1/\delta))^{1/4}\sqrt\frac{\log(2|\mathcal{Q}||\mathcal{X}|\cdot||x||_2^2)}{\beta}}{\sqrt{\varepsilon}||x||_1}
$$
其中 Q 是一类线性查询。（译者注：原文中是$4\sqrt4$，感觉是印刷错误）

例如，如果数据库$x$表示图的边集，对于所有$i$我们将有$x_i\in[0, 1]$，因此：
$$
\begin{aligned}
\frac{\sqrt{||x||_2}}{||x||_1}\leq\left(\frac{1}{||x||_1}\right)^{3}.
\end{aligned}
$$
因此，感知器数据库更新算法在密集图上的性能将优于可乘权重数据库更新算法。

