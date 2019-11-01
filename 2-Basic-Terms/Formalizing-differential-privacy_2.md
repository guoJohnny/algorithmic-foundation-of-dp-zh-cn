# 2.3 形式化差分隐私_part2

从**定义2.4**可以立即得出 $(\epsilon,0)$- 差分隐私的构成很简单：$(\epsilon,0)$- 差分隐私机制是 $(2\epsilon,0)$- 差分隐私。 这个定理再进一步拓展（即定理3.16:“ $\epsilon$ 和 $\delta$ 相加定理”)：
设有 $k$ 个差分隐私机制的合成，其中第 $i$ 个机制为 $(\epsilon_i,\delta_i)$-  差分隐私。易知，当 $1 \leq i \leq k$时，$k$ 个差分隐私机制合成的结果是 $(\sum_{i=1}^{k}\epsilon_i,\sum_{i=1}^{k}\delta_i)$- 差分隐私。

**组隐私**：$(\epsilon,\delta)$- 差分隐私机制的组隐私也遵循从定义2.4，隐私保证的强度随组的大小线性下降。

（*个人理解：由定义可知，机制的叠加不能增加差分隐私的隐私保护成都，相反会以线性方式增加 $\epsilon$，进而增大隐私泄露的可能。下面试推导差分隐私合成增加:*

定义 $z$ 是 $x$ 的相邻数据库，定义 $y$ 是 $z$ 的相邻数据库，且有两个差分隐私机制 $\mathcal{M}_1,\mathcal{M}_2$，将这两个满足$(\epsilon,0)$- 差分隐私机制合成：

根据定义2.4可得：

$$
\begin{aligned}
Pr[\mathcal{M}_2(\mathcal{M}_1(x)) \in \mathcal{S}] &\leq exp(\epsilon)Pr[\mathcal{M}_2(\mathcal{M}_1(z)) \in \mathcal{S}] \\
&\leq \lbrack exp(\epsilon) \rbrack^2 Pr[\mathcal{M}_2(\mathcal{M}_1(y)) \in \mathcal{S}]
\end{aligned}
$$
由上可得两者合成得 $(2\epsilon,0)$- 差分隐私
）