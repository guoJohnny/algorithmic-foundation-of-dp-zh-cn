# 5.3.2 不可知论学习

一种看待IC机制正在做的事情的方法是，它将 *查询发布* 的看似（理论上）更困难的问题减少为 *查询区分* 或 *学习* 的更容易的问题。回想一下，区分问题是找到在两个数据库$$x$$和$$y$$之间变化最大的查询$$f\in\mathcal{Q}$$。 回顾在学习中，学习器被赋予一组标记示例$$(x_1, y_1),..., (x_m, y_m) \in \mathcal{X}\times\{0, 1\}$$，其中$$y_i\in\{0, 1\}$$是$$x_i$$的标签。如果我们把$$x$$看成代表某个大数据集中的正例，$$y$$看成代表同一个数据集中的负例，那么我们可以看出区分的问题正是不可知论学习的问题。也就是说，区分器会找到最能标记正例的查询，即使在类中没有可以保证完美标记它们的查询（请注意，在此设置中，同一示例可以同时出现正例和负例标签——所以即使$$x$$和$$y$$不相交，减少仍然有意义）。直观地说，学习应该是一个信息理论上比查询发布更容易的问题。 查询发布问题要求我们发布某个类$$\mathcal{Q}$$中每个查询$$f$$的近似值，并在数据库上进行评估。 相比之下，不可知学习问题只要求我们返回单个查询的评估和特征：最好地标记数据集的查询。 很明显，从理论上讲，学习问题并不比查询发布问题难。 如果我们可以解决数据库$$x$$和$$y$$上的查询发布问题，那么我们就可以解决区分问题，而无需进一步访问真正的私有数据集，只需检查我们的查询发布算法提供给我们的在$$x$$和$$y$$上的每个查询$$f\in\mathcal{Q}$$所做的近似评估。我们在本节中展示的是，情况反过来也是可以的：给定访问私有区分或不可知学习算法，我们可以通过对私有区分算法进行少量（即仅$$\log|\mathcal{X}|/\alpha^2$$）次调用来解决查询发布问题，*而无需进一步访问私有数据集*。

这意味着什么？ 它告诉我们，在很小的因素上，不可知学习的信息复杂度等于查询发布的信息复杂度。在计算上，减少的效率仅与我们的数据库更新算法一样有效，根据我们的设置和算法，该算法可能有效，也可能无效。但它告诉我们，我们可以为证明一个问题的任何类型的信息论界限都可以移植到另一个问题，反之亦然。例如，我们见过的大多数算法（以及我们知道的大多数算法！）最终通过拉普拉斯机制进行线性查询来访问数据集。事实证明，任何此类算法都可以被视为在所谓数据访问的 *统计查询* 模型中运行，该模型由Kearns在机器学习的背景下定义。 但是在统计查询模型中进行不可知学习是非常困难的：即使忽略计算方面的考虑，也没有一种算法可以只对数据集进行多项式查询，并且不可知地学习连接词，以达到亚恒定的误差。对于查询发布，这意味着，*在统计查询模型中*，没有用于*发布* 以$$1/\alpha$$时间多项式运行的连词（即列联表）的算法，其中$$\alpha$$是所需的准确度级别。 如果存在具有这种运行时保证的隐私保护查询发布算法，它必须在SQ模型之外运行，因此看起来与当前已知的算法非常不同。

因为隐私保证是线性组合的，这也告诉我们（直到$$\log|\mathcal{X}|/\alpha^2$$的可能因子）我们不应该期望能够隐私地学习到比隐私地执行查询发布更高的准确度，反之亦然 : 一个问题的准确算法会自动为我们提供另一个问题的准确算法。

