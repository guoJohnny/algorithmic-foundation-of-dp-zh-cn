# 4.2.1 可乘权重算法更新规则

首先，我们给出可乘权重算法的更新规则，并在回答线性查询的语言中证明其收敛性定理。将数据库 $x$ 视为数据全体 $\mathcal{X}$ 上的概率分布将很方便。也就是说，让 $\Delta([\mathcal{X}])$ 表示集合 $[|\mathcal{X}|]$ 上的概率分布集合，我们有 $x \in\Delta([\mathcal{X}])$。请注意，我们始终可以缩放数据库以具有此属性，而无需更改任何线性查询的规范化值。

![可乘权重算法更新规则](/4-Releasing-Linear-Quries-with-Correlated-Error/img/MWUpdateRule.png)

**定理 4.10** 固定一类线性查询 $\mathcal{Q}$ 和一个数据库 $x \in\Delta([\mathcal{X}])$，并让 $x^1 \in\Delta([\mathcal{X}])$ 描述 $\mathcal{X}$ 上的均匀分布：
$x_i^1=1/|\mathcal{X}|$。 现在考虑数据库的最大长度序列 $x^t$（$t\in\{2,...,L\}$）。如 **算法5** 中所述，通过设置 $x^{t+1}=\boldsymbol{MW}(x^t,f_t,v_t)$ 来生成序列，其中对于每个 $t$，$f_t\in\mathcal{Q}$ 和  $v_t \in\mathbb{R}$ 满足以下两个条件：

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

注意，如果我们证明这个定理，我们将证明对于序列中的最后一个数据库 $x^{L+1}$ ，对于所有 $f\in \mathcal{Q}:|f(x)-f(x^{L+1})|\leq \alpha$，否则可能会扩展序列，与定理中的序列最大值 $L$ 矛盾。换句话说，给定有区别的查询  $f_t$ ，可乘权重更新规则只需要很少的步骤 $(L)$ 就可以对线性查询 $\mathcal{Q}$ 的任何类别学习私有数据库 $x$，直到一定的精度 $\alpha$。我们将在下面的在线可乘权重算法中使用这个定理。**在线可乘权重算法**将始终在 $t$ 时刻具有对数据库 $x$ 的公开近似值 $x^t$。给定输入查询 $f$，该算法将计算 $|f(x)-f(x^t)|$ 差别的噪声近似值。如果（噪声）差很大，则该算法将为真实答案 $f(x)$ 提供噪声近似 $f(x)+\lambda_t$，其中 $\lambda_t$ 是从一些适当选择的 **Laplace** 分布得到。并且乘法权重算法更新规则将用参数 $(x^t,f,f(x)+\lambda_t)$ 调用。如果该可乘权重算法更新规则仅当满足 **定理 4.10 条件 1** 与 **定理 4.10 条件 2** 时被调用，则我们应用 **定理4.10** 可以得到这样一个结论：更新不那么多（因为 $L$ 不是太大），并且得到的 $x^{L+1}$ 可以为所有 $\mathcal{Q}$ 中查询提供准确的答案（因为没有剩余其他有区别的查询了。）

通过跟踪在 $t$ 时刻测量假设数据库 $x^t$ 和真实数据库 $x$ 之间相似性的势函数 $\Psi$ 我们证明了 **定理4.10** 。（*注：势函数（potential function）：在平摊分析（amortized analysis）的势能法中，用来描述过去资源的投入可在后来操作中使用程度的函数。在线算法通常使用平摊分析。[详见维基百科与相关文章](https://zh.wikipedia.org/wiki/%E5%8A%BF%E5%87%BD%E6%95%B0)*）

我们将会表明：

- 1.势函数开始时不会太大。
- 2.在每个更新回合中，势函数都会大量减少。
- 3.势函数总是非负的。

综合这三个事实，我们将得出这样的结论：更新回合不能太多。
现在让我们开始分析收敛定理的证明。

**【证明定理 4.10】** 我们必须证明任何属性为 $|f_t(x^t)-f_t(x)|>\alpha$，且 $|v_t - f_t(x)|<\alpha$ 的序列 $\{(x^t,f_t,v_t)\}_{t=1,...,L}$ 不能有 $L>\frac{4\log|\mathcal{X}|}{\alpha^2}$。

我们将势函数定义如下。回想一下我们将数据库作为概率分布(即，假设 $\Vert x \Vert_1=1$)。当然，这不需要实际修改实际数据库。当将数据库视为概率分布时，势函数是 $x$ 和 $x^t$ 之间的相对熵（或 [**KL散度**](/3-Basic-Techniques-and-Composition-Theorems/Composition-theorems/Composition-some-technicalities.html)）：

$$
\Psi_t \overset{\text{def}}{=} KL(x\Vert x^t) = \sum_{i=1}^{|\mathcal{X}|}x[i]\log\Big(\frac{x[i]}{x^t[i]}\Big)
$$

我们从一个简单的事实开始：

**命题 4.11** 对于所有的 $t$，$\Psi_t\geq 0$ 且 $\Psi_1\leq \log|\mathcal{X}|$。

**【证明 命题 4.11】** 证明相对熵（KL-散度）始终是非负的，需要借助对数和不等式，该不等式表示如果 $a_1,...,a_n;b_1,...,b_n$ 是非负数，则：

$$
\sum_i a_i \log\frac{a_i}{b_i} \geq \Big(\sum_ia_i\Big)\frac{\sum_ia_i}{\sum_ib_i}
$$

其次证明 $\Psi_1\leq \log|\mathcal{X}|$。首先回想一下 $x^1[i]=1/|\mathcal{X}|$，则 $\Psi_1 = \sum_{i=1}^{|\mathcal{X}|}x[i]\log(|\mathcal{X}|x[i])$。注意，$x$ 为概率分布，则：当 $x[1]=1,x[i]=0,i>1$ 时，相对熵 $\Psi_1$ 有最大值，且为 $\Psi_1 = \log|\mathcal{X}|$。 

**【命题 4.11 证毕】**

我们现在要讨论的是，在每一步，势函数至少下降了 $\alpha^2/4$。因为势开始于 $\log|\mathcal{X}|$，并且必须总是非负的，所以我们知道在数据库更新序列中最多可以有 $L\leq 4\log|\mathcal{X}|/\alpha^2$ 步。首先，让我们看看每一步的势到底下降了多少：

**引理 4.12**

$$
\Psi_t - \Psi_{t+1}\geq \eta\Big(⟨ r_t,x^t ⟩-⟨ r_t,x ⟩\Big) - \eta^2
$$

**【证明】** 由于 $\sum_{i=1}^{|\mathcal{X}|}x[i]=1$，则：

$$
\begin{aligned}
   \Psi_t - \Psi_{t+1} &= \sum_{i=1}^{|\mathcal{X}|}x[i]\log\Big(\frac{x[i]}{x^t[i]}\Big) - \sum_{i=1}^{|\mathcal{X}|}x[i]\log\Big(\frac{x[i]}{x^{t+1}[i]}\Big)\\
   &= \sum_{i=1}^{|\mathcal{X}|}x[i]\log\Big(\frac{x^{t+1}[i]}{x^t[i]}\Big)\\
   &=\sum_{i=1}^{|\mathcal{X}|}x[i]\log\Big(\frac{\hat{x}_i^{t+1}/\sum_i\hat{x}_i^{t+1}}{x^t[i]}\Big)\\
   &= \sum_{i=1}^{|\mathcal{X}|}x[i]\bigg[\log\Big(\frac{x_i^t\exp(-\eta r_t[i])}{x^t[i]}\Big)-\log\Big(\sum_{j=1}^{|\mathcal{X}|}x_j^t\exp(-\eta r_t[j])\Big)\bigg]\\
   &= -\Bigg(\sum_{i=1}^{|\mathcal{X}|}x[i]\eta r_t[i]\Bigg)-\log\Bigg(\sum_{i=1}^{|\mathcal{X}|}x_j^t\exp(-\eta r_t[j])\Bigg)\\
   &= -\eta ⟨r_t,x⟩ - \log\Bigg(\sum_{i=1}^{|\mathcal{X}|}x_j^t\exp(-\eta r_t[j])\Bigg)\\
   &\geq  -\eta ⟨r_t,x⟩ - \log\Bigg(\sum_{i=1}^{|\mathcal{X}|}x_j^t(1+\eta^2-\eta r_t[j])\Bigg)\\
   &= -\eta ⟨r_t,x⟩ - \log\Big(1+\eta^2-\eta⟨r_t,x^t⟩\Big)\\
   &\geq \eta\Big(⟨ r_t,x^t ⟩-⟨ r_t,x ⟩\Big) - \eta^2
\end{aligned}
$$

第一个不等式由下面这个事实得出（*注：泰勒公式和 $r_t[j] \in r_t,r_t[j]\leq 1$*）：

$$
\exp(-\eta r_t[j])\leq 1-\eta r_t[j] + \eta^2 (r_t[j])^2\leq 1-\eta r_t[j] + \eta^2
$$

第二个不等式由对数不等式：$\log(1+y)\leq y,y>1$ 得到。

**【引理 4.12证毕】**

有了前面的命题和引理之后，可以完成剩下的证明。 根据 **数据库/查询序列** 的条件（在上述 **定理4.10** 的假设中进行了描述），对于每一个  $t$：

$$
\begin{aligned}
   &1.\ |f_t(x)-f_t(x^t)|>\alpha,\text{and} \\
   &2.\ |f_t(x)-v_t| <\alpha
\end{aligned}
$$

因此，当且仅当 $v_t < f_t(x^t)$ 时，$f_t(x)<f_t(x^t)$。 特别地，如果 $f_t(x^t)-f_t(x)\geq \alpha$，则 $r_t = f_t$ ，如果 $f_t(x)-f_t(x^t)\geq \alpha$，则 $r_t = 1-f_t$。 因此，通过 **引理4.12** 和 可乘权重更新规则中所述的 $\eta = \alpha/2$ 有：

$$
\Psi_t - \Psi_{t+1}\geq \frac{\alpha}{2}\Big(⟨ r_t,x^t ⟩-⟨ r_t,x ⟩\Big) - \frac{\alpha^2}{4} \geq \frac{\alpha}{2}(\alpha) - \frac{\alpha^2}{4} = \frac{\alpha^2}{4}
$$

最后可知：

$$
0 \leq \Psi_L\leq \Psi_1 - L\cdot\frac{\alpha^2}{4}\leq \log|\mathcal{X}|-L\cdot\frac{\alpha^2}{4}
$$

变换得到：$L \leq \frac{4\log|\mathcal{X}|}{\alpha^2}$。

**【定理 4.10 证毕】**

