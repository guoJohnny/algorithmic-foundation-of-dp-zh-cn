# 2.3 形式化差分隐私（1）

**定义2.4 （差分隐私）** 对于所有的$\mathcal{S} \subseteq Range(\mathcal{M})$ 且所有的 $x,y\in \mathbb{N}^{|\mathcal{X}|}$ 有 $\Vert x-y\Vert _1 \leq 1$，如果满足下列关系：

$$
\text{Pr}[\mathcal{M}(x) \in \mathcal{S}] \leq exp(\varepsilon)\text{Pr}[\mathcal{M}(y) \in \mathcal{S}] + \delta
$$

则将这个域在 $\mathbb{N}^{|\mathcal{X}|}$ 的随机算法 $\mathcal{M}$ 称为 $(\varepsilon,\delta)$ 差分隐私(即 $(\varepsilon,\delta) \text{--} Differentially \ private$)。  

特别的，如果 $\delta=0$ ，则将 $\mathcal{M}$ 称为 $\varepsilon$ 差分隐私(即 $\varepsilon \text{--} Differentially \ private$)。

通常，我们对 $\delta$ 的值感兴趣，该值小于多项式数据库大小的倒数。 特别是，$\delta$  值接近 $1/\Vert x\Vert _1$ 是非常危险（因为在第1节中讨论“少数人”原则）：这种做法通过发布少量数据库参与者的完整记录来“保护隐私”（以获得可用性）。 

但是，即使 $\delta$ 可以忽略不计，$\varepsilon$ 和 $(\varepsilon,\delta)$-  差分隐私之间也存在理论上的区别。 其中最主要的是量化顺序的转换。 $\varepsilon$- 差分隐私可确保对于机制 $\mathcal{M}(x)$ 的每次运行，在每个相邻数据库上同时观察到的输出的可能性几乎相同。相反，从事后观察值得出结论， $(\varepsilon,\delta)$-  差分隐私对于每对相邻数据库$x, \ y$，当数据库是$x$，而不是$y$时，机制  $\mathcal{M}$ 或更大概率生成或小概率生成值 $\mathcal{M}(x)$ 。 但是，给定输出$\xi \backsim \mathcal{M}(x)$，可能会找到一个数据库$y$，使得 $\xi$ 在 $y$ 上产生的可能性比数据库为 $x$ 时的可能性大得多。 即，分布 $\mathcal{M}(y)$ 中的 $\xi$ 的质量可以实质上大于分布 $\mathcal{M}(x)$ 中的 $\xi$ 的质量。

所以，机制质量：

$$
\mathcal{L}_{\mathcal{M}(x)\Vert \mathcal{M}(y)}^{(\xi)} = \ln(\frac{\text{Pr}\lbrack \mathcal{M}(x) = \xi \rbrack}{\text{Pr}\lbrack \mathcal{M}(y) = \xi \rbrack})
$$
对我们至关重要。我们将其称为观察 $\xi$ 导致的**隐私损失**。 这种损失可能是正的（当事件在$x$之下比在$y$之下更有可能发生），也可能是负的（当事件在$y$之下比$x$之下更有可能）。正如我们将在**引理3.17**看到，$(\varepsilon,\delta)$-  差分隐私确保对于所有相邻的$x$、$y$，隐私损失的绝对值被$\varepsilon$界定的概率至少为$1-\delta$。 与往常一样，概率空间位于机制$\mathcal{M}$的硬币上。（*over the coins of machanism $\mathcal{M}$?这句话原文无法理解。*）

差分隐私不受后处理的影响：在没有其他有关私有数据库的知识的情况下，数据分析人员无法计算私有算法$\mathcal{M}$的输出函数，也无法使其差分隐私程度降低。 就是说，如果算法保护了个人的隐私，那么无论是在正式定义下，还是在任何直观的意义上，数据分析师都无法仅仅通过坐在角落里思考算法的输出来增加隐私损失。 形式上，具有（$(\varepsilon,\delta)$-  差分隐私算法$\mathcal{M}$的数据独立映射 $f$ 的合成也具有（$(\varepsilon,\delta)$-  差分隐私：

**命题2.1（后处理）** 令 $\mathcal{M}: \mathbb{N}^{|\mathcal{X}|} \to R$ 是 $(\varepsilon,\delta)$-  差分隐私随机算法。 令 $f:R \to R'$为任意随机映射。 则 $f \circ \mathcal{M}: \mathbb{N}^{|\mathcal{X}|} \to R'$ 是 $(\varepsilon,\delta)$- 差分隐私。

【证明】我们证明了一个确定性函数$f:R \to R'$的命题。结果如下，因为任何随机映射都可以分解为确定性函数的凸组合，而差分隐私机制的凸组合是差分隐私的。

设任意一对相邻数据库 $x,y$ 的 $\Vert x-y\Vert _1 \leq 1$，且任意事件 $S\subseteq R'$，设 $T = \{ r \in R: f(r) \in S \}$ ，则：

$$
\begin{aligned}
   \text{Pr}\lbrack f(\mathcal{M}(x) \in S) \rbrack &= \text{Pr}[\mathcal{M}(x) \in T]\\
   & \leq exp(\varepsilon)\text{Pr}[\mathcal{M}(y) \in T] + \delta\\
   &= exp(\varepsilon)\text{Pr}[f(\mathcal{M}(y)) \in S] + \delta
\end{aligned}
$$
即证。

从**定义2.4**可以立即得出 $(\varepsilon,0)$- 差分隐私的合成很简单：两个$(\varepsilon,0)$- 差分隐私机制的合成是 $(2\varepsilon,0)$- 差分隐私。 这个定理再进一步拓展（即定理3.16:“ $\varepsilon$ 和 $\delta$ 相加定理”)：
设有 $k$ 个差分隐私机制的合成，其中第 $i$ 个机制为 $(\varepsilon_i,\delta_i)$-  差分隐私。易知，当 $1 \leq i \leq k$时，$k$ 个差分隐私机制合成的结果是 $(\sum_{i=1}^{k}\varepsilon_i,\sum_{i=1}^{k}\delta_i)$- 差分隐私。

**群隐私**：$(\varepsilon,0)$- 差分隐私机制的群隐私也遵循从定义2.4，隐私保证的强度随群的大小线性下降。

（**个人理解**：*由定义可知，机制的叠加不能增加差分隐私的隐私保护程度，相反会以线性方式增加 $\varepsilon$，进而增大隐私泄露的可能。详细的推导证明见 [3.5节](../3-Basic-Techniques-and-Composition-Theorems/Composition-theorems/Composition-theorems.html)*
）

**定理2.2** 任意一个大小为 $k$ 的群体，这个群体的机制 $\mathcal{M}$ 是 $(\varepsilon,0)$- 差分隐私，则这个机制 $\mathcal{M}$ 会变成 $(k\varepsilon,0)$- 差分隐私。也就是说，对于所有 $\Vert x-y\Vert _1 \leq k$ 和所有 $\mathcal{S} \subseteq Range(\mathcal{M})$ 有:
$$
\text{Pr}[\mathcal{M}(x) \in \mathcal{S}] \leq exp(k\varepsilon)\text{Pr}[\mathcal{M}(y) \in \mathcal{S}] 
$$
概率空间在机制 $\mathcal{M}$ 的硬币翻转上。

例如，这解决了包括多个群体成员的调查中的隐私问题$\ ^{[1]}$。

更普遍的说，差分隐私的合成和群体隐私不是同一回事，**第3.5.2节(定理3.20)** 中改善的合成范围（实质上改善了$k$因子）不会（也不能）为群体带来相同的收益隐私，即使 $\delta=0$。

（原文注[1]：然而，随着群体的扩大，隐私保障也随之恶化，这正是我们想要的：很明显，如果我们用替换一个完全不同的调查群体，比如健康的青少年，来代替整个被调查的癌症患者群体，对于那些经常每天跑三英里的受访者，我们应该得到不同的答案。虽然与 $(\varepsilon,\delta)$ 差分隐私保密性类似，但近似项 $\delta$ 受到了很大的冲击，我们只得到大小为 $k$ 的群体是$(k\varepsilon,ke^{(k-1)\varepsilon})$-差分隐私。）

（*个人理解：多个群体共用一个隐私保护机制，那么随着群体个数的增加，这个隐私保护机制的保护能力会随之下降。上文说明了，$\varepsilon$ 会线性增加。比如，青少年、老年人、健康人、患不同疾病人等等共同使用一个差分隐私机制。显然各个群体有各个群体的特点，其结果必然会有差异，可想而知这种差异会对隐私保护机制参数造成影响。如上文所述，会呈现线性变化。*)