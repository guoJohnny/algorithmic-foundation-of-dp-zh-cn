# 3.4 指数机制

我们在“最常见的名称”和“最常见的疾病”例子中，提到了响应的“效用”（名称或医疗疾病），在响应中我们使用拉普拉斯噪声估计了计数，并报告了噪声最大值。在这两个示例中，响应的效用都与生成的噪声值直接相关。也就是说，我们应使用与噪声大小相同的标度和相同的单位对名称或疾病的普遍程度进行适当地测量。

指数机制是为我们希望选择“最佳”响应而设计的，但将噪声直接添加到计算量可以完全破坏其价值，例如在拍卖中设定价格，目标是使收入最大化，但在最优价格中加入少量的正噪声（为了保护出价的隐私）显著减少由此产生的收入。

**例 3.5（南瓜竞拍）** 假设我们有大量的南瓜和四个竞标者：A，F，I，K，其中A，F，I分别出价1.00美元和K出价3.01美元，最优价格是多少？在 3.01美元时，收入为 3.01美元；在 3.00美元 和 1.00美元 时候，收入为 3.00美元；但在 3.02美元时，收入为零！

指数机制是使用任意实用工具（和任意非数字范围）回答查询的自然构建块，同时保留了差异隐私。给定任意范围 $\mathcal{R}$，将指数机制定义为某些效用函数 $u:\mathbb{N}^{|\chi|} \times \mathcal{R} \to \mathbb{R}$，它将数据库输出对映射到效用分数。直观地讲，对于固定的数据库 x，用户更喜欢该机制输出 $\mathcal{R}$ 的某些元素具有最大的效用得分。请注意，当我们谈论效用分数 $u:\mathbb{N}^{|\chi|} \times \mathcal{R} \to \mathbb{R}$ 的敏感度时，我们只关心 $u$ 相对于其数据库参数的敏感性；它的 range 参数（$\mathcal{R}$）可以是任意敏感的：

$$
\Delta u = \max_{r \in \mathcal{R}} \ \max_{x,y:||x-y||_1 \leq 1}|u(x,r)-u(y,r)|
$$

指数机制输出每个可能的 $r \in \mathcal{R}$ ，其概率与 $\exp(\varepsilon u(x,r)/\Delta u)$ 成正比，因此隐私损失约为：

$$
\ln \Big(\frac{\exp(\varepsilon u(x,r)/\Delta u)}{\exp(\varepsilon u(y,r)/\Delta u)}\Big)=\varepsilon[u(x,r)-u(y,r)]/\Delta u \leq \varepsilon
$$

（*注：此处原文公式有误，翻译为更正后的公式*）

这种直观的观点忽略了归一化项的某些影响，该归一化项出现的原因是，当有额外的人出现在数据库中，导致某些元素 $r \in \mathcal{R}$ 的效用减小而其他元素的效用增大。接下来定义的实际机制将一半的隐私预算用于归一化项的更改。

**定义3.4（指数机制）** 指数机制 $\mathcal{M}_E(x,u,\mathcal{R})$ 选择并输出元素 $r \in \mathcal{R}$ 的概率与 $\exp\big(\frac{\varepsilon u(x,r)}{2\Delta u}\big)$ 成正比。

指数机制可以在较大的任意域上定义复杂的分布，因此当 $u$ 的范围在问题的自然参数中超多项式大时，可能无法有效地实现指数机制。

回到南瓜的例子，对数据库 $x$ 上的价格 $p$ 的效用就是当价格为 $p$ 且需求曲线如 $x$ 所示时获得的利润。重要的是，潜在价格的范围应与实际出价无关。否则，将存在一个价格，其中一个数据集中的权重为非零，而相邻集合中的权重为零，这违反了差分隐私。

**定理 3.10** 指数机制满足 $(\varepsilon,0)$ -差分隐私。

**【证明】** 为了清楚起见，我们假设指数机制的范围 $\mathcal{R}$ 是有限的，但这是不必要的。在所有的差分隐私证明中，我们考虑指数机制的一个实例,即在两个相邻的数据库 $x \in \mathbb{N}^{|\chi|},y \in \mathbb{N}^{|\chi|},||x-y||_1 \leq 1$上输出某个元素  $r \in \mathcal{R}$ 的概率之比。

$$
\begin{aligned}
    \frac{Pr[\mathcal{M}_E(x,u,\mathcal{R})=r]}{Pr[\mathcal{M}_E(y,u,\mathcal{R})=r]} &= \frac{\Big(\frac{\exp(\frac{\varepsilon u(x,r)}{2\Delta u})}{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u})}\Big)}{\Big(\frac{\exp(\frac{\varepsilon u(y,r)}{2\Delta u})}{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(y,r')}{2\Delta u})}\Big)}\\
    &= \Big(\frac{\exp(\frac{\varepsilon u(x,r)}{2\Delta u})}{\exp(\frac{\varepsilon u(y,r)}{2\Delta u})}\Big) \cdot \Big(\frac{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(y,r')}{2\Delta u})}{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u})} \Big)\\
    &= \exp\Big(\frac{\varepsilon(u(x,r')-u(y,r'))}{2\Delta u} \Big)\cdot \Big(\frac{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(y,r')}{2\Delta u})}{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u})}\Big)\\
    &\leq \exp(\frac{\varepsilon}{2})\cdot\exp(\frac{\varepsilon}{2})\cdot\Big(\frac{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u})}{\sum_{r'\in \mathcal{R}}\exp(\frac{\varepsilon u(x,r')}{2\Delta u})}\Big)\\
    &= \exp(\varepsilon)
\end{aligned}
$$

同样，对称情况也成立 $\frac{Pr[\mathcal{M}_E(x,u,\mathcal{R})=r]}{Pr[\mathcal{M}_E(y,u,\mathcal{R})=r]} \geq \exp(-\varepsilon)$