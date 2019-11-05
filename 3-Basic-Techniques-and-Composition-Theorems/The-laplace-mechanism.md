# 3.3 Laplace 机制

数值查询是数据库最基础的数据查询类型，将其定义为：$f:\mathbb{N}^{|\chi|} \to \mathbb{R}^k$。这个查询将数据库映射成为k个真实值。将查询的$\ell_1$敏感度作为衡量我们对查询回答的准确程度的参数之一。

**定义3.1** （$\ell_1$敏感度）方法 $f:\mathbb{N}^{|\chi|} \to \mathbb{R}^k$ 的 $\ell_1$敏感度为：
$$
\Delta f = \max_{x,y\in\mathbb{N}^{|\chi|},||x-y||_1=1}||f(x)-f(y)||_1
$$