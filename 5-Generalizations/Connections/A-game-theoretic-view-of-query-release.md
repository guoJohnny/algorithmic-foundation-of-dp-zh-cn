# 5.3.3 查询发布的博弈论观点

在本节中，我们将短暂停留在博弈论中，以解释我们拥有（并将看到）的一些查询发布算法。让我们考虑两个敌对玩家Alice和Bob之间的交互。Alice有一组她可能采取的行动，$$\mathcal{A}$$，而Bob有一组行动$$\mathcal{B}$$。博弈按以下方式进行：Alice选择了一些行动$$a\in\mathcal{A}$$（可能随机选择），同时Bob也选择一些行动$$b\in\mathcal{B}$$（可能随机选择）。Alice经历了成本$$c(a,b)\in[-1,1]$$。Alice希望在进行博弈中最小化此成本，并且由于Bob是对抗性的，他希望在博弈中*最大化* 此成本。 这就是所谓的*零和* 博弈。

那么Alice应该怎么玩呢？ 首先，我们考虑一个更简单的问题。假设我们给Alice设置阻碍并要求她在玩之前向Bob宣布她的随机策略，并让Bob使用这些信息做出最佳反应？如果Alice宣布她将根据概率分布$$\mathcal{D}_A$$ 进行一些行动$$a\in\mathcal{A}$$，那么Bob将做出最优响应以最大化Alice的期望成本。 也就是说，鲍勃会做出行动使：
$$
b^*=arg\space\max_{b\in\mathcal{B}}\mathbb{E}_{a\sim\mathcal{D}_A}[c(a,b)].
$$
因此，一旦Alice宣布了她的策略，她就知道她的成本是多少，因为Bob将能够做出最佳响应。所以，*一旦Bob响应*，Alice将希望对动作进行分配以*最小化* 她的成本。也就是说，Alice希望使用定义为：
$$
\mathcal{D}_A=arg\space\min_{\mathcal{D}\in\Delta\mathcal{A}}\max_{b\in\mathcal{B}}\mathbb{E}_{a\sim\mathcal{D}}[c(a,b)].
$$
的一个分布$$\mathcal{D}_A$$。

如果她执行$$\mathcal{D}_A$$（Bob是最优响应），Alice将经历她能保证的最低成本，但她必须提前宣布她的策略。 对Alice来说，这样的策略被称为最小-最大（$$min-max$$）策略。 让我们把Alice在使用最小-最大策略时获得的成本称为博弈的Alice的值， 记为$$v^A$$：
$$
v^A=\min_{\mathcal{D}\in\Delta\mathcal{A}}\max_{b\in\mathcal{B}}\mathbb{E}_{a\sim\mathcal{D}}[c(a,b)].
$$
我们同样可以问Bob应该怎么做，如果我们让他处于劣势，并迫使他首先向Alice宣布他的策略。 如果他这样做了，当Alice做出最优反应时，他将在行动$$b\in\mathcal{B}$$上执行分配$$\mathcal{D}_B$$以使Alice的期望成本*最大化*。对于Bob，我们称这样的策略$$\mathcal{D}_B$$为最大-最小（$$max-min$$）策略。我们可以定义Bob在这个博弈中的值，$$v^B$$，作为他可能宣布的任何策略所能确保的最大成本： 
$$
v^B=\max_{\mathcal{D}\in\Delta\mathcal{B}}\min_{a\in\mathcal{A}}\mathbb{E}_{b\sim\mathcal{D}}[c(a,b)].
$$
明显地，$$v^B\leq v^A$$，因为宣布自己的策略只是一个障碍。 

博弈论的基础结果之一是冯-诺伊曼的最小-最大（$$min-max$$）定理，它指出在任何零和对策中，$$v^B= v^A$$。$$^2$$（注：引用冯·诺伊曼的话说：“据我所知，没有这个定理，就不可能有博弈论。 ... 我以为在极大极小定理（Minimax Theorem）被证明之前，没有什么值得发表的。“ ）换句话说，在零和博弈中“先走”没有坏处，如果玩家玩得最优，我们可以准确地预测Alice的成本： 它将是$$v^A=v^b\equiv v$$，我们称之为博弈的值。

**定义 5.7** 在一个由行动集合$$\mathcal{A},\mathcal{B}$$和成本函数$$c:\mathcal{A}\times\mathcal{B}\to[-1,1]$$定义的零和博弈中，令$$v$$为博弈的值。一个$$\alpha-$$近似的最小-最大策略是这样的分布$$\mathcal{D}_A$$：
$$
\max_{b\in\mathcal{B}}\mathbb{E}_{a\sim\mathcal{D}_A}[c(a,b)]\leq v+\alpha
$$
相似的，一个$$\alpha-$$近似的最大-最小策略是这样的分布$$\mathcal{D}_B$$：
$$
\min_{a\in\mathcal{A}}\mathbb{E}_{b\sim\mathcal{D}_B}[c(a,b)]\geq v-\alpha
$$
如果$$\mathcal{D}_A$$和$$\mathcal{D}_B$$都分别是$$\alpha-$$近似的最小-最大策略和最大-最小策略，我们说这对$$(\mathcal{D}_A,\mathcal{D}_B)$$是零和博弈的$$\alpha-$$近似纳什均衡。 

那么这与查询发布有什么关系呢？ 

考虑一个特殊的零和博弈，该博弈是针对在数据域$$\mathcal{X}$$上发布一组线性查询$$\mathcal{Q}$$的问题设计的。首先，在不丧失一般性的情况下假定对于每一个$$f\in \mathcal{Q}$$， 存在一个查询$$\hat{f}\in\mathcal{Q}$$使得$$\hat{f}=1-f$$（例如：对于每一个$$\chi\in\mathcal{X},\hat{f}(\chi)=1-f(\chi)$$）。将Alice的行动集合定义为$$\mathcal{A}=\mathcal{X}$$，将Bob的行动集合定义为$$\mathcal{B}=\mathcal{Q}$$。我们将Alice称为*数据库玩家*，Bob称为*查询玩家*。 最后，将一个真正的私有数据库$$x$$归一化为一个概率分布 （例如：$$||x||_1=1$$），定义成本函数$$c:\mathcal{A}\times\mathcal{B}\to[-1,1]$$为：$$c(\chi,f)=f(\chi)-f(x)$$。让我们称这个博弈为“查询发布博弈”。 

我们从一个简单的观察开始： 

**命题 5.16.** 查询发布博弈的值是$$v=0$$。

【证明】我们首先证明$$v^A=v\leq0$$。考虑一下，如果我们让数据库玩家的策略对应于真正的数据库：$$\mathcal{D}_A=x$$会发生什么。 那么我们有： 
$$
\begin{aligned}
v^A&\leq\max_{f\in\mathcal{B}}\mathbb{E}_{\chi\sim\mathcal{D}_A}[c(\chi,f)]\\
&=\max_{f\in\mathcal{B}}\sum_{i=1}^{|\mathcal{X}|}f(\chi_i)\cdot x_i-f(x)\\
&=f(x)-f(x)\\
&=0.
\end{aligned}
$$
（译者注：第一个等号是将$$c_i(\chi_i,f)=f(\chi_i)-f(x)$$带入右式，得到$$\max_{f\in\mathcal{B}}\sum_{i=1}^{|\mathcal{X}|}f(\chi_i)\cdot x_i-f(x)\sum_{i=1}^{|\mathcal{X}|}x_i$$，又因为$$\mathcal{D}_A=x$$，所以$$\sum_{i=1}^{|\mathcal{X}|}x_i=1$$，这样就得到了第一个等式。第二个等号就需要使用到$$\hat{f}=1-f$$这个条件，由该条件和线性查询$$f:\mathcal{X}\to[0,1]$$这两个条件可知：$$\forall f(\chi_i)\leq1$$，所以最大$$f(\chi_i)=1$$，带入第二个等式就得到了第三个等式。）

接下来我们观察到$$v=v^B\geq0$$。对于矛盾点，假设$$v<0$$。换句话说，存在一个分布$$\mathcal{D}_A$$使得对于所有$$f\in\mathcal{Q}$$
$$
\mathbb{E}_{\chi\sim\mathcal{D}_A}c(\chi,f)<0
$$
在这里，我们简单地注意到，根据定义， 如果$$\mathbb{E}_{\chi\sim\mathcal{D}_A}c(\chi,f)=c<0$$，那么$$\mathbb{E}_{\chi\sim\mathcal{D}_A}c(\chi,\hat{f})=-c>0$$，矛盾，因为$$\hat{f}\in\mathcal{Q}$$。（译者注：所以$$v=0$$）

