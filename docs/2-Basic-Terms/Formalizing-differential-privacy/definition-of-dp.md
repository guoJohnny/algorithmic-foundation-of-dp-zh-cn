# 2.3* 差分隐私定义补充说明

## 1、贝叶斯解释

令 $X=(X_1,...,X_n)\in \mathcal{X}^n$ 为随机变量，该随机变量是根据对手对数据集的“先验知识”而产生的分布。并令 $X_{-i}=(X_1,...,X_{i-1},\bot,X_{i+1},...,X_n)$ 为去除掉第 $i$ 个人的数据的数据集（或将该人的数据替换为 dummy value）。

假设 $\mathcal{M}:\mathcal{X}^n \to Y$ 是 $\varepsilon$-差分隐私的，令 $y\in Y$ 为任意可能的输出。则：对于每一个 $x_i \in \mathcal{X}$，有：

$$
\text{Pr}[X_i = x_i|\mathcal{M}(X)=y]\in e^{\pm\varepsilon}\cdot \text{Pr}[X_i = x_i|\mathcal{M}(X_{-i})=y]
$$

## 2、差分隐私定义的变体

