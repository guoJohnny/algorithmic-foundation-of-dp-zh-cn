# 查询算法的Boosting

我们将使用第[2](/2-Basic-Terms/Overview.html)节中概述的数据库的*行表示*，其中我们将数据库视为行的多重集或$$\mathcal{X}$$的元素。固定数据库大小$$n$$、数据域$$\mathcal{X}$$和敏感度最大为$$\rho$$的实值查询的查询集$$\mathcal{Q}={q:\mathcal{X}^*→\mathbb{R}}$$。

我们假设存在一个基本大纲生成器（在第[6.2](/6-Boosting-for-Queries/Base-synopsis-generators/A-generalization-bound.html)节中，我们将看到如何构造这些）。接下来，我们需要的基本生成器的性质是，对于查询集$$\mathcal{Q}$$上的任何分布$$\mathcal{D}$$，基本生成器的输出都可以用于计算大部分查询的准确答案，其中 “大分数” 是根据$$\mathcal{D}$$给出的权重定义的。基生成器由$$k$$参数化，即要采样的查询数；$$\lambda$$是输出的精度要求；  η 是对“大”的度量，描述了大部分查询的含义，$$\beta$$是失败概率。

**定义 6.1**（$$(k,\lambda,\eta,\beta)-$$基本大纲生成器）对于固定的数据库大小$n$，数据域$$\mathcal{X}$$和查询集$$\mathcal{Q}$$，考虑大纲生成器$$\mathcal{M}$$，其独立地从$$\mathcal{Q}$$上的分布$$\mathcal{D}$$对$$k$$个查询进行采样并输出大纲。我们称$$\mathcal{M}$$是一个$$(k,\lambda,\eta,\beta)-$$基本大纲生成器，如果对于任何$$\mathcal{Q}$$上的分布$$\mathcal{D}$$，除了$$\beta$$概率之外，所有$$\mathcal{M}$$的硬币翻转，$$\mathcal{M}$$输出的大纲$$\mathcal{S}$$对于由$$\mathcal{D}$$加权的$$\mathcal{Q}$$的$$1/2+\eta$$质量是$$\lambda-$$精确的：
$$
\begin{align}
\underset{q\sim\mathcal{D}}{\text{Pr}}[|q(\mathcal{S})-q(x)|\leq\eta]\geq1/2+\eta.\tag{6.1}
\end{align}
$$
查询增强算法可用于任何类别的查询和任何不同的私有基本大纲生成器。 运行时间继承自基本大纲生成器。Booster在$$|\mathcal{Q}|$$中投入了准线性的额外时间，特别是其运行时间并不直接依赖于数据域的大小。

要指定提升（boosting）算法，我们需要指定停止条件、聚合机制以及用于更新$$\mathcal{Q}$$上的当前分布的算法。
