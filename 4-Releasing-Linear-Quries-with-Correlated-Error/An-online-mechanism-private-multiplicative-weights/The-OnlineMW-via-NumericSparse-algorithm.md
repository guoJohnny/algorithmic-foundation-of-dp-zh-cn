# 4.2.2 数值稀疏向量可乘权重算法

现在，我们可以将可乘权重更新规则与 **NumericSparse** 算法结合起来，以提供交互式查询发布机制。对于 $(\varepsilon,0)$ 隐私，我们实质上（使用一些较差的常数）恢复了 **SmallDB** 的边界 对于$(\varepsilon,\delta)$- 差分隐私，我们能够使用组合定理来获得更好的边界。 对 **NumericSparse** 的查询询问的是 $f_i(x)$ 所给出的误差大小是否在适当选择的阈值 $T$ 之上，即通过将 $f_i$ 应用于当前近似值 $x_t$ 与 $x$ 来估计 $f_i(x)$ 的误差。也就是说，这些查询询问 $|f(x)-f(x_t)|$ 的值是否大于阈值。出于技术原因（无绝对值），这是通过询问 $f(x)-f(x_t)$ 和 $f(x_t)-f(x)$ 来完成的。回想一下，**NumericSparse** 算法的响应是 $\bot$ 或某些超过 $T$ 的正值。我们将助记符 $E$ 用于响应，以强调查询正在询问错误。

**定理 4.13** 在线数值稀疏向量可乘权重算法机制 ***The Online Multiplicative Weights Mechanism (via NumericSparse)*** 是 $(\varepsilon,0)$- 差分隐私的。

![MW-NumericSparse](/4-Releasing-Linear-Quries-with-Correlated-Error/img/MW-NumericSparse.png)

**【证明】** 由 **NumericSparse** 算法的隐私分析即可证明该定理，因在线数值稀疏向量可乘权重算法机制仅通过 **NumericSparse** 算法访问数据库。

**【定理 4.13 证毕】**

大体上说，数值稀疏向量可乘权重算法的效用证明是使用 **NumericSparse** 的效用定理 [**定理 3.28**](/3-Basic-Techniques-and-Composition-Theorems/The-sparse-vector-technique/NumericSparse.html) 得出的。其结论为：仅当查询 $f_t$ 是真正有区别的查询时，可乘权重更新规则才被调用，这意味着 $|f_t(x)-f(x_t)|$ 的值是“大”的，并且发布的噪声响应是足够“精确地”近似 $f_t(x)$。有了这些假设之后，我们可以应用收敛定理（定理 4.10）来得到结论：权重更新的总次数是小的，因此算法可以回应所有 $\mathcal{Q}$ 的查询。

**定理 4.14** 对于 $\delta=0$ 且概率至少为 $1-\beta$，对于所有查询 $f_i$，数值稀疏向量可乘权重算法返回答案 $a_i$，使得 $|f_i(x)-a_i| \leq 3\alpha$ 对于任何 $\alpha$ 有：

$$
\alpha \geq \frac{32\log|\mathcal{X}|\Big(\log|\mathcal{Q}|+\log(\frac{32\log|\mathcal{X}|}{\alpha^2\beta})\Big)}{\varepsilon\alpha^2\Vert x\Vert_1}
$$

**【证明】** 略

通过优化上述表达式的 $\alpha$ 并去除归一化因子，我们发现 **数值稀疏向量可乘权重算法** 可以将每个线性查询的准确度设为 $3\alpha$，且概率为 $\beta$。有：

$$
\alpha \leq \Vert x \Vert_1^{2/3} \Bigg( \frac{36\log|\mathcal{X}|\Big(\log|\mathcal{Q}|+\log(\frac{32\log|\mathcal{X}|^{1/3}\Vert x \Vert_1^{2/3}}{\beta})\Big)}{\varepsilon}\Bigg)^{1/3}
$$

与 SmallDB 算法相当。

通过重复同样的论点，但是使用稀疏向量的 $(\varepsilon,\delta)$-差分隐私的效用定理（[**定理 3.28**](/3-Basic-Techniques-and-Composition-Theorems/The-sparse-vector-technique/NumericSparse.html) ），我们得到了以下定理：

**定理 4.15** 对于 $\delta>0$ 且概率至少为 $1-\beta$，对于所有查询 $f_i$，数值稀疏向量可乘权重算法返回答案 $a_i$ 满足 $|f_i(x)-a_i| \leq 3\alpha$，对于任何 $\alpha$ 有：

$$
\alpha \geq \frac{(2+32\sqrt{2})\sqrt{\log|\mathcal{X}|\log\frac{2}{\delta}}\Big(\log|\mathcal{Q}|+\log(\frac{32\log|\mathcal{X}|}{\alpha^2\beta})\Big)}{\varepsilon\alpha^2\Vert x\Vert_1}
$$

再次优化上述表达式的 $\alpha$ 并去除归一化因子，我们发现 **数值稀疏向量可乘权重算法** 可以将每个线性查询的准确度设为 $3\alpha$，且概率为 $\beta$。有：

$$
\alpha \leq \Vert x \Vert_1^{1/2} \Bigg( \frac{(2+32\sqrt{2})\sqrt{\log|\mathcal{X}|\log\frac{2}{\delta}}\Big(\log|\mathcal{Q}|+\log(\frac{32\Vert x \Vert_1}{\beta})\Big)}{\varepsilon}\Bigg)^{1/2}
$$

这比 **SmallDB** 算法提供了更好的精度（作为 $\Vert x \Vert_1$ 的函数）。直观地说，更高的精度来自算法的迭代性质，这允许我们利用 $(\varepsilon,\delta)$-隐私合成定理。**SmallDB** 算法只运行一次，因此没有机会利用合成定理的特点。

**数值稀疏向量可乘权重算法** 的准确性取决于几个参数，值得进一步讨论。最后，该算法使用稀疏矢量技术与线性函数的学习算法配对来回答查询。正如我们在上一节中所证明的那样，当总共进行了 $k$ 个灵敏度w为 $1/\Vert x\Vert_1$ 的查询，且这些查询中最多 $c$ 个可以具有 **“高于阈值”** 的答案。回想一下，这些误差项的出现是因为稀疏向量算法只能为 **“高于阈值”** 的查询“支付”隐私预算，因此会增加噪声 $O(c/(\varepsilon\Vert x \Vert_1))$ 到每个查询。另一方面，由于我们最终将尺度范围为 $\Omega(c/(\varepsilon \Vert x \Vert_1))$ ）的独立拉普拉斯噪声添加到总共 $k$ 个查询中，因此我们期望表示所有 $k$ 个查询的最大误差都比 $\log k$ 因子大。但是 $c$ 为多少，我们应该问什么查询呢？可乘权重学习算法为我们提供了一种查询策略，并保证了 $c=O(\log |\mathcal{X}|/\alpha^2)$ 查询对于任何 $α$ 都将高于 $T = O(\alpha)$ 的阈值（我们要求的查询始终是：“实际答案与当前可乘权重假设所预计答案有多少不同？这些问题的答案既为我们提供了查询的真实答案，又为您提供了当查询高于阈值时如何适当更新学习算法的说明。综上，这使得我们将阈值设置为 $O(\alpha)$，其中 $α$ 是满足的表达式：$\alpha=O(\log|\mathcal{X}|\log k/(\varepsilon\Vert x \Vert_1\alpha^2))$ 。这样可以最大程度地减少两种误差来源：稀疏矢量技术的误差和未能更新乘法权重假设的误差。
