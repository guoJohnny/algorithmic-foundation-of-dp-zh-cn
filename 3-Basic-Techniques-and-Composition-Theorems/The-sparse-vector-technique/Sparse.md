# 3.6.1 稀疏算法

现在，我们展示如何使用合成技术处理多个“高于阈值”的查询。

稀疏算法可以认为是：当查询进入时，它会反复调用 **AboveThreshold**。 每次报告高于阈值的查询后，该算法仅在 **AboveThreshold** 的新实例上重新启动剩余的查询流。在重新启动**AboveThreshold** $c$ 次之后停止（即在出现 $c$ 个高于阈值的查询之后）。 由于 **AboveThreshold** 的每个实例都是$(\varepsilon,0)$- 差分隐私的，因此适用合成定理。

![Sparse](/3-Basic-Techniques-and-Composition-Theorems/The-sparse-vector-technique/img/Sparse.png)

**定理 3.25** 稀疏算法是 $(\varepsilon,\delta)$-差分隐私的。

**【证明】** 我们发现到 **Sparse** 算法完全等同于以下过程：我们对查询流 $\{f_i\}$ 运行 **AboveThreshold** 算法 $(D,\{f_i\},T,\varepsilon')$，并设置：

$$
\varepsilon' = \begin{cases}
   \frac{\varepsilon}{c} &\text{if } \delta = 0 ;\\
   \frac{\varepsilon}{\sqrt{8c\ln \frac{1}{\delta}}} &\text{Otherwise.}
\end{cases}
$$

使用 **AboveThreshold** 算法提供答案。当 **AboveThreshold** 算法停止时（在回答了1个超过阈值的查询之后），我们只需在剩余的查询流上重新启动 **Sparse**算法$(D,\{f_i\},T,\varepsilon')$ ，并继续这个过程直到我们重新启动 **AboveThreshold** 算法 $c$ 次。第 $c$ 次 **AboveThreshold** 算法停止后，**Sparse**算法 也停止。我们已经证明了**AboveThreshold** 算法 $(D,\{f_i\},T,\varepsilon')$ 是$(\varepsilon',0)$-差分隐私的。最后，根据高级合成定理（[**定理 3.20 和 推论 3.21**](/3-Basic-Techniques-and-Composition-Theorems/Composition-theorems/Advanced-composition.html)），$c$ 个
 $\varepsilon' = \frac{\varepsilon}{\sqrt{8c\ln \frac{1}{\delta}}}$-差分隐私算法的合成是 $(\varepsilon,\delta)$ -差分隐私，并且 $c$ 个 $\varepsilon' = \varepsilon/c$- 差分隐私算法的合成是 $(\varepsilon,0)$ -差分隐私。

 需要证明 包含 $c$ 个 **AboveThreshold** 算法 的 **Sparse** 算法的准确性。我们注意到，如果对于每个 **AboveThreshold** 算法 $(\alpha,\beta/c)$ 精确的，那么 **Sparse** 算法将是 $(\alpha,\beta)$ 精确的。

 **【定理 3.25 证毕】**

 **定理 3.26** 对于 k 个查询的任何序列，$f_1,...,f_k$ 使得 $L(T)\equiv|\{i:f_i(D)\geq T - \alpha\}|\leq c$。如果 $\delta >0$，当：
 
$$
\alpha = \frac{(\ln k+\ln\frac{2c}{\beta})\sqrt{512c\ln\frac{1}{\delta}}}{\varepsilon}
$$

**Sparse** 算法是 $(\alpha,\beta)$ 精确的。 

如果 $\delta =0$，当：

$$
\alpha = \frac{8x(\ln k + \ln(2c/\beta))}{\varepsilon}
$$

**Sparse** 算法是 $(\alpha,\beta)$ 精确的。 

**【证明】** 运用 [**定理3.24**](/3-Basic-Techniques-and-Composition-Theorems/The-sparse-vector-technique/AboveThreshold.html) 的证明方法，将 $\beta$ 设为$\beta/c$，并分别根据 $\delta > 0$ 或 $\delta=0$ 将 $\varepsilon$ 设为 $\frac{\varepsilon}{\sqrt{8c\ln \frac{1}{\delta}}}$ 和 $\varepsilon/c$ 即可。

