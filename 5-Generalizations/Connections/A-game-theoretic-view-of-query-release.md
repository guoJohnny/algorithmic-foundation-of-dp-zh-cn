# 5.3.3 查询发布的博弈论观点

在本节中，我们将短暂停留在博弈论中，以解释我们拥有（并将看到）的一些查询发布算法。让我们考虑两个敌对玩家Alice和Bob之间的交互。Alice有一组她可能采取的行动，$\mathcal{A}$，而Bob有一组行动$\mathcal{B}$。游戏按以下方式进行：Alice选择了一些行动$a\in\mathcal{A}$（可能随机选择），同时Bob也选择一些行动$b\in\mathcal{B}$（可能随机选择）。爱丽丝经历了代价$c(a,b)\in[-1,1]$。Alice希望在进行游戏中最小化此成本，并且由于Bob是对抗性的，他希望在游戏中*最大化* 此成本。 这就是所谓的*零和* 博弈。

那么爱丽丝应该怎么玩呢？ 首先，我们考虑一个更简单的问题。假设我们给Alice设置阻碍并要求她在玩之前向Bob宣布她的随机策略，并让Bob使用这些信息做出最佳反应？如果Alice宣布她将根据概率分布$\mathcal{D}_A$ 进行一些行动$a\in\mathcal{A}$，那么Bob将做出最优响应以最大化Alice的期望成本。 也就是说，鲍勃会做出行动使：
$$
b^*=arg\space\max_{b\in\mathcal{B}}\mathbb{E}_{a\sim\mathcal{D}_A}[c(a,b)]
$$
因此，一旦Alice宣布了她的策略，她就知道她的成本是多少，因为Bob将能够做出最佳响应。所以，*一旦Bob响应*，Alice将希望对动作进行分配以*最小化* 她的成本。也就是说，Alice希望使用定义为：
$$
\mathcal{D}_A=arg\space\min_{\mathcal{D}\in\Delta\mathcal{A}}\max_{b\in\mathcal{B}}\mathbb{E}_{a\sim\mathcal{D}}[c(a,b)]
$$
的一个分布$\mathcal{D}_A$。

