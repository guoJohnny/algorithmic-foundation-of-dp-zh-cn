# 3.6 稀疏向量算法：高于阈值算法
**设置** 设 $m$ 表示灵敏度为 1 的查询总数，可以自适应地选择。在不丧失通用性的情况下，有一个预先固定的阈值 $T$（或者每个查询可以有自己的阈值，但结果不变）。我们将在查询值中添加噪声，并将结果与 $T$ 进行比较。正向的结果意味着噪声查询值超过了阈值。我们期望 $c$ （少量）个噪声值超过阈值，并且我们只释放高于阈值的噪声值。算法将 $c$ 用作其停止条件。

我们将首先分析在超过阈值查询的 $c=1$ 之后算法停止的情况，并表明无论查询的总序列有多长，该算法都是 $\varepsilon$-差分隐私的。然后利用我们的合成定理分析 $c>1$ 的情形，并推导出 $(\varepsilon,0)$ 和$(\varepsilon,\delta)$-差分隐私的界。

我们首先论证了 **AboveThreshold** 算法是私有的，并且是准确的，该算法专门针对一个高于阈值的查询。

![AboveThreshold](/3-Basic-Techniques-and-Composition-Theorems/The-sparse-vector-technique/img/AboveThreshold.png)

（*注：上面算法中 $\bot$ 为永假含义; $\top$ 为永真含义。*）

**定理  3.23** **AboveThreshold** 算法是 $(\varepsilon,0)$- 差分隐私的。

【证明】固定任意两个相邻数据库 $D$ 和 $D'$。设 $A$ 为表示 **AboveThreshold算法** $(D,{f_i},T,\varepsilon)$ 输出的随机变量，设 $A'$ 为表示 **AboveThreshold算法** $(D',{f_i},T,\varepsilon)$ 输出的随机变量。算法的输出是这些随机变量的一些实现，即：$a \in \{\bot,\top\}_k$，其形式是对于所有的 $i<k,a_i=\bot,a_k=\top$ 。算法内部有两种类型的随机变量：噪声阈值 $\hat{T}$ 和对 $k$ 个查询的扰动 $\{v_i\}_{i=1}^k$。在下面的分析中，我们将固定（任意的）$v_1,...,v_{k-1}$ 的值。并且 $v_k$ 和 $\hat{T}$ 具有随机性。定义以下量，该量代表在 $D$ 上估计任何查询 $f_1,...,f_{k-1}$ 的最大噪声值：

$$
g(D) = \max_{i<k}(f_i(D) + v_i)
$$

在下文中，我们将滥用表示法，将 $\text{Pr}[\hat{T}=t]$ 写为 $\hat{T}$ 在 $t$ 处的概率密度函数的简写（类似于 $ν_k$），并写 $\mathbf{1}[x]$ 表示事件 $x$ 的指标函数。注意固定 $v_i,...,v_{k-1}$ 的值（这使 $g(D)$ 为确定量），我们有：

$$
\begin{aligned}
    \underset{\hat{T},v_k}{\text{Pr}}[A=a] &= \underset{\hat{T},v_k}{\text{Pr}}[\hat{T} > g(D) \  \text{and} \ f_k(D)+v_k > \hat{T}]\\
    &= \underset{\hat{T},v_k}{\text{Pr}}[\hat{T} \in (g(D),f_k(D)+v_k]]\\
    &= \int_{-\infty}^{\infty}\int_{-\infty}^{\infty}\text{Pr}[v_k=v]\\
    &\ \enspace \ \cdot \text{Pr}[\hat{T}=t]\mathbf{1}[t\in (g(D),f_k(D)+v]]dvdt\\
    &= *
\end{aligned}
$$

我们现在对变量做一些变换，定义：

$$
\begin{aligned}
    \hat{v} &= v+g(D)-g(D')+f_k(D)-f_k(D')\\
    \hat{t} &= t + g(D) - g(D')
\end{aligned}
$$

注意，对于任何 $D,D',|\hat{v}-v|\leq 2,|\hat{t}-t|\leq 1$ 。这是因为每个查询 $f_i(D)$ 的敏感度都是 $1$ 的，因此量 $g(D)$ 的敏感度也是 $1$ 。应用变量的这种变化，我们有：

$$
\begin{aligned}
    * &= \int_{-\infty}^{\infty}\int_{-\infty}^{\infty}\text{Pr}[v_k=\hat{v}]\cdot\text{Pr}[\hat{T}=\hat{t}]\mathbf{1}[(t+g(D)-g(D'))\\
   &\ \qquad \qquad \enspace \in(g(D),f_k(D')+v+g(D)-g(D']]dvdt\\
   &= \int_{-\infty}^{\infty}\int_{-\infty}^{\infty}\text{Pr}[v_k=\hat{v}]\cdot\text{Pr}[\hat{T}=\hat{t}]\mathbf{1}[t\in(g(D'),f_k(D')+v]]dvdt\\
   & \leq \int_{-\infty}^{\infty}\int_{-\infty}^{\infty}\exp(\varepsilon/2)\text{Pr}[v_k=v]\\
   &\enspace \enspace \cdot \exp(\varepsilon/2)\text{Pr}[\hat{T}=t]\mathbf{1}[t\in(g(D'),f_k(D')+v]]dvdt\\
   &= \exp(\varepsilon)\underset{\hat{T},v_k}{\text{Pr}}[\hat{T} > g(D') \  \text{and} \ f_k(D')+v_k > \hat{T}]\\
   &= \exp(\varepsilon)\underset{\hat{T},v_k}{\text{Pr}}[A'=a]
\end{aligned}
$$

不等式来自 $|\hat{v}-v|$ 和 $|\hat{t}-t|$的界，以及 **Laplace** 分布的概率密度函数。