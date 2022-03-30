# 5.2 迭代构建机制

在本节中，我们将推导出隐私累加权重算法的离线泛化算法，可以使用任何适当定义的学习算法将这个算法进行实例化。一般来说，数据库更新算法维护一系列数据结构 $D^1,D^2,...$，这些结构为输入数据库 $x$ 提供​​越来越好的近似值（在某种意义上取决于数据库更新算法）。此外，这些机制通过仅考虑一个查询 $f$ 来产生序列中的下一个数据结构，这个查询 $f$ 在真实数据库 $x$ 产生的结果与在数据结构 $D^t$ 产生的结果有显著的不同。（即：$f(D^t)$ 与 $f(x)$ 区别很大。）本节中的算法表明，在很小的程度上，以差分隐私的方式解决 “查询-发布” 问题就等于以差分隐私的方式解决更简单的学习或区分问题：给定了隐私区分算法和非隐私数据库更新算法，我们得到相应的隐私发布算法。对于一般的线性查询设置，我们可以插入指数机制作为规范的专用区分器，而将乘数权重算法作为通用的数据库更新算法，但是在特殊情况下，可以使用更有效的区分器。

从语法上讲，我们将考虑形式为 $U:\mathcal{D}\times\mathcal{Q}\times\mathbb{R}\to \mathcal{D}$ 的函数。其中 $\mathcal{D}$表示一类数据结构，这类数据结构可以对 $\mathcal{Q}$ 中的查询进行评估。函数 $U$ 的输入为：1、 $\mathcal{D}$ 中的数据结构，将当前数据结构表示为 $D^t$；2、区别查询 $f$，并且可以被限制为某个集合 $\mathcal{Q}$；3、并且还实数 $x$，其估计 $f(x)$。以下我们正式定义一个 ***数据库更新序列***，以控制用于生成数据库序列 $D^1,D^2,...$ 的 $U$ 输入序列。

**定义 5.3 数据库更新序列** 设 $x\in \mathbb{N}^{|\mathcal{X}|}$ 为任意数据库，并设 $\{(D^t,f_t,v_t)\}_{t=1,...,L}\in(\mathcal{D}\times\mathcal{Q}\times\mathbb{R})^L$ 为元组序列。如果满足以下条件：

- 1、$D^1=U(\bot,\cdot,\cdot)$ ，
- 2、任意 $t=1,2,...,L,|f_t(x)-f_t(D^t)|\geq \alpha$
- 3、任意 $t=1,2,...,L,|f_t(x)-v_t| < \alpha$
- 4、任意 $t=1,2,...,L-1,D^{t+1}=U(D^t,f_t,v_t)$

则将其这个序列称之为：$(U,x,\mathcal{Q},\alpha,T)$-数据库更新序列（ $(U,x,\mathcal{Q},\alpha,T)-database\  update \ sequence$ ）

注意，对于数据库更新算法，近似响应 $v_t$ 仅用于确定 $f_t(x)-f_t(D^t)$ 的符号，这是**条件3**中要求 $f_t(x)-v_t$ 的估计误差小于 $\alpha$ 的动机。我们更关注数据库更新算法的主要效率衡量标准是：在数据库 $D^t$ 相对于 $\mathcal{Q}$ 中的查询很好地近似 $x$ 之前，我们需要执行的最大更新次数。为此，我们将数据库更新算法定义为如下：

**定义5.4 数据库更新算法** 令 $U:\mathcal{D}\times\mathcal{Q}\times\mathbb{R}\to \mathcal{D}$ 为更新规则，令 $T:\mathbb{R}\to\mathbb{R}$ 为函数。对每个数据库 $x\in \mathbb{N}^{|\mathcal{X}|}$ 如果每个 $(U,x,\mathcal{Q},\alpha,T)$-数据库更新序列满足 $L\leq T(\alpha)$，则称 $U$ 为：查询类 $\mathcal{Q}$ 的 $T(\alpha)$- 数据库更新算法。

$T(\alpha)$- 数据库更新算法的定义表明如果 $U$ 是 $T(\alpha)$- 数据库更新算法，则给定最大 $(U,x,\mathcal{Q},\alpha,U)$-数据库更新序列，最终数据库 $D^L$ 必须满足 $\max_{f\in\mathcal{Q}}|f(x)-f(D^L)|\leq \alpha$，否则将存在满足定义5.3的条件2的另一个查询，因此将存在一个 $(U,x,\mathcal{Q},\alpha,L+1)$-数据库更新序列，与最大矛盾。 也就是说，$T(\alpha)$-数据库更新规则的目标是生成最大的数据库更新序列，并且最大数据库更新序列中的最终数据结构必须对每个查询 $f\in \mathcal{Q}$ 的近似响应进行编码。

既然我们已经定义了数据库更新算法，那么在 [**定理4.10**](4-Releasing-Linear-Quries-with-Correlated-Error/An-online-mechanism-private-multiplicative-weights/The-multiplicative-weight-update-rule.html) 中我们真正证明的是，可乘权重算法是 $T(\alpha)=4\log|\mathcal{X}|/\alpha^2$ 的 $T(\alpha)$-数据库更新算法。 

到此让我们为数据库更新算法建立一些直观概念。 $T(\alpha)$-数据库更新算法开始于一些有关真实数据库 $x$ 的初始猜测 $D^1$。因为该猜测不基于任何信息，所以 $D^1$ 和 $x$ 很可能几乎没有相似之处，并且存在一些查询 $f\in \mathcal{Q}$ 以至少 $\alpha$ 的精度区分这两个数据库：即 $f(x)$ 和 $f(D^1)$ 的值相差至少为 $\alpha$。数据库更新算法的作用是在有证明当前假设 $D^{t-1}$ 不正确的情况下更新其假设 $D^t$：在每个阶段，它以 $\mathcal{Q}$ 中的某个查询作为输入，这些查询能区别其当前假设与真实数据库的偏差，然后输出一个新的假设。参数 $T(\alpha)$ 是数据库更新算法更新其假设的次数的上限：这个上限保证在提供最多 $T(\alpha)$ 区别查询之后，该算法将最终产生了一个关于查询 $\mathcal{Q}$ 的假设数据集 $D^t$，$D^t$ 看起来像是真正的数据库 $x$（至少不超过误差 $\alpha$）$\ ^{[1]}$。对于数据库更新算法，更希望使用较小的边界 $T(\alpha)$。

（原书注[1]：假设数据库更新算法企图从整个数据集中抽出一块来构建$x$。初始时，它的构建结构$D^1$与真正的数据库没有任何相似之处：它只是简单的一块数据集。然而，一个有用的区分器可以指出该数据结构比真正目标数据库差异大的构造器位置：构造器尽可能地减少这些差异。如果区分器总能找到大量的差异，数量上至少为$\alpha$，那么构造很快就会完成，区分器也不会浪费时间！）

**数据库更新算法和在线学习算法**：我们注意到数据库更新算法本质上是在线学习算法中的错误边界模型（the mistake bound model）。在在线学习的设置中，未标记的示例以任意顺序到达，学习算法必须尝试标记它们。

**学习理论的背景. **在错误边界模型中，被标记的样本$(x_i,y_i)\in \mathcal{X}\times\{0,1\}$以潜在的对抗顺序一次到达一个（对学习理论不熟悉，后面需要再斟酌）。在第$i$次中，学习算法$A$观察$x_i$，并必须对$x_i$的标签做一个预测$\hat{y_i}$。然后算法比较真实的标签$y_i$，如果预测错误，就被称为犯了一个错误（make a mistake）：例如，如果$y_i\neq\hat{y_i}$。一个学习算法$A$对于一类函数$C$的学习算法，如果对于全体$f\in C$，和对于所有对抗性地选择的样本序列$(x_1,f(x_1)),...,(x_i,f(x_i)),...$，$A$永远不会造成超过$M$个错误，则算法$A$被称为有一个$M$的错误边界。在不失一般性的情况下，我们可以认为这样的学习算法是一直保持着某种假设$\hat{f} : X \to\{0, 1\}$，并且只在犯错时才更新。这个模型中的对手是相当强大的——它可以自适应地选择标记的样本序列，知道学习算法的当前假设，以及其整个预测历史。因此，具有有限错误边界的学习算法在极其普遍的情况下是有用的。

不难看出，对于有限类的函数C来说，错误受限的在线学习算法总是存在的，例如，考虑减半算法（the halving algorithm）。减半算法最初维护一个与它迄今所见的样例集相一致的$C$的函数集$S$：最初，$S=C$。每当一个新的未被标记的样本出现时，它都会根据其一致性假设的多数票预测：即，每当$|f\in S:f(x_i)=1|\geq|S|/2$时，其预测为标签1。每当它对样例$x_i$预测错误，其通过删除任何不一致的函数来更新$S$：$S\leftarrow{f\in S:f(x_i)=y_i}$。请注意，每当它出错时，$S$的大小都会减半！所以只要所有的样例都被某个函数$f\in C$标记，至少有一个函数$f\in C$从未从$S$中删除。因此，减半算法有$log|C|$的错误边界。

除了布尔标签，我们还可以将数据库更新算法视为错误边界模型中的在线学习算法：

这里的例子是查询（可能以敌对顺序出现）。标签是在数据库上评估（个人理解：查询）时查询的近似值。如$|f(D_t)-f(x)|\geq\alpha$，数据库更新算法就假设$D_t$在查询$f$上犯了错误，在这种情况下，我们学习$f$的标签（即$v_t$），并允许数据库更新算法更新假设。说一个算法$U$是一个$T(\alpha)-$数据库更新算法，就相当于说它有一个$T(\alpha)$的错误边界：没有任何对抗性选择的查询序列能使它犯超过$T(\alpha)-$错误。事实上，我们将看到的数据库更新算法取自于在线学习的文献。可乘权重机制是基于一种被称为对冲（Hedge）的在线学习算法，我们已经讨论过这个算法。中位数机制（本节后面）是基于减半算法，而Perceptron算法是基于（巧合的）一种被称为Perceptron的算法。我们不会在这里讨论Perceptron，但它的操作是进行加法更新，而不是可乘权重使用的乘法更新。

一类Q的数据库更新算法将与相应的区分器一起发挥作用，区分器的工作是输出一个在真实数据库$x$和假设$D_t$上表现不同的函数，也就是说，指出一个错误。

**定义 5.5（$(F(\varepsilon),\gamma)$-私有区分器）**令$Q$为一个查询集合，令$\gamma\geq0$以及$F(\varepsilon):\mathcal{R}\to\mathcal{R}$为一个函数。一个算法区分$\ _{\varepsilon}$：$\mathbb{N}^{|\mathcal{X}|}\times\mathcal{D}\to\mathcal{Q}$是对$Q$的一个$(F(\varepsilon),\gamma)$-私有区分器，如果对于隐私参数$\varepsilon$的每一个设置，每一对输入$x\in\mathbb{N}^{|X|}$，$D\in\mathcal{D}$它对$x$是$(\varepsilon,0)$-差分隐私的，并且它输出一个$f^∗\in\mathcal{Q}$，使得$|f^∗(x)-f^∗(D)|\geq\max_{f\in\mathcal{Q}}|f(x)-f(D)|-F(\varepsilon)$，概率至少是$1-\gamma$。

**备注 5.1** 在机器学习中，目标是从一类函数$Q$中找到一个函数$f ： \mathcal{X} \to{0,1}$，该函数最好地标记了标签样例 $(x_1,y_1),...,(x_m，y_m)\in\mathcal{X} \times \{0,1\}$的集合。（样例$(x，0)$称为负样例，样例$(x，1)$称为正样例）。每一个样例$x_i$有一个正确的标签$y_i$，和一个函数$f$正确地标记了$x_i$如果$f(x_i)=y_i$。对于一个类$\mathcal{Q}$的不可知论学习算法（agnostic learning algorithm）是一种可以找到$\mathcal{Q}$中为所有数据点打上近似于$\mathcal{Q}$中最佳函数的标签的函数的算法，即使$\mathcal{Q}$中没有函数可以完美的对数据打上标签。请注意，等价地，一个不可知论学习算法是使标记为1的正例的数量减去标记为1的负例的数量最大化的算法。以这种方式来看，上面定义的区分器就只是一种不可知论学习算法：只要想象$x$包含所有“正”例，$y$包含所有的“负”例。（请注意，$x$和$y$不是不相关的也可以——在学习问题中，同一个样本可以同时出现在正例和负例的标签中，因为不可知论学习并不要求任何函数对每个样本进行完美的标记。）最后，还要注意的是，对于线性查询类$\mathcal{Q}$，区分器只是一种优化算法，因为对于线性查询$f$，$f(x)-f(y)=f(x-y)$，一个区分器只是试图找到$arg\space\max_{f\in\mathcal{Q}}|f(x-y)|$。

请注意，先验的差分私隐私分器比差分隐私发布算法弱：区分器仅在集合$\mathcal{Q}$中找到一个具有近似最大值的查询，而发布算法必须找到$\mathcal{Q}$中的每个查询的回答。但是在下面的算法中，我们将发布简化到优化。

我们先分析IC算法，然后用一个特定的区分器和数据库更新算法将其实例化。以下是一个正式的分析，但该机制从直观来看是简单的：我们只需要运行迭代数据库构建算法来构建一个相对于查询$\mathcal{Q}$于$x$近似匹配的假设。 如果在每一轮中，我们的区分器都能成功地找到一个在假设数据库和真实数据库之间存在的高差异查询，那么我们的数据库更新算法将输出一个相对于$\mathcal{Q}$来说是$\beta$- 准确的数据库。如果区分器未能找到这样的查询，那么一定是没有这样的查询，并且我们的数据库更新算法已经学习了有关感兴趣查询的准确假设！这最多需要$T$次迭代，因此我们使用$(\varepsilon_0,0)-$差分隐私方法访问$2T$次数据（运行给出的区分器，然后以Laplace机制检查它的回答）。因此隐私将会遵循我们的合成定理。

![Algorithm 8](/5-Generalizations/img/Algorithm8.png)

对该算法的分析只是涉及检查一个简单直观的技术细节。符合隐私是因为这个算法仅由$2T(\alpha)$步组成，每一步都是$(\varepsilon_0,0)-$差分隐私。符合准确度是因为我们总是以最大数据库更新序列输出最后一个数据库。如果算法尚未形成最大数据库更新序列，则区分算法将找到一个区分查询，为序列添加另一个步骤。

**定理 5.3 **IC算法对于$\varepsilon_0\leq\varepsilon/2T(\alpha/2)$是$(\varepsilon,0)-$差分隐私的。对于$\varepsilon_0\leq\frac{\varepsilon}{4\sqrt{T(\alpha/2)log(1/\delta)}}$，IC算法是$(\varepsilon,\delta)-$差分隐私的。

【证明】该算法最多运行$2T(\alpha/2)$个$\varepsilon_0-$差分隐私算法的组合。回顾定理[**3.20**](\3-Basic-Techniques-and-Composition-Theorems\Composition-theorems)，$\varepsilon_0-$差分隐私算法在$2k-\text{fold}$组合下是$2k\varepsilon_0$差分隐私的，并且对于$\varepsilon'=\sqrt{4k\space\text{ln}(1/\delta')}\varepsilon_0+2k\varepsilon_0(e^{\varepsilon_0}-1)$。代入所述的$\varepsilon_0$的值就可以证明这个定理。

**定理 5.4** 给定一个$(F(\varepsilon),\gamma)-$私有区分器，一个参数$\varepsilon_0$，和一个$T(\alpha)-$数据库更新算法，至少以$1-\beta$的概率，IC算法返回一个数据库$y$，有：$max_{f\in\mathcal{Q}}|f(x)-f(y)|\leq\alpha$，对于任意$\alpha$满足：
$$
\alpha\geq\max\big[\frac{8\text{log}(2T(\alpha/2)/\beta)}{\varepsilon_0||x||_1},8F(\varepsilon_0)\big]
$$
只要$\gamma\leq\beta/(2T(\alpha/2))$。

【证明】分析是直观的。

回顾一下，如果$Y_i\sim Lap(1/\varepsilon||x||_1)$，我们有：$\text{Pr}[|Y_i|\geq t/(\varepsilon||x||_1)]=\text{exp}(-t)$。通过联合界限，如果$Y_1,...,Y_k\sim Lap(1/\varepsilon||x||_1)$，有$\text{Pr}[max_i|Y_i|\geq t/(\varepsilon||x||_1)]=k\space\text{exp}(-t)$。因此，因为我们从$Lap(1/\varepsilon_0||x||_1)$中最多进行了$T(\alpha/2)$次绘制（原文这里是：“Therefore, because we make at most $T(\alpha/2)$ draws from $Lap(1/\varepsilon_0||x||_1)$,”这里个人理解为生成噪声$\hat{v}^{(t)}$最多进行了$T(\alpha/2)$次），除了最多$\beta/2$的概率，对于所有的$t$：
$$
|\hat{v}^{(t)}-f^{(t)}(x)|\leq\frac{1}{\varepsilon_0||x||_1}\text{log}\frac{2T(\alpha/2)}{\beta}\leq\frac{\alpha}{8}
$$
（个人注：第一个不等式是令$t=\text{log}\frac{2T(\alpha/2)}{\beta}$得到，如果第二个不等式要成立，则需要在不超过概率$\beta/2$下，有$|\hat{v}^{(t)}-f^{(t)}(x)|\geq\alpha/8$，这里不知道是怎么得到的，当然，可以以概率下界$1-\beta/2$，限制噪声值和原值不超过$\alpha/8$）

请注意，通过假设，$\gamma\leq\beta/(2T(\alpha/2))$，所以，除了$\beta/2$的概率，我们有：
$$
|f^{(t)}(x)-f^{(t)}(D^{t-1})|&\geq\max_{f\in\mathcal{Q}}|f(x)-f(D^{t-1})|-F(\varepsilon_0)\\
&\geq\max_{f\in\mathcal{Q}}|f(x)-f(D^{t-1})|-\frac{\alpha}{8}
$$
对于剩下的的讨论，我们将以这两个事件的发生为条件，除了概率$\beta$之外的情况。

这里有两种情况。一种是数据结构$D'=D^{T(\alpha/2)}$作为输出，另一种是对于$t<T(\alpha/2)$，以数据结构$D'=D^t$为输出。第一种，假设$D'=D^{T(\alpha/2)}$。因此对于所有$t<T(\alpha/2)$，都有$|\hat{v}^{(t)}-f^{(t)}(D^{t-1})|\geq3\alpha/4$，并且通过我们的条件，$|\hat{v}^{(t)}-f^{(t)}(x)|\leq\alpha/8$，我们知道对于所有$t$：$|f^{(t)}(x)-f^{(t)}(D^{t-1})|\geq\alpha/2$。因此，序列$(D^t,f^{(t)},\hat{v}^{(t)})$构成了一个最大为$(U,x,\mathcal{Q},\alpha/2,T(\alpha/2))-$数据库更新序列（回顾定义 5.3），并且我们也满足了$\max_{f\in\mathcal{Q}}|f(x)-f(x')|\leq\alpha/2$。

接着，假设对于$t<T(\alpha/2)$，$D'=D^{t-1}$。那么这种情况下的$t$，有$|\hat{v}^{(t)}-f^{(t)}(D^{t-1})|<3\alpha/4$。通过我们的条件，这种情况下必有$|f^{(t)}(x)-f^{(t)}(D^{t-1})|\leq\frac{7\alpha}{8}$，因此根据分类器$(F(\varepsilon_0),\gamma)-$的特性：
$$
\max_{f\in\mathcal{Q}}|f(x)-f(D')|<\frac{7\alpha}{8}+F(\varepsilon_0\leq\alpha)
$$
也得到满足。

请注意，我们可以使用指数机制作为私有区分器：将域作为$\mathcal{Q}$，并让质量分数为：$q(D,f)=|f(D)-f(D^t)|$，其敏感度为$1/||x||_1$。应用 指数机制效用定理，我们得到：

**定理 5.5** 指数机制是一个$(F(\varepsilon),\gamma)-$区分器，对于：
$$
F(\varepsilon)=\frac{2}{||x||_1\varepsilon}\big(\log\frac{|Q|}{\gamma}\big)
$$
因此，使用指数机制作为区分器，定理5.4给出：

**定理 5.6** 给定一个$T(\alpha)-$数据库更新算法和一个参数$\varepsilon_0$的指数机制区分器，以至少$1-\beta$的概率，IC算法返回一个数据库$y$有：$\max_{f\in\mathcal{Q}}|f(x)-f(y)|\leq\alpha$，其中：
$$
\alpha\leq\max\big[\frac{8\text{log}(2T(\alpha/2)/\beta)}{\varepsilon_0||x||_1},\frac{16}{||x||_1\varepsilon_0}\big(\log\frac{|\mathcal{Q}|}{\gamma}\big)\big]
$$
只要$\gamma\leq\beta/(2T(\alpha/2))$。

插入我们的$\varepsilon_0$的值：

**定理 5.7** 给定一个$T(\alpha)-$数据库更新算法，加上指数机制区分器，IC机制是$\varepsilon-$差分隐私的，并且以至少$1-\beta$的概率，IC算法返回一个数据库$y$有：$\max_{f\in\mathcal{Q}}|f(x)-f(y)|\leq\alpha$，其中：
$$
\alpha\leq\frac{8T(\alpha/2)}{||x||_1\varepsilon}\big(\log\frac{|\mathcal{Q}|}{\gamma}\big)
$$
对于：
$$
\alpha\leq\frac{16\sqrt{T(\alpha/2)\log(1/\delta)}}{||x||_1\varepsilon}\big(\log\frac{|\mathcal{Q}|}{\gamma}\big)
$$
是$(\varepsilon,\delta)-$差分隐私的，只要$\gamma\leq\beta/(2T(\alpha/2))$。

请注意，在本节的论述中，我们在[**定理4.10**](4-Releasing-Linear-Quries-with-Correlated-Error/An-online-mechanism-private-multiplicative-weights/The-multiplicative-weight-update-rule.html)中证明的正是可乘权重算法是一种$T(\alpha)=\frac{4\log|\mathcal{X}|}{\alpha^2}$的$T(\alpha)-$数据库更新算法。把这个界限插入定理5.7，就能得到我们对在线乘法权重算法得到的界限。但是请注意，我们也可以插入其他数据库更新算法。

