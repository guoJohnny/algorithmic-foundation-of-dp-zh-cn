# 3.3 Laplace 机制

数值查询是数据库最基础的数据查询类型，将其定义为：$f:\mathbb{N}^{|\chi|} \to \mathbb{R}^k$。这个查询将数据库映射成为k个真实值。将查询的$\ell_1$敏感度作为衡量我们对查询回答的准确程度的参数之一。

**定义3.1 $(\ell_1$敏感度)** 方法 $f:\mathbb{N}^{|\chi|} \to \mathbb{R}^k$ 的 $\ell_1$敏感度为：
$$
\Delta f = \max_{x,y\in\mathbb{N}^{|\chi|},||x-y||_1=1}||f(x)-f(y)||_1
$$

函数 $f$ 的 $\ell_1$ 敏感度反映了单体的数据在最坏情况下可以改变函数 $f$ 的程度，因此，直观地讲，为了隐藏单个人的参与，我们必须引入响应的不确定性。确实，我们将这种动机形式化：函数的敏感性为我们对输出施加多少扰动以保护隐私提供了一个上界。自然而然地，一种噪声分布可带来差分隐私。

**定义3.2（拉普拉斯分布）**  以0为中心，以 $b$ 为尺度的拉普拉斯分布，其概率密度函数的分布为：

$$
Lap(x|b) = \frac{1}{2b}exp(-\frac{|x|}{b})
$$

这个分布的方差是 $\sigma^2=2b^2$ 。我们有时会写 $Lap(b)$ 来表示带尺度为 $b$ 的Laplace分布，有时会滥用符号，写 $Lap(b)$ 来表示随机变量 $X \backsim Lap(b)$。

拉普拉斯分布是指数分布的对称版本。

我们现在定义拉普拉斯机制。顾名思义，拉普拉斯机制将简单地计算 $f$，并用拉普拉斯分布的噪声扰动每个映射 $f$ 的输出结果(*注：此处为个人理解补充进翻译中，原文省略了指代与解释。*)。噪声的尺度将校准为 $f$ 的敏感度（除以 $\varepsilon$）$\ ^{[1]}$

（注[1]: 或者，使用方差校准为 $\Delta fln(1/\delta)/\varepsilon$ 的高斯噪声，可以实现 $(\varepsilon,\delta)$- 差分隐私（请参阅附录A）。拉普拉斯机制的使用更为简洁，两种机制在合成下的行为类似（定理3.20））

**定义3.3 （拉普拉斯机制）**  给定任意方法 $f:\mathbb{N}^{|\chi|} \to \mathbb{R}^k$， 拉普拉斯机制定义为如下形式：
$$
\mathcal{M}_L(x,f(\cdot),\varepsilon)=f(x) + (Y_1,\dots,Y_k)
$$ 
此处的 $Y_i$ 是从 $Lap(\Delta f/\varepsilon)$ 中提取的独立同分布随机变量。

**定理 3.6**  拉普拉斯机制是 $(\varepsilon,0)$-差分隐私。

**【证明】**：设 $x \in \mathbb{N}^{|\chi|},y \in \mathbb{N}^{|\chi|}$，同时满足 $||x-y||_1 \leq 1$ （即两者为相邻数据集）。并设 $f(\cdot)$ 是函数 $f:\mathbb{N}^{|\chi|} \to \mathbb{R}^k$。用 $p_x$ 表示概率密度函数 $\mathcal{M}_L(x,f,\varepsilon)$, $p_y$ 表示概率密度函数 $\mathcal{M}_L(y,f,\varepsilon)$。我们用任意点 $z$ 比较这两者的概率密度：

$$
\begin{aligned}
    \frac{p_x(z)}{p_y(z)} &= \prod_{i=1}^{k}\Bigg(\frac{exp(-\frac{\varepsilon|f(x)_i-z_i|}{\Delta f})}{exp(-\frac{\varepsilon|f(y)_i-z_i|}{\Delta f})} \Bigg)\\
    &= \prod_{i=1}^{k}exp\Bigg( \frac{\varepsilon(|f(y)_i-z_i|-|f(x)_i-z_i|)}{\Delta f} \Bigg)\\
    &\leq \prod_{i=1}^{k}exp\Bigg(\frac{\varepsilon|f(x)_i-f(y)_i|}{\Delta f} \Bigg)\\
    &= exp\Bigg(\frac{\varepsilon||f(x)-f(y)||_1}{\Delta f} \Bigg)\\
    &\leq exp(\varepsilon)
\end{aligned}
$$

第一个不等式由三角不等式推导得来，最后一个不等式是由敏感度定义得到，即：$||x-y||_1 \leq 1$。且由对称性可得 $\frac{p_x(z)}{p_y(z)} \geq exp(-\varepsilon)$。

【补充1: $\frac{p_x(z)}{p_y(z)} = \prod_{i=1}^{k}\Bigg(\frac{exp(-\frac{\varepsilon|f(x)_i-z_i|}{\Delta f})}{exp(-\frac{\varepsilon|f(y)_i-z_i|}{\Delta f})} \Bigg)$ 表示形式是拉普拉斯分布的分量形式，即：$p_x(z)= \frac{\varepsilon}{2\Delta f}\prod_{i=1}^{k}exp\Big(\frac{\varepsilon(|f(y)_i-z_i|-|f(x)_i-z_i|)}{\Delta f}\Big)$ 

亦即：$p_x(\overrightarrow{z})= \frac{\varepsilon}{2\Delta f}exp\Big(\frac{\varepsilon(|f(y)-\overrightarrow{z}|-|f(x)-\overrightarrow{z}|)}{\Delta f}\Big)$ 】

【补充2：由于 **定义 2.3 (数据库之间距离)** 定义了数据库 $x$ 和 $y$ 之间的 $\ell_1$ 距离为 $||x-y||_1$

$$
||x-y||_1 = \sum_{i=1}^{|\chi|}|x_i-y_i|
$$
故：上述证明中的 $\prod_{i=1}^{k}exp\Bigg(\frac{\varepsilon|f(x)_i-f(y)_i|}{\Delta f} \Bigg)=exp\Bigg(\frac{\varepsilon||f(x)-f(y)||_1}{\Delta f} \Bigg)$ 可由如下步骤得到：
$$
\begin{aligned}
    \prod_{i=1}^{k}exp\Bigg(\frac{\varepsilon|f(x)_i-f(y)_i|}{\Delta f} \Bigg) &= exp\Bigg(\frac{\varepsilon\sum_{i=1}^{k}|f(x)_i-f(y)_i|}{\Delta f} \Bigg)\\
    &= exp\Bigg(\frac{\varepsilon||f(x)-f(y)||_1}{\Delta f} \Bigg)
\end{aligned}
$$
】

**例3.1 计数查询**：计数查询是“数据库中有多少个元素满足属性 P？”形式的查询。我们将一次又一次地回到这些查询，有时是纯形式，有时使用小数形式返回这些查询（“数据库中元素的分数是多少....？”），有时带有权重（线性查询），有时带有稍微复杂的形式。（例如，对数据库中的每个元素应用 $h:\mathbb{N}^{|\chi| \to [0,1]}$ 并求和）。计数是一个非常强大的原语。它占据了统计查询学习模型中所有可学习的内容，以及许多标准的数据挖掘任务和基本统计​​信息。由于计数查询的敏感度为1（单个人的添加或删除最多可以将计数更改为1），因此 **定理3.6** 的直接结果是，可以实现 $(\varepsilon,0)$-差分隐私 进行计数通过添加尺度参数为 $1/\varepsilon$ 的噪声进行查询，即通过添加从 $Lap(1/\varepsilon)$ 分布提取的噪声进行查询。预期的失真或错误为 $1/\varepsilon$，与数据库的大小无关。

固定但任意数量的 $m$ 个计数查询列表可以视为向量值查询。缺少有关查询集的任何进一步信息时，此矢量值查询的敏感性的最坏情况范围是 $m$，因为单个个体可能会更改每个计数。在这种情况下，可以通过将尺度参数为 $m/\varepsilon$ 的噪声添加到每个查询的真实答案中来实现 $(\varepsilon,0)$-差分隐私。

有时我们将响应大量（可能是任意的）查询的问题称为查询发布问题。