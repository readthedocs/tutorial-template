(SecPredAndSim)=
# Prediction and simulation

## Framework


Consider first the cases where the observations $y_i$ are from a
stochastic process $y(\mathbf{x})$ namely the ` Kriging` and the
`NuggetKriging` cases. Consider $n^\star$ "new" inputs
$\mathbf{x}_j^\star$ given as the rows of a $n^\star \times d$ matrix
$\mathbf{X}^\star$ and the random vector of "new" responses
$\mathbf{y}^\star := [y(\mathbf{x}_1^\star), \, \dots, \,
y(\mathbf{x}_{n^\star}^\star)]^\top$. The distribution of
$\mathbf{y}^\star$ conditional on the observations $\mathbf{y}$ is
known: this is a Gaussian distribution, characterized by its mean
vector and its covariance matrix

$$
    \mathbb{E}[\mathbf{y}^\star \, \vert \, \mathbf{y}] \quad \text{and} \quad
	\textsf{Cov}[\mathbf{y}^\star \, \vert \, \mathbf{y}].
$$

The computation of this distribution is often called *Kriging*, and
more precisely *Universal Kriging* when a linear trend
$\mu(\mathbf{x}) = \mathbf{f}(\mathbf{x})^\top \boldsymbol{\beta}$ and
a smooth unobserved GP $\zeta(\mathbf{x})$ are used, possibly with a
nugget GP $\varepsilon(\mathbf{x})$. Interestingly, the computation
can provide estimates $\widehat{\mu}(\mathbf{x})$,
$\widehat{\zeta}(\mathbf{x})$ and $\widehat{\varepsilon}(\mathbf{x})$
for the unobserved components: *trend*, *smooth GP* and *nugget*.

In the noisy case `"NoiseKriging`", the observations $y_i$ are noisy
versions of the "trend $+$ GP" process $\eta(\mathbf{x}) :=
\mu(\mathbf{x}) + \zeta(\mathbf{x})$. Under the assumption that the
$\varepsilon_i$ are Gaussian, the distribution of the random vector
$\boldsymbol{\eta}^\star := [\eta(\mathbf{x}_1^\star), \, \dots, \,
\eta(\mathbf{x}_{n^\star}^\star)]^\top$ conditional on the
observations $\mathbf{y}$ is a Gaussian distribution, characterized by
its mean vector and its covariance matrix that can be computed by
using the same Kriging equations as for the previous cases.


- **The `predict` method** will provide the conditional expectation
   $\mathbb{E}[\mathbf{y}^\star \, \vert \, \mathbf{y}]$ or
   $\mathbb{E}[\boldsymbol{\eta}^\star \, \vert \, \mathbf{y}]$ a.k.a the
   Kriging mean. The method can also provide the vector of conditional
   standard deviations or the conditional covariance matrix which can
   be called Kriging standard deviation or Kriging covariance.

- **The `simulate` method** generates partial observations from paths
   of the process $\eta(\mathbf{x})$ - or $y(\mathbf{x})$ in the non
   noisy-cases- conditional on the known observations. More precisely,
   the method returns the values $y^{[k]}(\mathbf{x}_i^\star)$ at the
   new design points for $n_{\texttt{sim}}$ independent drawings
   $k=1$, $\dots$, $n_{\texttt{sim}}$ of the process conditional on
   the observations $y_i$ for $i=1$, $\dots$, $n$. So if
   $n_{\texttt{sim}}$ is large the average $n_{\texttt{sim}}^{-1}\,
   \sum_{k=1}^{n_{\text{sim}}} y^{[k]}(\mathbf{x}^\star)$ should be
   close to the conditional expectation given by the `predict` method.

In order to give more details on the prediction, the following
notations will be used.

* $\mathbf{F}^\star := \mathbf{F}(\mathbf{X}^\star)$ is the "new" trend matrix with
  dimension $n^\star \times p$.
  
* $\mathbf{C}^\star := \mathbf{C}(\mathbf{X}^\star,\, \mathbf{X})$ is the
  $n^\star \times n$ covariance matrix between the new and the observation
  inputs. When $n^\star=1$ we have row matrix.

* $\mathbf{C}^{\star\star} := \mathbf{C}(\mathbf{X}^\star,\, \mathbf{X}^\star)$ is the
  $n^\star \times n^\star$ covariance matrix for the new inputs.

We will assume that the design matrix $\mathbf{F}$ used in the first
step has rank $p$, implying that $n \geqslant p$ observations are
used.

## Known covariance parameters

### Non-noisy cases ` Kriging` and `NuggetKriging` 

If the covariance kernel is known, the Kriging mean is given by

$$
  \mathbb{E}[\mathbf{y}^\star \, \vert \,\mathbf{y} ] =
  \underset{\text{trend}}
  {\underbrace{\mathbf{F}^\star\widehat{\boldsymbol{\beta}}}}  +
  \underset{\text{GP}}
  {\underbrace{\mathbf{C}^\star\mathbf{C}^{-1} [\mathbf{y} - \mathbf{F}\widehat{\boldsymbol{\beta}}]}},
$$

where $\widehat{\boldsymbol{\beta}}$ stands for the GLS estimate of $\boldsymbol{\beta}$.  At
the right-hand side the first term is the prediction of the trend and
the second term is the simple Kriging prediction for the GP part
$\boldsymbol{\zeta}^\star$ where the estimation
$\widehat{\boldsymbol{\zeta}} = \mathbf{y} - \mathbf{F}\widehat{\boldsymbol{\beta}}$ is used as
if it was containing the unknown observations $\boldsymbol{\zeta}$. The Kriging
covariance is given by

$$
  \textsf{Cov}[\mathbf{y}^\star \, \vert \,\mathbf{y} ] =
  \underset{\text{trend}}
  {\underbrace{[\mathbf{F}^\star - \widehat{\mathbf{F}}^\star] \,\textsf{Cov}(\widehat{\boldsymbol{\beta}})\,
      [\mathbf{F}^\star - \widehat{\mathbf{F}}^\star]^\top}} +
  \underset{\text{GP}}
  {\underbrace{
      \mathbf{C}^{\star\star} - \mathbf{C}^\star \mathbf{C}^{-1} \mathbf{C}^{\star\top}}},
$$

where $\widehat{\mathbf{F}}^\star := \mathbf{C}^\star \mathbf{C}^{-1}\mathbf{F}$ is the
simple Kriging prediction of the trend matrix. At the right-hand
side, the first term accounts for the uncertainty due to the trend. It
disappears if the estimation of $\boldsymbol{\beta}$ is perfect or if the
trend functions are perfectly predicted by Kriging. The second and
third terms are the unconditional covariance of the GP part and the
(co)variance reduction due to to the correlation of the GP between the
observations and the new inputs.

**Note**   The conditional covariance can be expressed as

$$
\textsf{Cov}[\mathbf{y}^\star \, \vert \,\mathbf{y} ] = \mathbf{C}^{\star\star} -
\begin{bmatrix}
     \mathbf{C}^\star & \mathbf{F}^\star
\end{bmatrix}
	\begin{bmatrix}
\mathbf{C} & \mathbf{F}\\
\mathbf{F}^\top & \mathbf{0}
\end{bmatrix}^{-1}
\begin{bmatrix}
\mathbf{C}^{\star\top}\\
	\mathbf{F}^{\star\top}
\end{bmatrix}.
$$
  
  The block square matrix to be inverted is not positive hence its
  inverse is not positive either. So the prediction covariance can be
  larger than the conditional covariance $\mathbf{C}^{\star\star}$ of the
  GP.  This is actually the case in the classical linear regression
  framework corresponding to the GP $\zeta(\mathbf{x})$ being a white
  noise. 

**Note** Since a stationary GP $\zeta(\mathbf{x})$ is used in the
  model, the "Kriging prediction" *returns to the trend*: for a new
  input $\mathbf{x}^\star$ which is far away from the inputs used to
  fit the model, the prediction $\widehat{y}(\mathbf{x}^\star)$ tends
  to the estimated trend $\mathbf{f}(\mathbf{x}^\star)^\top
  \widehat{\boldsymbol{\beta}}$.

### Noisy case ` NoiseKriging` 

In the noisy case we compute the expectation and covariance of
$\boldsymbol{\eta}^\star$ conditional on the observations in
$\mathbf{y}$. The formulas are identical to those used for
$\mathbf{y}^\star$ above. The matrices $\mathbf{C}^\star$ and
$\mathbf{C}^{\star\star}$ relate to the covariance kernel of the GP
$\eta(\mathbf{x})$ yet for the matrix $\mathbf{C}$, the provided noise
variances $\sigma^2_i$ must be added to the corresponding diagonal
terms.

## Plugging the covariance parameters into the prediction

In **libKriging** the prediction is computed by plugging the
correlation parameters $\boldsymbol{\theta}$ i.e., by replacing these
by their estimate obtained by optimizing the chosen objective:
*log-likelihood*, *Leave-One-Out Sum of Squared Errors*, or *marginal
posterior density*. So the *ranges $\theta_\ell$ are regarded as
perfectly known*. Similarly the GP variance $\sigma^2$ and and the
nugget variance $\tau^2$ are replaced by their estimates.

**Note** Mind that the expression *predictive distribution* used in
  {cite:t}`GuEtAl_RobusGaSp` is potentially misleading since the
  correlation parameters are simply plugged into the prediction
  instead of being marginalized out of the distribution of 
  $\mathbf{y}^\star$ conditional on $\mathbf{y}$.

## Confidence interval on the Kriging mean
   
Consistently with the non-parametric regression framework $y =
h(\mathbf{x}) + \varepsilon$ where $h$ is a function that must be
estimated, we can speak of a *confidence interval* on the unknown mean
at a "new" input point $\mathbf{x}^\star$. It must be understood that
the confidence interval is on the smooth part "*trend* $+$ *smooth
GP*" $h(\mathbf{x}^\star) = \mu(\mathbf{x}^\star) +
\zeta(\mathbf{x}^\star)$ of the stochastic process regarded as an
unknown deterministic quantity. The "trend $+$ smooth GP" model
provides a prior for the unknown function $h$ and the posterior
distribution for $h(\mathbf{x}^\star)$ is the Gaussian distribution
provided by the Kriging prediction.

Some variants of the confidence interval can easily be implemented. In
the ` Kriging` case here no nugget or noise is used, the maximum
likelihood estimate of $\sigma^2$ is biased but the *restricted
maximum-likelihood estimate* $\widehat{\sigma}_{\texttt{REML}}^2 =
\widehat{\sigma}_{\texttt{ML}}^2 \times n/ (n-p)$ is unbiased. Also
the quantiles of the Student distribution with $n-p$ degree of freedom
can be used in place of those of the normal distribution to account
for the uncertainty on $\sigma^2$. The same ideas can be used for the
` "NuggetKriging"` and ` "NoiseKriging"` cases.

## Derivative w.r.t. the input

The derivative (or gradient) of the prediction mean and of the
standard deviation vector with respect to the input vector
$\mathbf{x}^\star$ can be optionally provided. These derivatives are
required in Bayesian Optimization. The derivatives are obtained by
applying the chain rule to the expressions for the expectation and the
variance.
