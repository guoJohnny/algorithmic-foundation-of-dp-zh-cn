# 3.5 合成定理

既然我们已经有了几个用于设计差分隐私算法的模块，那么了解如何将它们结合起来设计更复杂的算法就变得非常重要。为了使用这些工具，我们希望两个差分隐私算法的组合本身是差分隐私的。事实上，两个差分隐私算法的组合确实是差分隐私的。当然，参数 $\varepsilon$ 和 $\delta$ 必然会降级的——考虑使用拉普拉斯机制重复计算相同的统计，每次都是ε-差分隐私。每一个机制实例给出的答案的平均值最终会收敛到统计的真实值，因此我们不能避免我们的隐私保护强度会随着重复使用而降低。在这一节中，我们给出了一些定理，说明当组合差分隐私子程序时，参数 $\varepsilon$ 和 $\delta$ 是如何精确组合的。

让我们先从一个简单的预热开始：我们将看到独立的 $(\varepsilon_1,0)$ -差分隐私算法和（$(\varepsilon_2,0)$ -差分隐私算法使用在一起是 $(\varepsilon_1 + \varepsilon_2,0)$ -差分隐私算法。

**定理 3.14** 设 $\mathcal{M}_1:\mathbb{N}^{|\mathcal{X}|}\to \mathcal{R}_1$ 为 $\varepsilon_1$ -差分隐私算法，设 $\mathcal{M}_2:\mathbb{N}^{|\mathcal{X}|}\to \mathcal{R}_2$ 为 $\varepsilon_2$ -差分隐私算法。然后将它们的组合，定义为$\mathcal{M}_{1,2}:\mathbb{N}^{|\mathcal{X}|}\to \mathcal{R}_1 \times \mathcal{R}_2$ ，映射为： $\mathcal{M}_{1,2}(x) = (\mathcal{M}_{1}(x),\mathcal{M}_{2}(x))$ 是 $(\varepsilon_1 + \varepsilon_2)$ -差分隐私算法。

**【证明】** 令 $x,y \in \mathbb{N}^{|\mathcal{X}|}$ 满足 $\Vert x-y\Vert _1 \leq 1$，任意 $(r_1,r_2) \in \mathcal{R}_1 \times \mathcal{R}_2$，则：

$$
\begin{aligned}
    \frac{\text{Pr}[\mathcal{M}_{1,2}(x)=(r_1,r_2)]}{\text{Pr}[\mathcal{M}_{1,2}(y)=(r_1,r_2)]} &= \frac{\text{Pr}[\mathcal{M}_{1}(x)=r_1]\text{Pr}[\mathcal{M}_{2}(x)=r_2]}{\text{Pr}[\mathcal{M}_{1}(y)=r_1]\text{Pr}[\mathcal{M}_{2}(x)=r_2]}\\
    &= \Big(\frac{\text{Pr}[\mathcal{M}_{1}(x)=r_1]}{\text{Pr}[\mathcal{M}_{1}(y)=r_1]}\Big)\Big(\frac{\text{Pr}[\mathcal{M}_{2}(x)=r_2]}{\text{Pr}[\mathcal{M}_{2}(x)=r_2]}\Big)\\
    &\leq \exp(\varepsilon_1)\exp(\varepsilon_2)\\
    &= \exp(\varepsilon_1+\varepsilon_2)
\end{aligned}
$$

由对称性，$\frac{\text{Pr}[\mathcal{M}_{1,2}(y)=(r_1,r_2)]}{\text{Pr}[\mathcal{M}_{1,2}(x)=(r_1,r_2)]} \geq \exp(-(\varepsilon_1+\varepsilon_2))$ 也成立。

**【定理 3.14 证毕】**

组合定理能反复应用以获得以下推论：

**推论 3.16** 令 $\mathcal{M}_i:\mathbb{N}^{|\mathcal{X}|}\to \mathcal{R}_i$ 是 $(\varepsilon_i,0)$- 差分隐私算法（$i \in [k]$）。如果将 $\mathcal{M}_{[k]}:\mathbb{N}^{|\mathcal{X}|}\to \prod_{i=1}^{k}\mathcal{R}_i$ 定义为 ：$(\mathcal{M}_{1}(x),...,\mathcal{M}_{k}(x))$，则 $\mathcal{M}_{[k]}$ 是 $(\sum_{i=1}^{k}\varepsilon_i,0)$- 差分隐私。

该定理推广到 $(\varepsilon,\delta)$-差分隐私的证明见附录B：

**定理 3.16** 令 $\mathcal{M}_i:\mathbb{N}^{|\mathcal{X}|}\to \mathcal{R}_i$ 是 $(\varepsilon_i,\delta_i)$- 差分隐私算法（$i \in [k]$）。如果将 $\mathcal{M}_{[k]}:\mathbb{N}^{|\mathcal{X}|}\to \prod_{i=1}^{k}\mathcal{R}_i$ 定义为 ：$(\mathcal{M}_{1}(x),...,\mathcal{M}_{k}(x))$，则 $\mathcal{M}_{[k]}$ 是 $(\sum_{i=1}^{k}\varepsilon_i,\sum_{i=1}^{k}\delta_i)$- 差分隐私。

差异隐私的一个优点：其合成是“自动”的，因为获得的限制是保持不变，无需数据提供者对其做任何修改。