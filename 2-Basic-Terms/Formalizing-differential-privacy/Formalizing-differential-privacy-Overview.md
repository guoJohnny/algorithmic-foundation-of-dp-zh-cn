# 2.3 形式化差分隐私

我们将从差分隐私的技术定义开始，然后继续解释它。差分隐私将通过过程提供隐私；特别是它将引入随机性。最早的隐私保护做法是使用随机响应技术，这是一种在社会科学中发展起来的技术，用于收集有关禁运或非法行为的统计信息（通过是否拥有财产 $$P$$ 判断）。研究参与者通过下列做法报告他们是否有财产 $$P$$：

* 1.掷硬币。

* 2.如果是反面，那就如实回答。

* 3.如果是正面，则掷第二枚硬币，正面回答“是”，反面回答“否”。

“隐私”来源于对任何输出的合理否认；特别是，如果拥有财产 $$P$$ 相当于从事非法行为，即使是“是”答案也不构成犯罪，因为无论被告是否实际拥有财产 $$P$$ ，这个答案出现的概率至少为 $$1/4$$。准确度来自于对噪声产生过程的理解（随机分组中引入虚假的“是”和“否”答案）：预期的“是”答案的概率是：没有属性 $$P$$ 的参与者概率的 $$1/4$$ 加上有属性 $$P$$ 的概率的 $$3/4$$ 。因此，如果 $$p$$ 是具有 $$p$$ 属性的参与者的真实概率，则“是”答案的预期概率为 $$(1/4)(1-p)+(3/4)p=(1/4)+p/2$$。因此，我们可以将 $$p$$ 估计为回答“是”的概率的两倍减去 $$1/2$$ ，即 $$2((1/4)+p/2)-1/2$$ (*此处个人感觉有误*) 。


*注：此处令 $$P_A$$ 为真实的概率，$$P_B$$ 为经过机制变换后得到的概率，
这样，可以由变换之后的概率$$P_B$$得到真实概率$$P_A$$:*

$$
\begin{aligned}
P_B &=  1/4 (1 - P_A) + 3/4 P_A \\
&= 1/4 + 1/2 P_A \\
P_A &= 2 * P_B - 1/2
\end{aligned}
$$

（*上述的例子可以得出，经过随机化之后，对个人数据是会有不确定性，无法得知个人是什么样的属性，但最后经过“抛硬币机制”处理后得到的总体概率却能还原出数据集原有总体概率。可以尝试，将原有的 $$P_A$$ 取任何值，都能从最后的 $$P_B$$ 还原出来，但此时单个个体的属性是随机化的。*）

随机化是必不可少的；更确切地说，任何非平凡的隐私都要对所有现有的或未来的辅助信息来源随机化处理（包括其他数据库、研究、网站、在线社区、闲话、报纸、政府统计等等）。下面我们来说明一个简单的混合参数。出于矛盾的原因，我们假设有一个非平凡的确定性算法。存在一个查询，并且有两个数据库在此查询下产生不同的输出。一次更改一行，我们看到存在一对仅在单行值上有所不同的数据库，在同一数据库上同一查询产生不同的输出。知道该数据库是这两个几乎完全相同的数据库其中之一的敌手将了解未知行中数据的值。

（*注1：“**非平凡的**” 具有一定复杂度，需要一定脑力活动、加工过程才能得到的结果或结论。The antonym nontrivial is commonly used by engineers and mathematicians to indicate a statement or theorem that is not obvious or easy to prove. 摘自wikipedia*） 

（*注2:为引入随机化和相邻数据集做铺垫。*）

因此，我们将需要讨论随机算法的输入和输出空间。 在本专论中，我们使用离散的概率空间。有时我们会将算法描述为从连续分布中采样，但是应始终以适当的方式将其离散化为有限精度（请参见后文的备注2.1）。通常，具有域 $$A$$ 和（离散）范围 $$B$$ 的随机算法将与从$$A$$到$$B$$上的概率单纯形的映射相关联，表示为$$\Delta(B)$$：

**定义2.1（概率单纯形）**  给定一个离散集 $$B$$，将 $$B$$ 上的概率单纯形，表示为 $$\Delta(B)$$ ，其定义为：  

$$
\Delta(B) = \{ x \in \mathbb{R}^{|B|} : x_i \geqslant 0\    for\ all\ i\ and\ \sum_{i=1}^{|B|}x_i = 1 \}
$$

（*个人理解：此处的 $$\mathbb{R}$$ 可以与数据库中的数据集合类比，$$x_i$$ 即映射后得到数据的类概率，将数据集映射到各个离散状态集合 $$B$$ 的元素中，且这些映射产生离散点 $$x_i$$ 的概率之和为 $$1$$*）

（*个人理解2：对概率单纯形定义进行拓展，即有一个包含 $$|B|$$ 个分量的向量 $$\overrightarrow{x}$$，其分量之和为 $$1$$,如下：*
$$
\begin{aligned}
\overrightarrow{x} \in \mathbb{R}^{|B|},\overrightarrow{x} = (x_1,x_2...x_{|B|})  \\ 
x_i \in \overrightarrow{x},\sum_{i=1}^{|B|}x_i = 1,and \ x_i \geqslant 0 \\
\end{aligned}
$$

**例如硬币翻转随机响应机制则为：**

$$
\begin{aligned}

if \  \overrightarrow{B} = \{ 0,1 \},then \ \mathbb{R}^{|B|} = R \times R  \\
\overrightarrow{x} \in R \times R \ (i.e:(x_1,x_2) \in \overrightarrow{x})  \\
\sum_{i=1}^{|B|}x_i = \sum_{i=1}^{2}x_i = x_1 + x_2 = 1
\end{aligned}
$$

）

**定义2.2（随机化算法）** 具有域$$A$$和离散范围$$B$$的随机算法$$\mathcal{M}$$ 与 映射 $$M:A \to \Delta(B)$$相关联。 在输入$$a∈A$$时，算法$$\mathcal{M}$$以概率$$M(a)_b$$输出$$\mathcal{M}(a)=b$$（$$b∈B$$）。概率空间在算法 $$\mathcal{M}$$ 的硬币翻转上。

（*个人理解：$$\mathcal{M}$$ 是种映射算法（机制），将原始域数据成为其他离散形式（比如直方图）。上文的翻转硬币随机响应机制就是该定义中的 $$\mathcal{M}$$ 。）*）

（**注3：** *随机化算法中最后一句 “**概率空间在算法 $$\mathcal{M}$$ 的硬币翻转上。**”的原文是 “**The probability space is over the coin flips of the algorithm $$\mathcal{M}$$.**”。通过查找资料，在[国外论坛](https://security.stackexchange.com/questions/128472/what-does-probability-space-is-over-coin-flips-of-algorithm-m-mean)上找到了比较清楚的解释，原文如下：*

> I have contacted the authors and they were very helpful. The original quote says it all:
> 
> > The book is about randomized algorithms that act on data sets. You can always view these as deterministic algorithms, which take two inputs -- the data set, and also a string of random bits.
> >
> >The definition of differential privacy has a probability operator, and what that remark means is that the probability is taken over the randomness of the random bit string (i.e. the internal randomness of the algorithm), holding the data set fixed.  
> 
> The key to this is that the definition says: "the algorithm $$\mathcal{M}$$ outputs ... with probability ...". This is a random choice, and the source of randomness is defined by the sentence "The probability space is over the coin flips of the algorithm $$\mathcal{M}$$".

*个人对其意思的理解与解释为：我们可以把随机机制看成是一个确定的函数，这个函数的输出结果是有两个参数决定：一个固定数据集和一个随机的比特串。这个比特串的目的就是为了是为了使输出结果随机（即，使得算法内部随机）。算法 $$\mathcal{M}$$ 的目的就是为了随机选择输出，这种随机性用数学术语表达即为：“**概率空间在算法 $$\mathcal{M}$$ 的硬币翻转上。**” 意思是对这种随机串的比特位进行随机翻转，从而造成的机制的随机性。*

*在后文的差分隐私定义中，同样提及了这个提法，因为定义中存在概率，而这个概率是由随机串的随机性决定的。*

）

我们将数据库 $$x$$ 视为来自全集 $$\mathcal{X}$$ 的记录的集合。用它们的直方图表示数据库通常会很方便：$$x \in \mathbb{N}^{|\mathcal{X}|}$$ ，其中每个项  $$x_i$$ 表示数据库 $$x$$ 中类型 $$i\in\mathcal{X}$$ 元素的数量。（我们略微滥用了符号，让符号 $$\mathbb{N}$$ 表示所有非负整数的集合，包括零）。 在这个表示中，两个数据库 $$x$$ 和 $$y$$ 之间距离的自然度量将是它们的 $$\ell_1$$ 距离：

**定义 2.3 (数据库之间距离)** 将数据库的 $$\ell_1$$ 范数距离表示为 $$\Vert x\Vert _1$$ 其定义为:

$$
\Vert x\Vert _1 = \sum_{i=1}^{|\mathcal{X}|}|x_i|
$$

数据库 $$x$$ 和 $$y$$ 之间的 $$\ell_1$$ 距离为 $$\Vert x-y\Vert _1$$

注意到 $$\Vert x\Vert _1$$ 是衡量数据库 $$x$$ 的大小（也就是说，数据库 $$x$$ 包含的记录数），而 $$\Vert x-y\Vert _1$$ 表示数据库 $$x$$ 和 $$y$$ 之间相差多少条记录。我们称这种记录相差为1的数据库为相邻数据集。

数据库也可以由行的多集（ $$\mathcal{X}$$ 的元素）甚至行的有序列表来表示(这是一组的特例,其中行号成为元素名称的一部分)。 在这种情况下，数据库之间的距离通常由汉明距离（即汉明距离不同）来衡量。  

但是，除非另有说明，否则我们将使用上述直方图表示形式。 （但是请注意，即使直方图表示法在数学上更方便，在实际的实现中，多集表示通常也会更加简洁）。  

现在，我们可以正式定义差分隐私了，这将直观地保证随机算法在相似输入数据库上的行为类似。 