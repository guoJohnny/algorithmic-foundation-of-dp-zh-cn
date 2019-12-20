# 3.3 Laplace 机制

数值查询是数据库最基础的数据查询类型，将其定义为：$f:\mathbb{N}^{|\mathcal{X}|} \to \mathbb{R}^k$。这个查询将数据库映射成为k个真实值。将查询的$\ell_1$敏感度作为衡量我们对查询回答的准确程度的参数之一。

**定义3.1 $(\ell_1$敏感度)** 方法 $f:\mathbb{N}^{|\mathcal{X}|} \to \mathbb{R}^k$ 的 $\ell_1$敏感度为：
$$
\Delta f = \max_{x,y\in\mathbb{N}^{|\mathcal{X}|},\Vert x-y\Vert _1=1}\Vert f(x)-f(y)\Vert _1
$$

函数 $f$ 的 $\ell_1$ 敏感度反映了单体的数据在最坏情况下可以改变函数 $f$ 的程度，因此，直观地讲，为了隐藏单个人的参与，我们必须引入响应的不确定性。确实，我们将这种动机形式化：函数的敏感性为我们对输出施加多少扰动以保护隐私提供了一个上界。自然而然地，一种噪声分布可带来差分隐私。

**定义3.2（拉普拉斯分布）**  以0为中心，以 $b$ 为尺度的拉普拉斯分布，其概率密度函数的分布为：

$$
Lap(x|b) = \frac{1}{2b}\exp(-\frac{|x|}{b})
$$

这个分布的方差是 $\sigma^2=2b^2$ 。我们有时会写 $Lap(b)$ 来表示带尺度为 $b$ 的Laplace分布，有时会滥用符号，写 $Lap(b)$ 来表示随机变量 $X \backsim Lap(b)$。

拉普拉斯分布是指数分布的对称版本。

我们现在定义拉普拉斯机制。顾名思义，拉普拉斯机制将简单地计算 $f$，并用拉普拉斯分布的噪声扰动每个映射 $f$ 的输出结果(*注：此处为个人理解补充进翻译中，原文省略了指代与解释。*)。噪声的尺度将校准为 $f$ 的敏感度（除以 $\varepsilon$）$\ ^{[1]}$

（原书注[1]: 或者，使用方差校准为 $\Delta fln(1/\delta)/\varepsilon$ 的高斯噪声，可以实现 $(\varepsilon,\delta)$- 差分隐私（请参阅附录A）。拉普拉斯机制的使用更为简洁，两种机制在合成下的行为类似（定理3.20））

**定义3.3 （拉普拉斯机制）**  给定任意方法 $f:\mathbb{N}^{|\mathcal{X}|} \to \mathbb{R}^k$， 拉普拉斯机制定义为如下形式：
$$
\mathcal{M}_L(x,f(\cdot),\varepsilon)=f(x) + (Y_1,\dots,Y_k)
$$ 
此处的 $Y_i$ 是从 $Lap(\Delta f/\varepsilon)$ 中提取的独立同分布随机变量。

**定理 3.6**  拉普拉斯机制是 $(\varepsilon,0)$-差分隐私。

**【证明】**：设 $x \in \mathbb{N}^{|\mathcal{X}|},y \in \mathbb{N}^{|\mathcal{X}|}$，同时满足 $\Vert x-y\Vert _1 \leq 1$ （即两者为相邻数据集）。并设 $f(\cdot)$ 是函数 $f:\mathbb{N}^{|\mathcal{X}|} \to \mathbb{R}^k$。用 $p_x$ 表示概率密度函数 $\mathcal{M}_L(x,f,\varepsilon)$, $p_y$ 表示概率密度函数 $\mathcal{M}_L(y,f,\varepsilon)$。我们用任意点 $z$ 比较这两者的概率密度：

$$
\begin{aligned}
    \frac{p_x(z)}{p_y(z)} &= \prod_{i=1}^{k}\Bigg(\frac{\exp(-\frac{\varepsilon|f(x)_i-z_i|}{\Delta f})}{\exp(-\frac{\varepsilon|f(y)_i-z_i|}{\Delta f})} \Bigg)\\
    &= \prod_{i=1}^{k}\exp\Bigg( \frac{\varepsilon(|f(y)_i-z_i|-|f(x)_i-z_i|)}{\Delta f} \Bigg)\\
    &\leq \prod_{i=1}^{k}\exp\Bigg(\frac{\varepsilon|f(x)_i-f(y)_i|}{\Delta f} \Bigg)\\
    &= \exp\Bigg(\frac{\varepsilon\Vert f(x)-f(y)\Vert _1}{\Delta f} \Bigg)\\
    &\leq \exp(\varepsilon)
\end{aligned}
$$

第一个不等式由三角不等式推导得来，最后一个不等式是由敏感度定义得到，即：$\Vert x-y\Vert _1 \leq 1$。且由对称性可得 $\frac{p_x(z)}{p_y(z)} \geq \exp(-\varepsilon)$。

**【定理 3.6 证毕】**

【**补充1:** *由 Laplace机制的定义:*

$$
\mathcal{M}_L(x,f(\cdot),\varepsilon)=f(x) + (Y_1,\dots,Y_k)
$$ 

*为直观表示，使用随机变量的分量形式。即：$\overrightarrow{Y}=(Y_1,\dots,Y_k)$，$f:\mathbb{N}^{|\mathcal{X}|} \to \mathbb{R}^k=\overrightarrow{f(x)}=(f(x)_1,...,f(x)_k)$。 所以，根据定理 3.6中的条件：*

$$
\begin{aligned}
 p_x(\overrightarrow{z}) &=\text{Pr}[\mathcal{M}_L(x,f(\cdot),\varepsilon)=\overrightarrow{z}]\\
 &= \text{Pr}[\overrightarrow{f(x)} + \overrightarrow{Y} =\overrightarrow{z}]\\
 &=\text{Pr}[\overrightarrow{Y}=\overrightarrow{z}-\overrightarrow{f(x)}]\\
 &= \frac{\varepsilon}{2\Delta f}\exp\Big(-\frac{\varepsilon|\overrightarrow{f(x)}-\overrightarrow{z}|}{\Delta f}\Big)\\
 &= \frac{\varepsilon}{2\Delta f}\prod_{i=1}^{k}\exp\Big(-\frac{\varepsilon|f(x)_i-z_i|}{\Delta f}\Big)
\end{aligned}
$$

$\frac{p_x(z)}{p_y(z)} = \prod_{i=1}^{k}\Big(\frac{\exp(-\frac{\varepsilon|f(x)_i-z_i|}{\Delta f})}{\exp(-\frac{\varepsilon|f(y)_i-z_i|}{\Delta f})} \Big)$ *表示形式就是上式拉普拉斯分布的分量形式，即*：$p_x(z)= \frac{\varepsilon}{2\Delta f}\prod_{i=1}^{k}\exp\Big(-\frac{\varepsilon|f(x)_i-z_i|}{\Delta f}\Big)$ 


【**补充2**：*由于 **定义 2.3 (数据库之间距离)** 定义了数据库 $x$ 和 $y$ 之间的 $\ell_1$ 距离为 $\Vert x-y\Vert _1$*

$$
\Vert x-y\Vert _1 = \sum_{i=1}^{|\mathcal{X}|}|x_i-y_i|
$$

*故：上述证明中的 $\prod_{i=1}^{k}\exp\Big(\frac{\varepsilon|f(x)_i-f(y)_i|}{\Delta f} \Big)=\exp\Big(\frac{\varepsilon\Vert f(x)-f(y)\Vert _1}{\Delta f} \Big)$ 可由如下步骤得到：*

$$
\begin{aligned}
    \prod_{i=1}^{k}\exp\Bigg(\frac{\varepsilon|f(x)_i-f(y)_i|}{\Delta f} \Bigg) &= \exp\Bigg(\frac{\varepsilon\sum_{i=1}^{k}|f(x)_i-f(y)_i|}{\Delta f} \Bigg)\\
    &= \exp\Bigg(\frac{\varepsilon\Vert f(x)-f(y)\Vert _1}{\Delta f} \Bigg)
\end{aligned}
$$
】

**例3.1 计数查询**：计数查询是“数据库中有多少个元素满足属性 P？”形式的查询。我们将一次又一次地回到这些查询，有时是纯形式，有时使用小数形式返回这些查询（“数据库中某元素的占比是多少....？”），有时带有权重（线性查询），有时带有稍微复杂的形式。（例如，对数据库中的每个元素应用 $h:\mathbb{N}^{|\mathcal{X}|} \to [0,1]$ 并求和）。计数是一个非常强大的原语。它占据了统计查询学习模型中所有可学习的内容，以及许多标准的数据挖掘任务和基本统计​​信息。由于计数查询的敏感度为1（单个人的添加或删除最多可以影响 1 个计数），因此 **定理3.6** 的直接结果是，可以实现 $(\varepsilon,0)$-差分隐私 计数通过添加尺度参数为 $1/\varepsilon$ 的噪声进行查询，即通过添加从 $Lap(1/\varepsilon)$ 分布提取的噪声进行查询。预期的失真或错误为 $1/\varepsilon$，与数据库的大小无关。

固定但任意数量的 $m$ 个计数查询列表可以视为向量值查询。缺少有关查询集的任何进一步信息时，此矢量值查询的敏感性的最坏情况范围是 $m$，因为单个个体可能会更改每个计数（敏感度为 $m$）。在这种情况下，可以通过将尺度参数为 $m/\varepsilon$ 的噪声添加到每个查询的真实答案中来实现 $(\varepsilon,0)$-差分隐私。

有时我们将响应大量（可能是任意的）查询的问题称为查询发布问题。

**例3.2 直方图查询**：在查询在结构上不相交的特殊（但很常见）情况下，我们可以做得更好——我们不必让噪声随查询的数量而变化。直方图查询就是一个例子。在这种类型的查询中，数据整体（ $\mathbb{N}^{|\mathcal{X}|}$ ）被划分为多个单元格，查询每个单元格中有多少数据库元素。由于单元格是不相交的，单个数据库元素的添加或删除会影响一个单元格中的计数，并且与该单元格的差异是 1，因此直方图查询的敏感度为1，可以对每个单元格中的真实计数增加源自 $Lap(1/\varepsilon)$ 分布的噪声来回答查询。

为了了解一般查询的 Laplace 机制的准确性，我们使用以下有用的事实：

**事实 3.7**： 如果 $Y \backsim Lap(b)$，则：

$$
\text{Pr}[|Y| \geq t \cdot b] = \exp(-t)
$$

这个事实与布尔不等式（译者注：Union Bound，又称 Boole’s Inequality$^{<1>}$）一起为我们提供了一个
关于拉普拉斯机制准确性的简单不等式：  

**定理 3.8** ：设 $f:\mathbb{N}^{|\mathcal{X}|} \to \mathbb{R}^k,y=\mathcal{M}_L(x,f(\cdot),\varepsilon)$。则 $\forall\delta \in (0,1]$：
$$
\text{Pr}\Big[\Vert f(x)-y\Vert _\infty \geq \ln(\frac{k}{\delta})\cdot(\frac{\Delta f}{\varepsilon}) \Big] \leq \delta
$$

**【证明】** 我们有：

$$
\begin{aligned}
   \text{Pr}\Big[\Vert f(x)-y\Vert _\infty \geq \ln(\frac{k}{\delta})\cdot(\frac{\Delta f}{\varepsilon})\Big] &= \text{Pr}\Big[\max_{i \in [k]}|Y_i|\geq \ln(\frac{k}{\delta})\cdot(\frac{\Delta f}{\varepsilon}) \Big]\\
  & \leq k\cdot \text{Pr}\Big[|Y_i|\geq \ln(\frac{k}{\delta})\cdot(\frac{\Delta f}{\varepsilon}) \Big] \\
  &= k\cdot(\frac{\delta}{k})\\
  &= \delta
\end{aligned}
$$

在证明中，第二个和最后的不等式是从拉普拉斯分布和**事实3.7**中推导得到的。

（**译者注<1> 布尔不等式**：指对于全部事件的概率不大于单个事件的概率总和，对于事件 $A_1,A_2,A_3...: P(\bigcup_{i}A_i)\leq \sum_iP(A_i)$）

【**补充3：** *上一证明过程缺少 $\ell_\infty$ 范数距离，又称**切比雪夫距离**，如下定义：$\Vert x\Vert $为$x$向量各个元素绝对值最大那个元素的绝对值，形式化为：*

$$
\Vert x\Vert _{\infty}=\lim\limits_{k \to \infty}\Big(\sum_{i=1}^n|p_i-q_i|^k \Big)^{1/k}=\max_{i \in [k]}|p_i-q_i|
$$

】

【**补充4: （定理3.8补充证明）** *由 Laplace 机制可知 $Y_i \backsim Lap(\Delta f/\varepsilon)$ 和 $y=\mathcal{M}_L(x,f(\cdot\varepsilon)=f(x) + (Y_1,\dots,Y_k)$，则: $|f(x) - y|= |(Y_1,...Y_k)|$。*

*又因切比雪夫距离定义：*

$\Vert f(x)-y\Vert _\infty=max_{i \in k}|f(x)-y|=max_{i \in k}|Y_i|$，

*故证明的第一步可以由此推导出：*

$\text{Pr}\Big[\Vert f(x)-y\Vert _\infty \geq \ln(\frac{k}{\delta})\cdot(\frac{\Delta f}{\varepsilon})\Big] = \text{Pr}\Big[\max_{i \in [k]}|Y_i|\geq \ln(\frac{k}{\delta})\cdot(\frac{\Delta f}{\varepsilon}) \Big]$

*证明第二步是因为 $\max_{i \in [k]}|Y_i| \geq \ln(\frac{k}{\delta})\cdot(\frac{\Delta f}{\varepsilon})$ 的概率必然小于等于 $\bigcup_{i} \{|Y_i| \geq \ln(\frac{k}{\delta})\cdot(\frac{\Delta f}{\varepsilon})\}$ 全体的概率，且由布尔不等式推导而来，即最大值 $Y_i$ 概率不大于单个事件的概率总和。又因为 **事实3.7**，推导如下：*

$$
\begin{aligned}
  \text{Pr}\Big[\max_{i \in [k]}|Y_i|\geq \ln(\frac{k}{\delta})\cdot(\frac{\Delta f}{\varepsilon})\Big] & \leq \text{Pr}\Big[ \bigcup_{i} \{|Y_i| \geq \ln(\frac{k}{\delta})\cdot(\frac{\Delta f}{\varepsilon}) \}\Big]\\
  &\leq \sum_i^k \cdot \text{Pr}\Big[|Y_i| \geq \ln(\frac{k}{\delta})\cdot(\frac{\Delta f}{\varepsilon})\Big]\\
  &= \sum_i^k \cdot \exp\big(-ln(\frac{k}{\delta})\big)\\
  &= k\cdot(\frac{\delta}{k})\\
  &= \delta
\end{aligned} 
$$

】

**例3.3 名字频度**： 假设我们要使用 2010 年人口普查参与者数据，并从数据中统计出给定的 10,000 个名字里各个名字的频度。 这个问题可以用查询 $f:\mathbb{N}^{|\mathcal{X}|} \to \mathbb{R}^{10000}$ 表示。 这是一个直方图查询，因此灵敏度$\Delta f = 1$ ，因为每个人最多只能有一个名字。当频度查询是 $(1,0)$- 差分隐私的，并且概率要为 95％ ，我们使用上面的定理可以计算所有10,000名字的频度，其估计的相加误差不会超过 $\ln (10000/0.05) \thickapprox 12.2$。 对于一个人口超过 300,000,000 的国家来说，这是非常低的错误！

【**补充5**: *由例3.3可知：$k=10000,\Delta f = 1,\varepsilon=1,\delta = 1 - 0.95 = 0.05$，并由定理3.8可以推得上述结论：*

$$
\begin{aligned}
  \text{Pr}\Big[\max_{i \in [10000]}|Y_i|\geq \ln(\frac{10000}{0.05})\cdot(\frac{1}{1})\Big] &\leq 0.05\\
  then \ \ \   \text{Pr}\Big[\max_{i \in [10000]}|Y_i| \leq \ln(\frac{10000}{0.05})\cdot(\frac{1}{1})\Big] &\geq 1 - 0.05\\
  \text{Pr}\Big[\max_{i \in [10000]}|Y_i| \leq \ln(\frac{10000}{0.05})\Big] &\geq 0.95
\end{aligned}
$$

】

**差分隐私选择** 例3.3中的任务是一个差分隐私选择：输出空间是离散的，任务是产生一个“最佳”答案。在例3.3中是选择输出是常用名频度最多的直方图单元。

**例3.4 最常见的医学疾病** 假设我们希望知道哪一个疾病是在一组被调查者的医疗史中最常见的，因此，需要对这些调查者进行一系列调查，调查其个人是否曾经接受过这些疾病的诊断。由于个人可能得过许多疾病，所以这些调查的敏感性可能很高。尽管如此，正如我们接下来描述的，这个任务可以通过在每个计数中添加 $Lap(1/\varepsilon)$ 噪声来解决（注意噪声的小范围，它独立于疾病的总数）。关键是 $m$ 个噪音计数本身不会被发布（尽管“获胜”计数可以释放，没有额外的隐私损失）。（*个人理解：m 个噪音计数即存在 m 种常见疾病，需要对 m 个常见疾病的统计计数增加噪声，并返回增加完噪声之后的最大值，即最常见的疾病。原文中的“获胜”应该指的是增加噪声最后的最大值。因为增加噪声之前与之后的最大值可能不一致。*）

**Report Noisy Max** 请考虑以下简单算法，目的是为了确定在 m 个计数查询中哪个具有最高数值：将独立生成的拉普拉斯噪声 $Lap(1/\varepsilon)$ 添加到每个计数中，并返回增加完噪声后最大计数索引（我们忽略之间可能的关联）。将此算法称为 **Report Noisy Max**。

注意到 “**Report Noisy Max**” 算法中的“信息最小化”原理：仅公开与最大值相对应的索引，而不是发布所有噪声计数并让分析人员找到最大值及其索引。 由于一个人的数据会影响所有计数，因此计数向量具有较高的 $\ell_1$ 灵敏度，即 $\Delta f = m$，如果我们想使用拉普拉斯机制发布所有计数，则需要更多的噪声。

**命题 3.9** Report Noisy Max 算法是 $(\varepsilon,0)$-差分隐私。

**【证明】** 令 $D=D' \cup \{a\}$ 。 令 $c,c'$ 分别表示数据库为 $D,D'$的计数向量。我们使用两个属性：

- 1.计数的单调性。对于所有 $j \in [m],c_j \geq c'_j$ 
- 2.利普希茨（Lipschitz）属性。对于所有 $j \in [m],c'_j + 1 \geq c_j$（*注：Lipschitz连续，要求函数图像的曲线上任意两点连线的斜率一致有界，就是任意的斜率都小于同一个常数，这个常数就是 Lipschitz 常数，此处Lipschitz常数为1。*）   

定义任意 $i \in [m]$，我们将限制 i 分别从 $D$ 或 $D'$ 提取比率的上下界。

定义 $r_{-i}$，从 $Lap(1/\varepsilon)^{m-1}$ 用于除第 i 个计数外的所有噪声计数。我们会单独讨论每个 $r_{-i}$。我们使用符号 $\text{Pr}[i|\xi]$ 表示 **Report Noisy Max** 算法在以 $\xi$ 的条件下，输出为 i 的概率。

我们首先讨论 $\text{Pr}[i|D,r_{-i}] \leq e^{\varepsilon}\text{Pr}[i|D',r_{-i}]$ 的情况。 定义：

$$
r^* = \min_{r_i}:c_i + r_i > c_j + r_j \  \forall j \neq i
$$

注意，上面已经定义了 $r_{-i}$ 的情况。当且仅当 $r_i \geq r^*$ 时， i 为数据库 $D$ 的最大统计噪声输出。

对于所有 $1 \leq j \not ={i} \leq m$：

$$
\begin{aligned}
  c_i + r^* &> c_j + r_j\\
  \implies (1 + c'_i) + r^* \geq c_i + r^* &>  c_j + r_j \geq c'_j + r_j\\
  \implies c'_i + (r^* + 1) &> c'_j + r_j
\end{aligned}
$$

因此，如果 $r_i \geq r^* + 1$ ，则当数据库为 D' 时，第 i 个统计计数是最大的，且噪声向量为 $(r_i,r_{-i})$。下面的概率取决于 $r_i \backsim Lap(1/\varepsilon)$ 的选择。

$$
\begin{aligned}
  \text{Pr}[r_i \geq 1 + r^*] &\geq e^{-\varepsilon}\text{Pr}[r_i \geq r^*] = e^{-\varepsilon}\text{Pr}[i|D,r_{-i}]\\
  \implies \text{Pr}[i|D',r_{-i}] \geq \text{Pr}[r_i \geq 1 + r^*] &\geq e^{-\varepsilon}\text{Pr}[r_i \geq r^*] = e^{-\varepsilon}\text{Pr}[i|D,r_{-i}]
\end{aligned}
$$

上面等式两边乘上 $e^{\varepsilon}$ 第一种情况证明完毕。

证明第二种情况，即 $\text{Pr}[i|D',r_{-i}] \leq e^{\varepsilon}\text{Pr}[i|D,r_{-i}]$ 定义：

$$
r^* = \min_{r_i}:c'_i + r_i > c'_j + r_j \  \forall j \neq i
$$

注意，上面已经定义了 $r_{-i}$ 的情况。当且仅当 $r_i \geq r^*$ 时， i 为数据库 $D$ 的最大统计噪声输出。

对于所有 $1 \leq j \not ={i} \leq m$：

$$
\begin{aligned}
  c'_i + r^* &> c_j + r_j\\
  \implies 1 + c'_i + r^* &> 1 + c'_j + r_j\\
  \implies c'_i + (r^* + 1) &> (1 + c'_j) + r_j\\
  \implies c_i + (r^* + 1) \geq c'_i + (r^* + 1) &> (1 + c'_j) + r_j \geq c_j + r_j\\
\end{aligned}
$$

因此，如果 $r_i \geq r^* + 1$ ，则当数据库为 D 时，第 i 个统计计数是最大的，且噪声向量为 $(r_i,r_{-i})$。下面的概率取决于 $r_i \backsim Lap(1/\varepsilon)$ 的选择。

$$
\begin{aligned}
   \text{Pr}[i|D,r_{-i}] \geq \text{Pr}[r_i \geq r^* + 1 ] \geq e^{-\varepsilon}\text{Pr}[r_i \geq r^*] = e^{-\varepsilon}\text{Pr}[i|D',r_{-i}]
\end{aligned}
$$

上面等式两边乘上 $e^{\varepsilon}$ 第二种情况证明完毕。

**【命题 3.9 证毕】**