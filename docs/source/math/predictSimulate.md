(PredAndSim)=
# Prediction and simulation

## Framework

For all types of Kriging models we can consider $\New{n}$ "new"
inputs $\New{\mathbf{x}}_i$ given as the rows of a $\New{n} \times d$
matrix $\New{\mathbf{X}}$. The distribution of the random vector
$\New{\mathbf{y}} := [y(\New{\mathbf{x}}_1), \, \dots, \,
y(\New{\mathbf{x}}_{\New{n}})]^\top$ conditional on $\mathbf{y}$ is known: this
is a Gaussian distribution, characterized by its mean vector and its
covariance matrix.

The `predict` method will provide the conditional expectation
$\mathbb{E}[y(\New{\mathbf{x}}) \, \vert \, \mathbf{y}]$ a.k.a the Kriging mean. The
method can also provide the vector of conditional standard deviations
or the conditional covariance matrix which can be called Kriging
standard deviation or Kriging covariance.  Consistently with the
non-parametric regression framework $y = h(\mathbf{x}) + \varepsilon$ where
$h$ is a function that must be estimate, we can speak of a
*confidence interval* on the unknown mean at a "new"
$\New{\mathbf{x}}$. It must be understood that the confidence interval is
on the smooth part "*trend* $+$ *GP*"
$\mu(\mathbf{x}) + \zeta(\mathbf{x})$ of the stochastic process regarded as an
unknown deterministic quantity.

In order to give more details on the prediction, the following
notations will be used.
* $\New{\mathbf{F}} = \mathbf{F}(\New{\mathbf{X}})$ is the "new" trend matrix with
  dimension $\New{n} \times p$.
* $\New{\mathbf{C}} = \mathbf{C}(\New{\mathbf{X}},\, \mathbf{X})$ is the
  $\New{n} \times n$ covariance matrix between the new and the observation
  inputs. When $\New{n}=1$ we have row matrix.
* $\NewNew{\mathbf{C}} = \mathbf{C}(\New{\mathbf{X}},\, \New{\mathbf{X}})$ is the
  $\New{n} \times \New{n}$ covariance matrix for the new inputs.

## Known covariance kernel

If the covariance kernel is known, the Kriging mean is given by

$$
  \mathbb{E}[\New{\mathbf{y}} \, \vert \,\mathbf{y} ] =
  \underset{\text{trend}}
  {\underbrace{\New{\mathbf{F}}\widehat{\boldsymbol{\beta}}}}  +
  \underset{\text{GP}}
  {\underbrace{\New{\mathbf{C}}\mathbf{C}^{-1} [\mathbf{y} - \mathbf{F}\widehat{\boldsymbol{\beta}}]}},
$$

where $\widehat{\boldsymbol{\beta}}$ stands for the GLS estimate of $\boldsymbol{\beta}$.  At
the right-hand side the first term is the prediction of the trend and
the second term is the simple Kriging prediction for the GP part
$\New{\boldsymbol{\zeta}}$ where the estimation
$\widehat{\boldsymbol{\zeta}} = \mathbf{y} - \mathbf{F}\widehat{\boldsymbol{\beta}}$ is used as
if it was containing the unkown observations $\boldsymbol{\zeta}$. The Kriging
covariance is given by

$$
  \Cov[\New{\mathbf{y}} \, \vert \,\mathbf{y} ] =
  \underset{\text{trend}}
  {\underbrace{[\New{\mathbf{F}} - \NewHat{\mathbf{F}}] \,\Cov(\widehat{\boldsymbol{\beta}})\,
      [\New{\mathbf{F}} - \NewHat{\mathbf{F}}]^\top}} +
  \underset{\text{GP}}
  {\underbrace{
      \NewNew{\mathbf{C}} - \New{\mathbf{C}} \mathbf{C}^{-1} \NewT{\mathbf{C}}}},
$$

where $\NewHat{\mathbf{F}} := \New{\mathbf{C}} \mathbf{C}^{-1}\mathbf{F}$ is the
simple Kriging prediction of the trend matrix. At the right-hand
side the first term accounts for the uncertainty due to the trend. It
disappears if the estimation of $\boldsymbol{\beta}$ is perfect or if the
trend functions are perfectly predicted by Kriging. The second and
third terms are the unconditional covariance of the GP part and the
(co)variance reduction due to to the correlation of the GP between the
observations and the new inputs.

**Note**   The conditional covariance can be expressed as

$$
  \Cov[\New{\mathbf{y}} \, \vert \,\mathbf{y} ] = \NewNew{\mathbf{C}} -
  \begin{bmatrix}
     \New{\mathbf{C}} & \New{\mathbf{F}}
  \end{bmatrix}
  \begin{bmatrix}
     \mathbf{C} & \mathbf{F}\\
     \mathbf{F}^\top & \mathbf{0}
  \end{bmatrix}^{-1}
  \begin{bmatrix}
    \NewT{\mathbf{C}}\\
	\NewT{\mathbf{F}}
   \end{bmatrix}.
$$
  
  
  The block square matrix to be inverted is not positive hence its
  inverse is not positive either. So the prediction covariance can be
  larger than the conditional covariance $\NewNew{\mathbf{C}}$ of the
  GP.  This is actually the case in the classical linear regression
  framework corresponding to the GP $\zeta(\mathbf{x})$ being a white
  noise. 

**Note**   Since a stationary GP $\zeta(\mathbf{x})$ is used in the model, the
  "Kriging prediction" *returns to the trend*: for a new
  input $\New{\mathbf{x}}$ which is far away from the inputs used to fit
  the model, the prediction $\widehat{y}(\New{\mathbf{x}})$ tends to the
  estimated trend $\mathbf{f}(\New{\mathbf{x}})^\top \widehat{\boldsymbol{\beta}}$.

## Unknown covariance kernel

In **libKriging** the prediction is computed by plugging the correlation
parameters $\boldsymbol{\theta}$ i.e., by replacing these by their estimate
obtained by optimizing the chosen objective: likelihood, LOO MSE or
posterior marginal density. So the ranges $\theta_\ell$ are regarded
as perfectly known. However the uncertainty on the GP variance
$\sigma^2$ and on the nugget variance $\tau^2$ can be taken into
account as follows.

### Class `"Kriging"`

In the `Kriging` case where no nugget or noise is used, the
impact of the unknown GP variance $\sigma^2$ on the prediction can be
assessed. We can replace $\sigma^2$ by the Restricted Maximum
Likelihood estimate
$\widehat{\sigma}_{\texttt{REML}}^2 := S^2/(n -p)$, which is
unbiased. We know that $\widehat{\sigma}_{\texttt{REML}}^2/\sigma^2$
follows a Student distribution with $n-p$ degrees of freedom. This
allows the derivation of a confidence interval on the mean in the
frequentist case, and of a credible interval in the Bayesian case.

**Note**   See [@GuEtAl_RobusGaSp].  Mind that the expression
  *predictive distribution* used in [@GuEtAl_RobusGaSp]
  is potentially misleading since the correlation parameters are
  simply plugged into the prediction instead of being marginalized out
  of it.

**Note**   Remind that when the profile likelihood is used the unbiased
  estimate $\widehat{\sigma}_{\texttt{REML}}^2$ relates to the ML
  estimate according to
  $\widehat{\sigma}_{\texttt{REML}}^2 =
  \widehat{\sigma}_{\texttt{ML}}^2 \times (n-p)/n$.

### Class `"NuggetKriging"`

In the `"NuggetKriging"` case, estimates are obtained for
the variance $\nu^2 := \sigma^2 + \tau^2$ and for the ratio
$\alpha := \sigma^2 / (\sigma^2 + \tau^2)$. From these, the ML
estimate of $\sigma^2$ results as $\widehat{\sigma}^2 = \widehat{\alpha}
\widehat{\nu}^2$. Using the same bias correction as in the
`"Kriging"` case a confidence interval on the mean can be given,
involving the quantiles of the Student distribution with $n - p$
degrees of freedom.

## Derivative w.r.t. the input

The derivative (or gradient) of the prediction mean and of the
standard deviation vector with respect to the input vector
$\New{\mathbf{x}}$ can be optionally provided. These derivatives are
required in Bayesian Optimization. The derivatives are obtained by
applying the chain rule to the expressions for the expectation and the
variance.
