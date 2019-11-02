# 2.3 形式化差分隐私_part2

从**定义2.4**可以立即得出 $(\epsilon,0)$- 差分隐私的合成很简单：$(\epsilon,0)$- 差分隐私机制是 $(2\epsilon,0)$- 差分隐私。 这个定理再进一步拓展（即定理3.16:“ $\epsilon$ 和 $\delta$ 相加定理”)：
设有 $k$ 个差分隐私机制的合成，其中第 $i$ 个机制为 $(\epsilon_i,\delta_i)$-  差分隐私。易知，当 $1 \leq i \leq k$时，$k$ 个差分隐私机制合成的结果是 $(\sum_{i=1}^{k}\epsilon_i,\sum_{i=1}^{k}\delta_i)$- 差分隐私。

**群隐私**：$(\epsilon,0)$- 差分隐私机制的组隐私也遵循从定义2.4，隐私保证的强度随群的大小线性下降。

（*个人理解：由定义可知，机制的叠加不能增加差分隐私的隐私保护程度，相反会以线性方式增加 $\epsilon$，进而增大隐私泄露的可能。下面试推导差分隐私合成增加:*

定义 $z$ 是 $x$ 的相邻数据库，定义 $y$ 是 $z$ 的相邻数据库，且有两个差分隐私机制 $\mathcal{M}_1,\mathcal{M}_2$，将这两个满足$(\epsilon,0)$- 差分隐私机制合成：

根据定义2.4可得：

$$
\begin{aligned}
Pr[\mathcal{M}_2(\mathcal{M}_1(x)) \in \mathcal{S}] &\leq exp(\epsilon)Pr[\mathcal{M}_2(\mathcal{M}_1(z)) \in \mathcal{S}] \\
&\leq \lbrack exp(\epsilon) \rbrack^2 Pr[\mathcal{M}_2(\mathcal{M}_1(y)) \in \mathcal{S}]
\end{aligned}
$$
由上可得两者合成得 $(2\epsilon,0)$- 差分隐私）

**定理2.2** 对于大小为 $k$ 的群，任何 $(\epsilon,0)$- 差分隐私机制$\mathcal{M}$ 是 $(k\epsilon,0)$- 差分隐私。也就是说，对于所有 $||x-y||_1 \leq 1$ 和所有 $\mathcal{S} \subseteq Range(\mathcal{M})$ :
$$
Pr[\mathcal{M}(x) \in \mathcal{S}] \leq exp(k\epsilon)Pr[\mathcal{M}(y) \in \mathcal{S}] 
$$
概率空间在机$\mathcal{M}$的硬币翻转上。

例如，这解决了包括多个家庭成员的调查中的隐私问题$\ ^{[1]}$。
更普遍的说，差分隐私的组成和群体隐私不是同一回事，**第3.5.2节（定理3.20）**中改善的组成范围（实质上改善了$k$因子）不会（也不能）为群体带来相同的收益隐私，即使 $\delta=0$。

（*个人理解不了，有待后期学习*)

（注：$\ ^{[1]}$然而，随着群体的扩大，隐私保障也随之恶化，这正是我们想要的：很明显，如果我们用一个完全不同的群体，比如健康的青少年，来代替整个被调查的癌症患者群体，对于那些经常每天跑三英里的受访者，我们应该得到不同的答案。虽然$(\epsilon,\delta)$ 差分隐私保密性类似，但近似项 $\delta$ 受到了很大的冲击，我们只得到 $k$ 个群的$(k\epsilon,ke^{(k-1)\epsilon})$-差分隐私。）

## 2.3.1 差分隐私的承诺

**经济观点** ：差分隐私承诺保护个人信息免受任何额外的损害，这种伤害的出现是因为他们的数据在私有数据库 $x$ 中。如果他们的数据不是 $x$ 的一部分，他们就不会遭到这些损害。尽管一旦差分隐私机制 $\mathcal{M}$ 的结果 $\mathcal{M}(x)$ 发布，个人信息确实可能会面临伤害。差异隐私承诺，他们选择参与数据发布并不会显著增加伤害的可能性。这是一个非常功利的隐私定义，因为当一个人决定是否将她的数据包含在差分隐私数据库中时，她会考虑这种差异：与没参与数据发布相比，她的个人信息在参与后遭到损害的概率。因为她无法控制数据库的其余内容，所以考虑到了差别隐私的承诺，她能确信从未来的损害来看，参与与不参与数据发布造成的影响几乎没什么差别。如果给予任何激励———从利他主义到金钱回报——差分隐私可能会说服她允许使用她的数据。这种直觉可以在效用理论的意义上被形式化，我们在这里简单地描述一下。  

考虑一个对所有可能的未来事件集合有任意偏好的个体 $i$ ，我们用 $\mathcal{A}$ 来表示。这些偏好由一个效用函数 $u_i$ 来表示 $u_i:\mathcal{A} \to \mathbb{R}_{\geqslant0}$ ，我们说个体$i$在 $a \in \mathcal{A}$ 的情况下,其效用为 $u_i(a)$。假设 $x \in \mathbb{N}^{|\chi|}$ 是一个包含个体 $i$ 的私有数据的数据集，$\mathcal{M}$ 是一个 $\epsilon$- 差分隐私算法。设$y$为与$x$ 相邻的数据集，它不包括个体 $i$ 的数据（$||x-y||_1 \leq 1$）。并设 $f:Range(\mathcal{M} ) \to \Delta(\mathcal{A})$ 为（任意）函数，该函数决定未来事件 $\mathcal{A}$ 的分布，以机制M的输出为条件（*注：此处$\Delta(\mathcal{A})$函数为定义2.1（概率单纯形）函数*）。通过差分隐私的保证以及命题2.1保证的任意后处理的弹性，我们可以有：
$$
\begin{aligned}
    \mathbb{E}_{a \backsim f(\mathcal{M}(x))}[u_i(a)] &= \sum_{a \in \mathcal{A}}u_i(a) \cdotp \underset{f(\mathcal{M}(x))}{Pr}[a] \\
    &\leq \sum_{a \in \mathcal{A}} u_i(a) \cdotp exp(\epsilon) \underset{f(\mathcal{M}(y))}{Pr}[a] \\
    &= exp(\epsilon)\mathbb{E}_{a \backsim f(\mathcal{M}(y))}[u_i(a)]
\end{aligned}
$$
同理，
$$
\mathbb{E}_{a \backsim f(\mathcal{M}(x))}[u_i(a)] \geqslant exp(-\epsilon)\mathbb{E}_{a \backsim f(\mathcal{M}(y))}[u_i(a)]
$$

因此，通过保证 $\epsilon$- 差分隐私，数据分析师可以向个人保证，其预期的未来效用不会受到超过 $exp(\epsilon) \approx (1+\epsilon)$ 因子的损害。（*注：由 $e^x$ 的泰勒展开得到的近似值*）注意，这个承诺独立于个人的是效用函数 $u_i(a)$，同时适用于可能具有完全不同效用函数的多个人。