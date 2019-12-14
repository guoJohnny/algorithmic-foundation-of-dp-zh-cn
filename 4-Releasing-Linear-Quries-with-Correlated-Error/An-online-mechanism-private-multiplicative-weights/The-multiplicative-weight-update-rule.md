# 4.2.1 可乘权重算法更新规则

首先，我们给出可乘权重算法的更新规则，并在回答线性查询的语言中证明其收敛性定理。将数据库 $x$ 视为数据全体 $\mathcal{X}$ 上的概率分布将很方便。也就是说，让 $\Delta([\mathcal{X}])$ 表示集合 $[|\mathcal{X}|]$ 上的概率分布集合，我们有 $x \in\Delta([\mathcal{X}])$。请注意，我们始终可以缩放数据库以具有此属性，而无需更改任何线性查询的规范化值。

![可乘权重算法更新规则](/4-Releasing-Linear-Quries-with-Correlated-Error/img/MWUpdateRule.png)

**定理 4.10** 固定一类线性查询 $\mathcal{Q}$ 和一个数据库 $x \in\Delta([\mathcal{X}])$，并让 $x^1 \in\Delta([\mathcal{X}])$ 描述 $\mathcal{X}$ 上的均匀分布：
$x_i^1=1/|\mathcal{X}|$。 现在考虑数据库的最大长度序列 $x^t$（$t\in\{2,...,L\}$）。如 **算法5** 中所述，通过设置 $x^{t+1}=\boldsymbol{MW}(x^t,f_t,v_t)$ 来生成序列，其中对于每个 $t$，$f_t\in\mathcal{Q}$ 和  $v_t \in\mathbb{R}$ 使得：

$$
\begin{aligned}
   &1.\ |f_t(x)-f_t(x^t)|>\alpha,\text{and} \\
   &2.\ |f_t(x)-v_t| <\alpha
\end{aligned}
$$

则：

$$
L\leq 1+\frac{4\log|\mathcal{X}|}{\alpha^2}
$$

注意，如果我们证明这个定理，我们将证明对于序列中的最后一个数据库 $x^{L+1}$ ，对于所有 $f\in \mathcal{Q}:|f(x)-f(x^{L+1})|\leq \alpha$，否则可能会扩展序列，与定理中的序列最大值 $L$ 矛盾。
