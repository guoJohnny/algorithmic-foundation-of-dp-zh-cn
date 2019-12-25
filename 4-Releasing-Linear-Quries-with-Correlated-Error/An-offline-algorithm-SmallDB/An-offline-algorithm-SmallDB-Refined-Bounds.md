# 4.1 SmallDB：离线算法-精确边界

**更精确的边界** 我们证明，每组线性查询 $\mathcal{Q}$ 都有一个最大为 $|\mathcal{X}|^{\log|\mathcal{Q}|/\alpha^2}$ 的数据库集合，这些数据库相对于 $\mathcal{Q}$ 很好地近似了每个数据库 $x$，且误差最大为 $\alpha$。但是，这通常被高估了，因为它完全忽略了查询的结构。例如，如果 $\mathcal{Q}$ 仅包含相同的查询，并且每次以不同的伪装一次又一次地重复，那么就没有理由使指数机制的范围大小随 $|\mathcal{Q}|$ 增大。类似地，甚至可能存在具有无限基数的查询类 $\mathcal{Q}$，但是尽管如此，小型数据库仍可以很好地近似它们。例如，判断一个点是否在实线上的给定间隔内的查询形成了一个无限大的查询类 $\mathcal{Q}$，因为实线上有无数的间隔。但是，此类查询具有非常简单的结构，可使其被小型数据库很好地近似。通过考虑查询类的更精细的结构，我们将能够为差分隐私机制提供边界，这些差分隐私机将改善简单采样边界（**引理4.3**），即使对于双倍指数级的大查询类也可以说是不平凡的。此处并未完全阐明这些界限，但会针对较简单的计数查询类声明一些结果。回想一下计数查询 $f:\mathcal{X}\to \{0,1\}$ 将数据库点映射为布尔值，而不是像线性查询那样映射到 $[0,1]$ 中的任何值。

**定义4.1（Shattering）** 如果对于每个 $T\subseteq S$，存在一个 $f \in \mathcal{Q}$ 使得 $\{x\in S:f(x)=1\}=T$，则称这一类计数查询 $\mathcal{Q}$ 会“**打散**”点 $S\subseteq \mathcal{X}$ 的集合。也就是说：如果在 $2^{|S|}$ 中的每一个 $S$ 的子集 $T$，$\mathcal{Q}$ 中有一些函数将这些元素准确地标记为正，而不标记 $S \backslash T$ 其中的任何元素为正，则称为 $\mathcal{Q}$ “**打散**” $S$。

注意，要使 $\mathcal{Q}$ “**打散**” $S$，必须是 $|\mathcal{Q}\geq 2^{|S|}|$ 的情况。  因为 $\mathcal{Q}$ 必须为每个子集 $T\subseteq S$ 包含一个函数 $f$。现在，我们可以定义计数查询的复杂性度量。

**定义4.2（Vapnik–Chervonenkis（VC）维度）**。 如果存在基数 $|S|=d$ 的某些集合 $S \subseteq \mathcal{X}$ 使得 $\mathcal{Q}$ 打散 $S$，并且 $\mathcal{Q}$ 不打散任何基数为 $d + 1$ 的 $S$，则计数查询 $\mathcal{Q}$ 的集合具有 **VC 维** $d$。 我们可以用 $\text{VC-DIM}(\mathcal{Q})$ 表示这个数量。

再次考虑在域 $\mathcal{X}=\mathbb{R}$ 上定义的范围 $[0,\infty]$ 上的一维间隔的类别。对应于间隔 $[a,b]$ 的函数$f_{a,b}$ 定义为 $f_{a,b}(x)=1$ 当且仅当 $x\in[a,b]$。这是一个无限的查询类，但是它的VC维数是 $2$ 。对于任何成对的不连续点 $x <y$，有一个既不包含点 $(a,b <x)$ 的间隔，也有包含两个点 $(a<x<y<b)$，还有仅包含一个点的间隔 $(a<x<b<y \ \text{OR} \ x<a<y<b)$。但是，对于 $x < y < z$ 的任意3个不同点，没有间隔 $[a,b]$ 使得 $f_{a,b}[x]=f_{a,b}[z]=1$ 而 $f_{a,b}[y]=0$

我们观察到，有限概念类的 **VC维** 永远不会太大。

**引理 4.7** 对于任何有限类 $\mathcal{Q}$，$\text{VC-DIM}(\mathcal{Q})\leq \log|\mathcal{Q}|$ 。

**证明** 如果 $\text{VC-DIM}(\mathcal{Q})=d$，则$\mathcal{Q}$ 打散基数为 $|S|=d$ 的一些集合 $S \subseteq \mathcal{X}$。但是根据打散的定义，由于 $S$ 具有 $2^d$ 个不同的子集， 所以 $\mathcal{Q}$ 必须在至少具有 $2^d$ 不同的函数。

**【引理 4.7 证毕】**。

事实证明，我们可以替换在 **SmallDB** 机制的范围内使用术语 $\log|\mathcal{Q}|$ 为 $\text{VC-DIM}(\mathcal{Q})$。通过前面的引理，这只能是对有限类 $\mathcal{Q}$ 的改进。

**定理 4.8** 对于线性查询 $\mathcal{Q}$ 的任何有限类，如果 $\mathcal{R}=\{y\in \mathbb{N}^{\mathcal{X}}:\Vert y \Vert_1 \in O\big( \frac{ \text{VC-DIM}(\mathcal{Q}) }{\alpha^2}  \big)\}$，则对于所有 $x \in \mathbb{N}^{\mathcal{X}}$ 
，存在一个 $y\in \mathcal{R}$ 使得：

$$
\max_{f\in\mathcal{Q}}|f(x)-f(y)|\leq \alpha
$$

作为该定理的结果，我们使用 **VC维** 作为查询类复杂度的度量，得了带有的类似 **定理 4.5** 的类似定理：

**定理 4.9** 令 $y$ 为 $\text{SmallDB}(x,\mathcal{Q},\varepsilon,\frac{\alpha}{2})$ 的数据库输出，我们可以确保概率为 $1-\beta$ 时有：

$$
\max_{f\in\mathcal{Q}}|f(x)-f(y)|\leq O\Bigg(\bigg(\frac{\log|\mathcal{X}|\text{VC-DIM}(\mathcal{Q})+\log(\frac{1}{\beta})}{\varepsilon\Vert x \Vert_1}\bigg)^{1/3}\Bigg)
$$

等价地，对于任何数据库 $x$ ，其：

$$
\Vert x \Vert_1 \geq \frac{\log |\mathcal{X}|\text{VC-DIM}(\mathcal{Q})+\log(\frac{1}{\beta})}{\varepsilon \alpha^3}
$$

有概率 $1-\beta$ 使得 $\max_{f\in\mathcal{Q}}|f(x)-f(y)|\leq \alpha$。

一种类似（尽管比较麻烦）的查询复杂度度量方法 **“Fat Shattering Dimension”** 定义了一类线性查询的复杂性，而不仅限于计数查询。就像 VC维 用于计数查询复杂度度量一样，**“Fat Shattering Dimension”**  用于控制一类线性查询 $\mathcal{Q}$ 的最小 “α-net”（第5节中的定义 5.2）的大小。类似地，此度量可为隐私发布线性查询的机制提供更精细的界限。