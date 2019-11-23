# 3.1 概率工具

以下集中不等式经常会有用。 我们以易于使用的形式而不是最强的形式陈述它们。
（注：集中不等式：集中不等式是数学中的一类不等式，描述了一个随机变量是否集中在某个取值附近。例如大数定律说明了一系列独立同分布随机变量的平均值在概率上趋近于它们的数学期望，这表示随着变量数目增大，平均值会集中在数学期望附近。）

**定理3.1**（加法形式的切尔诺夫界限、又称切尔诺夫不等式）定义 $X_1,X_2 ,...,X_m$ 为独立随机变量，对任意,$i$ 有 $0\leq X_i \leq 1$ 。定义 $S = \frac{1}{m}\sum_{i=1}^{m}X_i$ 为随机变量的均值，定义 $\mu = \mathbb{E}[S]$ 为他们的期望均值。则可以得到如下不等式：
$$
\begin{aligned}
    \text{Pr}[S > \mu + \varepsilon] &\leq e^{-2m\varepsilon^{2}}\\
    \text{Pr}[S < \mu - \varepsilon] &\leq e^{-2m\varepsilon^{2}}   
\end{aligned}
$$

**定理3.2**（乘法形式的切尔诺夫不等式）定义 $X_1,X_2 ,...,X_m$ 为独立随机变量，对任意,$i$ 有 $0\leq X_i \leq 1$ 。定义 $S = \frac{1}{m}\sum_{i=1}^{m}X_i$ 为随机变量的均值，定义 $\mu = \mathbb{E}[S]$ 为他们的期望均值。则可以得到如下不等式：
$$
\begin{aligned}
    \text{Pr}[S > (1 + \varepsilon)\mu] &\leq e^{-m\mu\varepsilon^{2}/3}\\
    \text{Pr}[S < (1 - \varepsilon)\mu] &\leq e^{-m\mu\varepsilon^{2}/2}  
\end{aligned}
$$

当我们没有独立的随机变量时。我们仍然可以应用 $Azuma$ 不等式：

**定理3.3 Azuma不等式** 令 $f$ 为 $m$ 个随机变量 $X_1,...,X_m$ 的方法，每一个 $X_i$ 的值取自集合 $A_i$ ，使得 $\mathbb{E}(f)$ 有界。用 $c_i$ 表示 $X_i$ 对 $f$ 的最大影响，即对于所有的 $a_i,a_i^{\prime} \in A_i$， 有：
$$
|\mathbb{E}[f|X_1,...,X_{i-1},X_i=a_i]|-|\mathbb{E}[f|X_1,...,X_{i-1},X_i=a_i^\prime]| \leq c_i
$$
则：
$$
\text{Pr}[f(X_i,...,X_m) \geq \mathbb{E}[f] + t ] \leq exp(-\frac{2t^2}{\sum_{i=1}^{m}c_i^2})
$$
（注：Azuma不等式涉及随机过程中“鞅”（Martingale）的概念）

**定理3.4 斯特林近似** $n!$ 可以近似于 $\sqrt{2n\pi}(n/e)^n$:
$$
\sqrt{2n\pi}(n/e)^ne^{1/(12n+1)} < n! < \sqrt{2n\pi}(n/e)^ne^{1/(12n)}
$$