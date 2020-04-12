# 5.2 迭代构建机制

在本节中，我们将推导出隐私累加权重算法的离线泛化算法，可以使用任何适当定义的学习算法将这个算法进行实例化。一般来说，数据库更新算法维护一系列数据结构 $D^1,D^2,...$，这些结构为输入数据库 $x$ 提供​​越来越好的近似值（在某种意义上取决于数据库更新算法）。此外，这些机制通过仅考虑一个查询 $f$ 来产生序列中的下一个数据结构，这个查询 $f$ 在真实数据库 $x$ 产生的结果与在数据结构 $D^t$ 产生的结果有显著的不同。（即：$f(D^t)$ 与 $f(x)$ 区别很大。）本节中的算法表明，在很小的程度上，以差分隐私的方式解决 “查询-发布” 问题就等于以差分隐私的方式解决更简单的学习或区分问题：给定了隐私区分算法和非隐私数据库更新算法，我们得到相应的隐私发布算法。对于一般的线性查询设置，我们可以插入指数机制作为规范的专用区分器，而将乘数权重算法作为通用的数据库更新算法，但是在特殊情况下，可以使用更有效的区分器。

从语法上讲，我们将考虑形式为 $U:\mathcal{D}\times\mathcal{Q}\times\mathbb{R}\to \mathcal{D}$ 的函数。其中 $\mathcal{D}$表示一类数据结构，这类数据结构可以对 $\mathcal{Q}$ 中的查询进行评估。函数 $U$ 的输入为：1、 $\mathcal{D}$ 中的数据结构，将当前数据结构表示为 $D^t$；2、区别查询 $f$，并且可以被限制为某个集合 $\mathcal{Q}$；3、并且还实数 $x$，其估计 $f(x)$。以下我们正式定义一个 ***数据库更新序列***，以控制用于生成数据库序列 $D^1,D^2,...$ 的 $U$ 输入序列。

**定义 5.3 数据库更新序列** 设 $x\in \mathbb{N}^{|\mathcal{X}|}$ 为任意数据库，并设 $\{(D^t,f_t,v_t)\}_{t=1,...,L}\in(\mathcal{D}\times\mathcal{Q}\times\mathbb{R})^L$ 为元组序列。如果满足以下条件：

- 1、$D^1=U(\bot,\cdot,\cdot)$ ，
- 2、任意 $t=1,2,...,L,|f_t(x)-f_t(D^t)|\geq \alpha$
- 3、任意 $t=1,2,...,L,|f_t(x)-v_t| < \alpha$
- 4、任意 $t=1,2,...,L-1,D^{t+1}=U(D^t,f_t,v_t)$

则将其这个序列称之为：$(U,x,\mathcal{Q},\alpha,T)$-数据库更新序列（ $(U,x,\mathcal{Q},\alpha,T)-database\  update \ sequence$ ）

注意，对于数据库更新算法，近似响应 $v_t$ 仅用于确定 $f_t(x)-f_t(D^t)$ 的符号，这是**条件3**中要求 $f_t(x)-v_t$ 的估计误差小于 $\alpha$ 的动机。我们更关注数据库更新算法的主要效率衡量标准是：在数据库 $D^t$ 相对于 $\mathcal{Q}$ 中的查询很好地近似 $x$ 之前，我们需要执行的最大更新次数。为此，我们将数据库更新算法定义为如下：

**定义5.4 数据库更新算法** 令 $U:\mathcal{D}\times\mathcal{Q}\times\mathbb{R}\to \mathcal{D}$ 为更新规则，令 $T:\mathbb{R}\to\mathbb{R}$ 为函数。对每个数据库 $x\in \mathbb{N}^{|\mathcal{X}|}$ 如果每个 $(U,x,\mathcal{Q},\alpha,T)$-数据库更新序列满足 $L\leq T(\alpha)$，则称 $U$ 为：查询类 $\mathcal{Q}$ 的 $T(\alpha)$- 数据库更新算法。

$T(\alpha)$- 数据库更新算法的定义表明如果 $U$ 是 $T(\alpha)$- 数据库更新算法，则给定最大 $(U,x,\mathcal{Q},\alpha,U)$-数据库更新序列，最终数据库 $D^L$ 必须满足 $\max_{f\in\mathcal{Q}}|f(x)-f(D^L)|\leq \alpha$，否则将存在满足定义5.3的条件2的另一个查询，因此将存在一个 $(U,x,\mathcal{Q},\alpha,L+1)$-数据库更新序列，与最大矛盾。 也就是说，$T(\alpha)$-数据库更新规则的目标是生成最大的数据库更新序列，并且最大数据库更新序列中的最终数据结构必须对每个查询 $f\in \mathcal{Q}$ 的近似响应进行编码。

既然我们已经定义了数据库更新算法，那么在 [**定理4.10**](4-Releasing-Linear-Quries-with-Correlated-Error/An-online-mechanism-private-multiplicative-weights/The-multiplicative-weight-update-rule.html) 中我们真正证明的是，可乘权重算法是 $T(\alpha)=4\log|\mathcal{X}|/\alpha^2$ 的 $T(\alpha)$-数据库更新算法。 