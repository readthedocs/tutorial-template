
(SecBayes)=
# Bayesian marginal analysis

## Motivation and general form of prior
{cite:authors}`BergerAtAl_ObjectiveBayesSpatial` have shown that the
ML estimation of Kriging models often gives estimated ranges
$\widehat{\theta}_k = 0$ or $\widehat{\theta}_k = \infty$, leading to
poor predictions. Although finite positive bounds can be imposed in
the optimization to address this issue, the bounds are quite
arbitrary. {cite:authors}`BergerAtAl_ObjectiveBayesSpatial` have shown
that one can instead replace the ML estimates by the marginal
posterior mode in a Bayesian analysis. Provided that suitable priors
are used, it can be shown that the estimated ranges will be both
finite and positive: $0 < \widehat{\theta}_k < \infty$.

**Note**  In **libKriging** the Bayesian approach will be used only to provide
  alternatives to the ML estimation of the range or correlation
  parameters.  The Bayesian inference on these parameters will not be
  achieved. Rather than the profile likelihood, a so-called
  *marginal likelihood* will be used.

In this section we switch to a Bayesian style of notations. The vector
of parameters is formed by three blocks: the vector $\boldsymbol{\theta}$ of
correlation ranges, the GP variance $\sigma^2$ and the vector
$\boldsymbol{\beta}$ of trend parameters. A major concern is the elicitation
of the prior density $\pi(\boldsymbol{\theta}, \, \sigma^2, \,\boldsymbol{\beta})$.

## Objective priors of Gu et al

A natural idea is that the prior should not provide information about
$\boldsymbol{\beta}$, implying the use of *improper* probability
densities. With the factorization

$$
  \pi(\boldsymbol{\theta}, \, \sigma^2, \,\boldsymbol{\beta}) =
  \pi(\boldsymbol{\beta} \, \vert \, \boldsymbol{\theta}, \,\sigma^2) \times
  \pi(\boldsymbol{\theta}, \, \sigma^2),
$$

a further assumption is that the trend parameter vector $\boldsymbol{\beta}$
is a priori independent of the covariance parameters $\boldsymbol{\theta}$ and
$\sigma^2$, and that the prior for $\boldsymbol{\beta}$ is an improper prior
with constant density

$$
   \pi(\boldsymbol{\beta} \, \vert \, \boldsymbol{\theta}, \sigma^2)
        = \pi(\boldsymbol{\beta}) \propto 1.
$$

Then the problem boils down to the choice of the joint prior
$\pi(\boldsymbol{\theta}, \, \sigma^2)$. 

In the case where no nugget or noise is used, an interesting choice is

$$ 
  \tag{1}
  \pi(\boldsymbol{\theta}, \, \sigma^2) =
    \frac{\pi(\boldsymbol{\theta})}{(\sigma^2)^a}
$$

with $a >0$. With this specific form the result of the integration of
the likelihood or of the posterior density with respect to $\sigma^2$
and $\boldsymbol{\beta}$ is then known in closed form.  

## Fit: Bayesian marginal analysis

In the `Kriging` case, the *marginal likelihood*
a.k.a. *integrated likelihood* for $\boldsymbol{\theta}$ is obtained by
marginalizing the GP variance $\sigma^2$ and the trend parameter
vector $\boldsymbol{\beta}$ out of the likelihood according to

$$
  L_{\texttt{marg}}(\boldsymbol{\theta};\,\mathbf{y}) := 
  p(\mathbf{y} \, \vert \, \boldsymbol{\theta}) \propto \int
  p(\mathbf{y} \, \vert \,\boldsymbol{\theta}, \, \sigma^2, \, \boldsymbol{\beta}) \,
  \frac{1}{\sigma^{2a}} \,
  \text{d}\sigma^2\,
  \text{d}\boldsymbol{\beta},
$$

where $p(\mathbf{y} \, \vert \,\boldsymbol{\theta}, \, \sigma^2, \,
\boldsymbol{\beta})$ is the likelihood $L(\boldsymbol{\theta}, \,
\sigma^2, \, \boldsymbol{\beta};\, \mathbf{y})$. We get a closed
expression given in the [table below](TabMarglik).  Now for a prior
having the form (1), the marginal posterior factorizes as

$$
    p_{\texttt{marg}}(\boldsymbol{\theta}\,\vert \,\mathbf{y}) 
	\propto \pi(\boldsymbol{\theta}) \times  L_{\texttt{marg}}(\boldsymbol{\theta};\,\mathbf{y}).
$$

In the `NuggetKriging` case, the same approach can be used, but the
parameter used for the nugget is not marginalized out so it remains an
argument of the marginal likelihood. In **libKriging** the nugget
parameter is taken as $\alpha := \sigma^2 / (\sigma^2 + \tau^2)$ where
$\tau^2$ is the nugget variance. We then have the factorization

$$
    p_{\texttt{marg}}(\boldsymbol{\theta}, \, \alpha \,\vert \,\mathbf{y}) 
	\propto \pi(\boldsymbol{\theta},\,\alpha) \times  L_{\texttt{marg}}(\boldsymbol{\theta},\,\alpha;\,\mathbf{y}).
$$


**Note** The marginal likelihood differs from the frequentist notion
  attached to this name. But it also differs from the marginal
  likelihood as often used in the GP community e.g., in
  {cite:t}`RasmussenWilliams_GaussianProcesses` where the
  marginalization is for the values $\boldsymbol{\zeta}$ of the
  unobserved GP hence is nothing but the likelihood descrided in [this
  section](SecMLE).

(TabMarglik)=
## Table of marginal likelihood functions

The following table gives the marginal log-likelihood for the
different forms of Kriging models. The sum of squares $S^2$ is given
by $S^2 := \mathbf{e}^\top \mathring{\mathbf{C}}^{-1} \mathbf{e}$
where $\mathbf{e}:= \mathbf{y} -
\mathbf{F}\widehat{\boldsymbol{\beta}}$ and $\mathring{\mathbf{C}}$ is
the correlation matrix (equal to $\mathbf{R}$ or
$\mathbf{R}_\alpha$). The sum of squares $S^2$ can be expressed as
$S^2 = \mathbf{y}^\top \mathring{\mathbf{B}} \mathbf{y}$ where
$\mathring{\mathbf{B}} := \sigma^2 \mathbf{B}$ is a scaled version ot
the [Bending Energy matrix](SecBending) $\mathbf{B}$.


|   |   |
|:--|:--|
| `"Kriging"` | $-2 \ell_{\texttt{marg}}(\boldsymbol{\theta}) = \log \lvert\mathbf{R}\rvert + \log\lvert \mathbf{F}^\top \mathbf{R}^{-1}\mathbf{F}\rvert + (n - p + 2a - 2) \log S^2$  |
| `"NuggetKriging"` | $-2 \ell_{\texttt{marg}}(\boldsymbol{\theta}, \, \alpha) = \log \lvert\mathbf{R}_\alpha\rvert + \log\lvert \mathbf{F}^\top \mathbf{R}_\alpha^{-1}\mathbf{F}\rvert + (n - p + 2a -2) \log S^2$ |
| `"NoiseKriging"` | *not used*  |


It can be interesting to compare this table with the [table of profile
log-likelihoods](TabProflik). 



## Reference prior for the correlation parameters [not implemented yet]

For the case when no nugget or noise is used,
{cite:authors}`BergerAtAl_ObjectiveBayesSpatial` define the reference joint
prior for $\boldsymbol{\theta}$ and $\sigma^2$ in relation to the
integrated likelihood where only the trend parameter
$\boldsymbol{\beta}$ is marginalized out, that is 
$p(\mathbf{y} \, \vert \, \boldsymbol{\theta}, \, \sigma^2) \, = \int
p(\mathbf{y} \, \vert \, \boldsymbol{\theta}, \, \sigma^2, \, \boldsymbol{\beta}) \,
\text{d}\boldsymbol{\beta}$ and they show that it has the form

$$
  \pi_{\texttt{ref}}(\boldsymbol{\theta},\, \sigma^2) %% = \left|\mathbf{I}^\star(\sigma^2,\, \boldsymbol{\theta})\right|^{1/2}
  = \frac{\pi_{\texttt{ref}}(\boldsymbol{\theta})}{\sigma^2}
$$

where $\pi_{\texttt{ref}}(\boldsymbol{\theta})$ no longer depends on $\sigma^2$.

We now give some hints on the derivation and the computation of the
reference prior. Let
$\mathbf{I}^\star(\boldsymbol{\theta},\,\sigma^2)$ be the $(d+1)
\times (d+1)$ Fisher information matrix based on the marginal
log-likelihood $\ell_{\texttt{marg}}(\boldsymbol{\theta},\,\sigma^2) =
\log L_{\texttt{marg}}(\boldsymbol{\theta},\,\sigma^2)$

$$
  \mathbf{I}^\star(\boldsymbol{\theta},\, \sigma^2) := 
  \begin{bmatrix}
    -\mathbb{E}\left\{\frac{\partial^2}{\partial \boldsymbol{\theta}\partial \boldsymbol{\theta}^\top}
      \,
      \ell_{\texttt{marg}}(\boldsymbol{\theta}, \,\sigma^2 )\right\}
    & -\mathbb{E}\left\{\frac{\partial^2}{\partial \sigma^2\partial \boldsymbol{\theta}^\top}
      \,
      \ell_{\texttt{marg}}(\boldsymbol{\theta}, \,\sigma^2 )\right\}\\
    -\mathbb{E}\left\{\frac{\partial^2}{\partial \sigma^2\partial \boldsymbol{\theta}}\,
      \ell_{\texttt{marg}}(\boldsymbol{\theta}, \,\sigma^2 )\right\}
    & -\mathbb{E}\left\{\frac{\partial^2 }{\partial \sigma^2\partial \sigma^2}\,
      \ell_{\texttt{marg}}(\boldsymbol{\theta}, \,\sigma^2 )\right\}
    \rule{0pt}{1.5em}
  \end{bmatrix} =:
  \begin{bmatrix}
    \mathbf{H} & \mathbf{u}^\top\\
    \mathbf{u} & b
  \end{bmatrix}.
$$

One can show that this information matrix can be expressed by using
the $n \times n$ symmetric matrices $\mathbf{N}_k := \mathbf{L}^{-1}
\left[\partial_{\theta_k} \mathbf{R}\right] \mathbf{L}^{-\top}$ where
$\mathbf{L}$ is the lower Cholesky root of the correlation matrix
according to

$$
  \mathbf{H} = \frac{1}{2}\,
  \begin{bmatrix}
    \text{tr}(\mathbf{N}_1\mathbf{N}_1)   & \text{tr}(\mathbf{N}_1\mathbf{N}_2)
    & \dots & \text{tr}(\mathbf{N}_1\mathbf{N}_p) \\
    \text{tr}(\mathbf{N}_2\mathbf{N}_1)   & \text{tr}(\mathbf{N}_2\mathbf{N}_2)
    & \dots & \text{tr}(\mathbf{N}_2\mathbf{N}_p) \\
    \vdots  & \vdots  & &  \vdots \\
    \text{tr}(\mathbf{N}_p\mathbf{N}_1)   & \text{tr}(\mathbf{N}_p\mathbf{N}_2)
    & \dots & \text{tr}(\mathbf{N}_p\mathbf{N}_p) 
  \end{bmatrix}, \quad
  \mathbf{u} = \frac{1}{2 \sigma^2}\,
  \begin{bmatrix}
    \text{tr}(\mathbf{N}_1)\\
    \text{tr}(\mathbf{N}_2) \\
    \vdots\\
    \text{tr}(\mathbf{N}_p) 
  \end{bmatrix}, \qquad
  b = \frac{n - p}{2 \sigma^4}.
$$

By multiplying by $\sigma^2$ both the last row and the last column of
$\mathbf{I}^\star(\boldsymbol{\theta}, \, \sigma^2)$ corresponding to
$\sigma^2$, we get a new $(d+1) \times (d+1)$ matrix say
$\mathbf{I}^\star(\boldsymbol{\theta})$ which no longer depends on
$\sigma^2$, the notation $\mathbf{I}^\star(\boldsymbol{\theta})$ being
consistent with {cite:t}`GuEtAl_RobusGaSp`. Then
$\pi_{\texttt{ref}}(\boldsymbol{\theta}) = \left|
\mathbf{I}^\star(\boldsymbol{\theta}) \right|^{1/2}$.

Note that the determinant expresses as

$$
  \left| \mathbf{I}^\star(\boldsymbol{\theta}) \right| 
  = |\mathbf{H}| \times
  \left|n -p  - \mathring{\mathbf{u}}^\top \mathbf{H}^{-1} 
  \mathring{\mathbf{u}} \right| 
$$

where $\mathring{\mathbf{u}} := \sigma^2 \mathbf{u}$. See {cite:t}`Gu_Phd`
for details.

**Note**   The information matrix takes the blocks in the order:
  "$\boldsymbol{\theta}$ *then* $\sigma^2$", while the opposite order is used
  in {cite:t}`Gu_Phd`.

The reference prior suffers from its high computational cost. Indeed,
in order to get the value of the prior density one needs the
derivatives of the correlation matrix $\mathbf{R}$ and in order to use
the derivatives of the prior to find the posterior mode, the second
order derivatives of $\mathbf{R}$ are required. An alternative is
the following so-called *Jointly robust* prior.

(SecJointlyrobust)=
## The "Jointly Robust"  prior of Gu

{cite:t}`Gu_JointlyRobust` defines an easily computed prior called the
*Jointly Robust* (JR) prior. This prior is implemented in the R
package **RobustGaSP**. In the nugget case the prior is defined with some
obvious abuse of notation by

$$
  \pi_{\texttt{JR}}(\boldsymbol{\theta},\, \sigma^2, \, \alpha)  \propto
  \frac{\pi_{\texttt{JR}}(\boldsymbol{\theta}, \, \alpha)}{\sigma^2}
$$

where as above $\alpha := \sigma^2 / (\sigma^2 + \tau^2)$ so that the
nugget variance ratio $\eta := \tau^2 / \sigma^2$ of
{cite:t}`Gu_JointlyRobust` is $\eta = (1 - \alpha) / \alpha$. The JR
prior corresponds to

$$
  \pi_{\texttt{JR}}(\boldsymbol{\theta}, \, \alpha)  \propto t^{a_{\texttt{JR}}}
  \exp\{ -b_{\texttt{JR}}t\} \qquad
  t :=  \frac{1 - \alpha}{\alpha} + \sum_{\ell= 1}^d \frac{C_\ell}{\theta_\ell},
$$

where $a_{\texttt{JR}}> -(d + 1)$ and $b_{\texttt{JR}} >0$ are two
hyperparameters and $C_\ell$ is proportional to the range $r_\ell$ of
the column $\ell$ in $\mathbf{X}$

$$
  C_\ell = n^{-1/d} \times r_\ell, \qquad r_\ell :=
  \max_i\{X_{i\ell}\} -\min_i\{X_{i\ell}\}.
$$

The values of $a_{\texttt{JR}}$ and $b_{\texttt{JR}}$ are chosen as

$$
  a_{\texttt{JR}} := 0.2, \qquad b_{\texttt{JR}} := 
  n^{-1/d} \times (a_{\texttt{JR}} + d).
$$

Note that as opposed to the objective prior described above, the JR
prior does not depend on the specific kernel chosen for the
GP. However the integration w.r.t.  $\sigma^2$ and $\boldsymbol{\beta}$ is the
same as for the reference prior, which means that the marginal
likelihood is the same as for the reference prior above corresponding
to $a = 1$ in the prior (1) above.

**Caution** The parameter $a_{\texttt{JR}}$ is denoted by $a$ in
{cite:t}`Gu_JointlyRobust` and in the code of **libKriging**. It
differs from the exponent $a$ of $\sigma^{-2}$ used above.

