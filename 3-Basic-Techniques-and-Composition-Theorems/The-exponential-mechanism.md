# 3.4 指数机制

我们在“最常见的名称”和“最常见的疾病”例子中，提到了响应的“效用”（名称或医疗疾病），在响应中我们使用拉普拉斯噪声估计了计数，并报告了噪声最大值。在这两个示例中，响应的效用都与生成的噪声值直接相关。也就是说，我们应使用与噪声大小相同的标度和相同的单位对名称或疾病的普遍程度进行适当地测量。

指数机制是为我们希望选择“最佳”响应而设计的，但将噪声直接添加到计算量可以完全破坏其价值，例如在拍卖中设定价格，目标是使收入最大化，但在最优价格中加入少量的正噪声（为了保护出价的隐私）可能会导致显著减少由此产生的收入，如下南瓜竞拍例子。

**例 3.5（南瓜竞拍）** 假设我们有大量的南瓜和四个竞标者：A，F，I，K，其中A，F，I分别出价1.00美元和K出价3.01美元，最优价格是多少？在 3.01美元时，收入为 3.01美元（只符合K的价格，故只有K买，收入3.01美元）；在 3.00美元 和 1.00美元 时候，收入为 3.00美元（只有A、F、I符合价格，收入共3美元）；但在 3.02美元时，收入为零（无人符合价格）！

指数机制是使用任意效用函数（或任意非数字范围）回答查询的天然模块（原文为“building block”积木，此处翻译为模块），同时保留了差异隐私。给定任意范围 $\mathcal{R}$，将指数机制定义为某些效用函数 $u:\mathbb{N}^{|\mathcal{X}|} \times \mathcal{R} \to \mathbb{R}$，它将数据库输出对映射到效用分数。直观地讲，对于固定的数据库 $x$，用户更喜欢该机制输出 $\mathcal{R}$ 的某些元素具有最大的效用得分。请注意，当我们谈论效用分数 $u:\mathbb{N}^{|\mathcal{X}|} \times \mathcal{R} \to \mathbb{R}$ 的敏感度时，我们只关心 $u$ 相对于其数据库参数的敏感性；效用函数 $u$ 可以是任意敏感的：

$$
\Delta u = \max_{r \in \mathcal{R}} \ \max_{x,y:\Vert x-y\Vert _1 \leq 1}|u(x,r)-u(y,r)|
$$

从直观上来看指数机制，其思想是输出每个可能的 $r \in \mathcal{R}$ ，其概率与 $\exp(\varepsilon u(x,r)/\Delta u)$ 成正比，这样隐私损失才能约为：

$$
\ln \Big(\frac{\exp(\varepsilon u(x,r)/\Delta u)}{\exp(\varepsilon u(y,r)/\Delta u)}\Big)=\varepsilon[u(x,r)-u(y,r)]/\Delta u \leq \varepsilon
$$

（*注：此处原文公式有误，翻译为更正后的公式*）

(**个人理解**：*根据效用函数敏感度 $\Delta u$ 的定义可知，数据库 $x,y$ 是相邻数据库，相差为 1，则可以构造构造一个机制，将效用得分和与输出概率关联，使得满足 $\varepsilon$-差分隐私定义的隐私损失。由 [**2.3节中的隐私损失（机制质量)**](../2-Basic-Terms/Formalizing-differential-privacy/Formalizing-differential-privacy_1.html) 可得出：当机制正比于 $\exp(\varepsilon u(x,r)/\Delta u),(\text{Pr}\lbrack \mathcal{M}(x) = \xi \rbrack \propto \exp(\varepsilon u(x,r)/\Delta u))$， 该机制的隐私损失是 $\varepsilon$*

$$
\mathcal{L}_{\mathcal{M}(x)\Vert \mathcal{M}(y)}^{(\xi)} = \ln(\frac{\text{Pr}\lbrack \mathcal{M}(x,u) = r \rbrack}{\text{Pr}\lbrack \mathcal{M}(y,u) = r \rbrack}) = \ln \Big(\frac{\exp(\varepsilon u(x,r)/\Delta u)}{\exp(\varepsilon u(y,r)/\Delta u)}\Big)
$$

)

这种直观的观点忽略了归一化项的某些影响，该归一化项出现的原因是，当有额外的人出现在数据库中，导致某些元素 $r \in \mathcal{R}$ 的效用减小而其他元素的效用增大。接下来定义的实际机制将一半的隐私预算用于归一化项的更改。

（**个人理解**：*上述公式仅仅表明，当只有一个的回答 $r$ 时，其隐私损失是符合差分隐私定义中的 $\varepsilon$。 但当可能有很多个回答时，我们就需要考虑到一个回答占总体回答概率的多少，即上段中提到的 “* **当有额外的人出现在数据库中，导致某些元素 $r \in \mathcal{R}$ 的效用减小而其他元素的效用增大** *” 。此处的归一化项（Normalization Term）指的是所有可能出现回答 $r' \in \mathcal{R}$ 的概率总和，类比离散变量的概率公式，$\text{Pr}[\mathcal{M}_E(x,u,\mathcal{R})=r] = \frac{\exp(\frac{\varepsilon u(x,r)}{2\Delta u})}{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u})}$ 。这也解释了后文指数分布证明中的概率。*）

**定义3.4（指数机制）** 指数机制 $\mathcal{M}_E(x,u,\mathcal{R})$ 选择并输出元素 $r \in \mathcal{R}$ 的概率与 $\exp\big(\frac{\varepsilon u(x,r)}{2\Delta u}\big)$ 成正比。

指数机制可以在较大的任意域上定义复杂的分布，因此当 $u$ 的范围在问题的自然参数中超多项式大时，可能无法有效地实现指数机制。

回到南瓜的例子，对数据库 $x$ 上的价格 $p$ 的效用就是当价格为 $p$ 且需求曲线如 $x$ 所示时获得的利润。重要的是，潜在价格的范围应与实际出价无关。否则，将存在一个价格，其中一个数据集中的权重为非零，而相邻集合中的权重为零，这违反了差分隐私。

**定理 3.10** 指数机制满足 $(\varepsilon,0)$ -差分隐私。

**【证明】** 为了清楚起见，我们假设指数机制的范围 $\mathcal{R}$ 是有限的，但这是不必要的。在所有的差分隐私证明中，我们考虑指数机制的一个实例,即在两个相邻的数据库 $x \in \mathbb{N}^{|\mathcal{X}|},y \in \mathbb{N}^{|\mathcal{X}|},\Vert x-y\Vert _1 \leq 1$上输出某个元素  $r \in \mathcal{R}$ 的概率之比。

$$
\begin{aligned}
    \frac{\text{Pr}[\mathcal{M}_E(x,u,\mathcal{R})=r]}{\text{Pr}[\mathcal{M}_E(y,u,\mathcal{R})=r]} &= \frac{\Big(\frac{\exp(\frac{\varepsilon u(x,r)}{2\Delta u})}{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u})}\Big)}{\Big(\frac{\exp(\frac{\varepsilon u(y,r)}{2\Delta u})}{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(y,r')}{2\Delta u})}\Big)}\\
    &= \Big(\frac{\exp(\frac{\varepsilon u(x,r)}{2\Delta u})}{\exp(\frac{\varepsilon u(y,r)}{2\Delta u})}\Big) \cdot \Big(\frac{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(y,r')}{2\Delta u})}{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u})} \Big)\\
    &= \exp\Big(\frac{\varepsilon(u(x,r')-u(y,r'))}{2\Delta u} \Big)\cdot \Big(\frac{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(y,r')}{2\Delta u})}{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u})}\Big)\\
    &\leq \exp(\frac{\varepsilon}{2})\cdot\exp(\frac{\varepsilon}{2})\cdot\Big(\frac{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u})}{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u})}\Big)\\
    &= \exp(\varepsilon)
\end{aligned}
$$

同样，对称情况也成立 $\frac{\text{Pr}[\mathcal{M}_E(y,u,\mathcal{R})=r]}{\text{Pr}[\mathcal{M}_E(x,u,\mathcal{R})=r]} \geq \exp(-\varepsilon)$

【**补充**：*原文中，上述公式个人认为有问题，证明的公式中符号有误，下面是个人更正，同时增加证明过程辅助理解。该证明需要用到上文关于指数机制隐私损失部分证明结论，其结论如下：*

$$
\begin{aligned}
\mathcal{L}_{\mathcal{M}(x)\Vert \mathcal{M}(y)}^{(\xi)} = \ln(\frac{\text{Pr}[\mathcal{M}_E(x,u,\mathcal{R})=r]}{\text{Pr}[\mathcal{M}_E(y,u,\mathcal{R})=r]}) &= \ln \Big(\frac{\exp(\varepsilon u(x,r)/\Delta 2u)}{\exp(\varepsilon u(y,r)/\Delta 2u)}\Big) \\
&=\varepsilon[u(x,r)-u(y,r)]/\Delta 2u \leq \varepsilon/2\\
\implies \exp(\varepsilon u(x,r)/\Delta 2u) &\leq e^{\varepsilon/2} \cdot \exp(\varepsilon u(y,r)/\Delta 2u)\\
\implies \sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u}) &\leq e^{\varepsilon/2} \cdot \sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(y,r')}{2\Delta u})
\end{aligned}
$$

*很自然的我们由 $\Delta u = \max_{r \in \mathcal{R}} \ \max_{x,y:\Vert x-y\Vert _1 \leq 1}|u(x,r)-u(y,r)|$ 可以推知 $u(x,r)-u(y,r) \leq \Delta u$ ，经过放缩之后得到结论。具体如下：*

$$
\begin{aligned}
    \frac{\text{Pr}[\mathcal{M}_E(x,u,\mathcal{R})=r]}{\text{Pr}[\mathcal{M}_E(y,u,\mathcal{R})=r]} &= \frac{\Big(\frac{\exp(\frac{\varepsilon u(x,r)}{2\Delta u})}{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u})}\Big)}{\Big(\frac{\exp(\frac{\varepsilon u(y,r)}{2\Delta u})}{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(y,r')}{2\Delta u})}\Big)}\\
    &= \Big(\frac{\exp(\frac{\varepsilon u(x,r)}{2\Delta u})}{\exp(\frac{\varepsilon u(y,r)}{2\Delta u})}\Big) \cdot \Big(\frac{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(y,r')}{2\Delta u})}{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u})} \Big)\\
    &= \exp\Big(\frac{\varepsilon(u(x,r)-u(y,r))}{2\Delta u} \Big)\cdot \Big(\frac{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(y,r')}{2\Delta u})}{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u})}\Big)\\
    &\leq \exp(\frac{\varepsilon}{2})\cdot\Big(\frac{\exp(\frac{\varepsilon}{2}) \cdot \sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u})}{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u})}\Big)\\
    &= \exp(\varepsilon)
\end{aligned}
$$

*此处也解释了为什么要用 $2\Delta u$ ，其目的是为了弥补归一化项对机制造成的影响，如若不使用 $2\Delta u$ ，易推知机制的隐私损失为 $2\varepsilon$*

】

指数机制通常可以提供强大的效用保证，因为随着效用得分的下降，它会指数级折减结果。对于给定的数据库 $x$ 和给定的效用函数：$u:\mathbb{N}^{|\mathcal{X}|} \times \mathcal{R} \to \mathbb{R}$ ，令 $\text{OPT}_u(x)=\max_{r \in \mathcal{R}}u(x,r)$ 表示任何元素 $r \in \mathcal{R}$ 相对于数据库 $x$ 的最大效用得分。我们将限制指数机制返回 $\mathcal{R}$ 的“良好”元素的概率，其中“良好”将根据 $\text{OPT}_u(x)$ 进行度量。这种做法的结果是，返回元素 $r$ 的效用得分不太可能低于 $\text{OPT}_u(x)$ 超过 $O(\Delta u/\varepsilon)\log|\mathcal{R}|$ 可加因子。  

**定理3.11** 固定数据库 $x$，令 $\mathcal{R}_{\text{OPT}}={r \in \mathcal{R}:u(x,r)=\text{OPT}_u(x)}$ 表示 $\mathcal{R}$ 中获得效用分数 $\text{OPT}_u(x)$ 的元素集合。则：

$$
\text{Pr}\Big[u(\mathcal{M}_E(x,u,\mathcal{R})) \leq \text{OPT}_u(x)-\frac{2\Delta u}{\varepsilon}\Big(\ln \Big(\frac{|\mathcal{R}|}{|\mathcal{R}_{\text{OPT}}|}\Big)+t\Big)\Big] \leq e^{-t}
$$

**【证明】** 

$$
\begin{aligned}
    \text{Pr}\Big[u(\mathcal{M}_E(x,u,\mathcal{R})) \leq c\Big] &\leq \frac{|\mathcal{R}|\exp(\varepsilon c / 2\Delta u)}{|\mathcal{R}_{\text{OPT}}|\exp(\varepsilon \text{OPT}_u(x)/2\Delta u)}\\
    &= \frac{|\mathcal{R}|}{|\mathcal{R}_{\text{OPT}}|}\exp\Big(\frac{\varepsilon(c-\text{OPT}_u(x))}{2\Delta u} \Big)
\end{aligned}
$$

这个不等式是由这样一个观察结果得出的：每一个 $r\in \mathcal{R},u(x,r)\leq c$ 所具有最大的未归一化概率质量为 $\exp(\varepsilon c/2\Delta u)$ $^{<1>}$，因此这类“坏”元素 $r$ 的整个集合的未归一化概率质量总和最大为 $|\mathcal{R}|\exp(\varepsilon c/2\Delta u)$ 。与此相反，我们知道至少存在 $|\mathcal{R}_{\text{OPT}}|\geq 1$ 个元素具有 $u(x,r)=\text{OPT}_u(x)$ ，并且因此未归一化概率质量为 $\exp(\varepsilon \text{OPT}_u(x)/2\Delta u)$ ，因此这是正规化项的下界。

这个定理是通过插入c的适当值得出的。  

（**注<1>**：*概率质量（probability mass）：离散随机变量在各特定取值上的概率，概率质量函数是对离散随机变量定义的，本身代表该值的概率；概率密度函数是对连续随机变量定义的，本身不是概率，只有对连续随机变量的概率密度函数在某区间内进行积分后才是概率。其定义为：假设 $X$ 是一个定义在可数样本空间 $S$ 上的离散随机变量 $S \subseteq \mathbb{R}$，则其概率质量函数 $f_{X}(x)$ 为:*

$$
f_{X}(x)={\begin{cases}\\text{Pr}(X=x),&x\in S,\\0,&x\in {\mathbb  {R}}\backslash S.\end{cases}}
$$

）

【**补充** *根据定义，每一个 $r\in \mathcal{R}$，且其效用得分是 $u(x,r)\leq c$ ，所有这些 $r$ 的未归一化概率质量最大不超过 $\exp(\varepsilon c/2\Delta u)$。那么这些 $r$ 的概率总和为：$|\mathcal{R}|\exp(\varepsilon c/2\Delta u)$。我们又知道，$\mathcal{R}_{\text{OPT}} \subseteq \mathcal{R}$，所以 $|\mathcal{R}_{\text{OPT}}|\exp(\varepsilon \text{OPT}_u(x)/2\Delta u) \leq \sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u})$。分子增大，分母减少，故下面不等式成立：*

$$
\text{Pr}\Big[u(\mathcal{M}_E(x,u,\mathcal{R})) \leq c\Big] \leq \frac{|\mathcal{R}|\exp(\varepsilon c / 2\Delta u)}{|\mathcal{R}_{\text{OPT}}|\exp(\varepsilon \text{OPT}_u(x)/2\Delta u)}
$$

*我们将不等式右边变形推导得到：*

$$
\begin{aligned}
    \text{Pr}\Big[u(\mathcal{M}_E(x,u,\mathcal{R})) \leq c\Big] &\leq \frac{|\mathcal{R}|\exp(\varepsilon c / 2\Delta u)}{|\mathcal{R}_{\text{OPT}}|\exp(\varepsilon \text{OPT}_u(x)/2\Delta u)}\\
    &= \exp\Big(\ln\big(\frac{|\mathcal{R}|}{|\mathcal{R}_{\text{OPT}}|}\big) + \frac{\varepsilon(c-\text{OPT}_u(x))}{2\Delta u} \Big)\\
\end{aligned}
$$

*令 $-t = \ln\big(\frac{|\mathcal{R}|}{|\mathcal{R}_{\text{OPT}}|}\big) + \frac{\varepsilon(c-\text{OPT}_u(x))}{2\Delta u}$ 求得 $c=\text{OPT}_u(x)-\frac{2\Delta u}{\varepsilon}\Big(\ln \Big(\frac{|\mathcal{R}|}{|\mathcal{R}_{\text{OPT}}|}\Big)+t\Big)$ 将 $c$ 带入不等式即为 **定理3.11** 所示。*

】

由于我们总是有 $|\mathcal{R}_{\text{OPT}}|\geq 1$，我们可以更普遍地使用以下简单的推论：

**推论 3.12** 定义一个数据库 $x$，我们有：

$$
\text{Pr}\Big[u(\mathcal{M}_E(x,u,\mathcal{R})) \leq \text{OPT}_u(x)-\frac{2\Delta u}{\varepsilon}(\ln (|\mathcal{R}|)+t)\Big] \leq e^{-t}
$$

从定理3.11和推论3.12的证明中可以看出，指数机制特别容易分析。  

**例3.6（二选一）** 考虑一个简单的问题，即确定 A 和 B 两种疾病中哪一种更常见。假设疾病A的真实计数为 0，疾病B的真实计数为 $c>0$。我们的效用概念将与实际计数联系起来，这样计数越大的疾病种类将具有更高的效用，且$\Delta u=1$。因此，A 的效用为 0，B 的效用为 c。使用指数机制，我们可以立即应用推论3.12，输出错误结果 A 概率至多为 $2e^{-c(\varepsilon / (2\Delta u))}=2e^{-c\varepsilon/2}$ 。

【**补充**：*此处 A 的效用为 0 ，则 $\text{Pr}\Big[u(\mathcal{M}_E(x,u,\mathcal{R}))\leq 0\Big]$ 由 **推论3.12**，令 $\text{OPT}_u(x)-\frac{2\Delta u}{\varepsilon}(\ln (|\mathcal{R}|)+t) = 0$，由于 $|\mathcal{R}|=2,\Delta u=1,\text{OPT}_u(x)=c$ 可以推得 $t = c\varepsilon/2-\ln2$，即：*

$$
\begin{aligned}
    \text{Pr}\Big[u(\mathcal{M}_E(x,u,\mathcal{R})) \leq \text{OPT}_u(x)-\frac{2}{\varepsilon}(\ln2+t)\Big] &\leq e^{-t}\\
    \text{Pr}\Big[u(\mathcal{M}_E(x,u,\mathcal{R})) \leq 0\Big] &\leq e^{-(c\varepsilon/2-\ln2)}\\
    \text{Pr}\Big[u(\mathcal{M}_E(x,u,\mathcal{R})) \leq 0\Big] &\leq 2e^{-c\varepsilon/2}\\
\end{aligned}
$$

】

分析 **Report Noisy Max** 似乎更为复杂，因为它需要了解当添加到 A 的计数中的噪声为正而添加到 B 的计数中的噪声为负时（概率为1/4）情况下会发生什么。

如果向数据集中添加元素不能导致函数值减小，则函数在数据集中是**单调**的。计数查询是单调的；通过向买家集合提供固定价格而获得的收入也是单调的。

考虑 **Report One-Sided Noisy Arg-Max** 机制，在单调效用的情况下，该机制将噪声（从参数为 $\varepsilon/\Delta u$ 的单侧指数分布中提取）添加到每个潜在输出的效用函数中；或在非单调效用的情况下，添加的噪声从参数为 $\varepsilon/2\Delta u$ 的单侧指数分布中提取，并报告最大结果。

使用该算法，其隐私证明几乎与 **Report Noisy Max** 相同（但当效用函数是非单调时造成了两倍损失），我们立即在上面的**示例3.6**中推得，选中输出疾病 A 的概率比结果 B 小，输出疾病 A 的概率等于参数为 $c(\varepsilon/\Delta u)=c\varepsilon$ 的指数分布。

**定理3.13** 当 **Report One-Sided Noisy Arg-Max** 机制使用参数 $\varepsilon/2\Delta u$ 运行时，在输出上会产生与指数机制相同的分布。