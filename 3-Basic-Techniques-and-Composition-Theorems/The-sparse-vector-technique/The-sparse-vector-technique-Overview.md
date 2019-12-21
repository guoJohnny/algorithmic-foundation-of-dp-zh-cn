# 3.6 稀疏向量技术
拉普拉斯机制可用于回答自适应选择的低敏感度查询，并且从我们的合成定理中我们知道，隐私参数与所回答的查询数量（或其平方根）成比例地降低。不幸的是，经常会发生我们有大量问题要回答的问题，即使使用 **3.5节** 中的高级合成定理，也有太多问题无法使用独立的扰动技术来提供合理的隐私保证。但是，在某些情况下，我们只会关心知道高于某个阈值的查询的标识。在这种情况下，我们希望通过放弃对明显低于阈值的查询的数字答案，而仅报告这些查询确实低于阈值，从而获得本质的分析。（如果我们这样选择的话，我们也将能够获得阈值以上查询的数字值，而只需花费额外的费用）。这类似于我们在**3.3节**中的“**Report Noisy Max**”机制中所做的事情，实际上，对于非交互式或脱机情况，可以选择迭代该算法或指数机制。

在本节中，我们显示如何在在线设置中分析此方法。该技术很简单：添加噪音并仅报告噪声值是否超过阈值。本节中，我们的重点是分析隐私只会随着实际高于阈值的查询数量而降低，而不会随着查询总数的增加而降低。如果我们知道位于阈值以上的查询集比查询总数小得多（也就是说，如果答案向量稀疏的话），那么将可以大量节省（隐私参数）。

更详细地讲，我们将考虑一系列事件（每个查询一个），如果在数据库上评估的查询超过给定（已知的、公共的）阈值，则会发生这些事件。我们的目标是释放一个位向量，以指示每个事件是否已发生。在提出每个查询时，该机制将计算一个噪声响应，并将其与（众所周知的）阈值进行比较，如果超过了该阈值，则将揭示此事实。由于隐私证明（**定理3.24**）中的技术原因，该算法适用于阈值 $T$ 的噪声版本 $\hat{T}$。虽然 $T$ 是公开的，但噪声版本 $\hat{T}$ 不是。

并非对每个可能的查询都造成隐私损失，后文的分析将仅针对接近或高于阈值的查询值导致隐私损失。

**设置** 设 $m$ 表示灵敏度为 1 的查询总数，可以自适应地选择。在不丧失通用性的情况下，有一个预先固定的阈值 $T$（或者每个查询可以有自己的阈值，但结果不变）。我们将在查询值中添加噪声，并将结果与 $T$ 进行比较。正向的结果意味着噪声查询值超过了阈值。我们期望 $c$ （少量）个噪声值超过阈值，并且我们只释放高于阈值的噪声值。算法将 $c$ 用作其停止条件。

我们将首先分析在超过阈值查询的 $c=1$ 之后算法停止的情况，并表明无论查询的总序列有多长，该算法都是 $\varepsilon$-差分隐私的。然后利用我们的合成定理分析 $c>1$ 的情形，并推导出 $(\varepsilon,0)$ 和$(\varepsilon,\delta)$-差分隐私的界。