(SecParam)=
## Parameters

The parameters of the models are given in the Table below. Note that
the trend parameters in $\boldsymbol{\beta}$ are of a somewhat
different nature than the other ones. The parameters $\beta_k$ can
best be compared to the values $\zeta(\mathbf{x}_i)$ of the unobserved
GP. Indeed if no nugget or noise is used, the estimation of
$\boldsymbol{\beta}$ is the same thing as the estimation of
$\boldsymbol{\zeta}$.

The trend parameters $\beta_j$ never appear in the objective function
used to fit the models, be it of frequentist or Bayesian nature.

|   | Trend  | GP Cov  | Noise/Nug.   | Optim  |
|:--|:--|:--|:--|:--|
| `"Kriging"`  | $\boldsymbol{\beta}$ | $[\boldsymbol{\theta}, \, \sigma^2]$ |   | $\boldsymbol{\theta}$  |
| `"NuggetKriging"`| $\boldsymbol{\beta}$  | $[\boldsymbol{\theta}, \, \sigma^2]$  |  $\tau^2$   | $[\boldsymbol{\theta}, \,\alpha]$, $\alpha:=\sigma^2/(\sigma^2 + \tau^2)$  |
| `"NoiseKriging"` | $\boldsymbol{\beta}$  | $[\boldsymbol{\theta}, \, \sigma^2]$  | $[\tau_i^2]$  | $[\boldsymbol{\theta}, \, \sigma^2]$  |

Parameters used for the trend, the smooth GP
and the noise or nugget parts. The column **Optim** is for
the parameters used in the optimization. The other parameters are
either known as $[\tau_i^2]$ or marginalized out, or replaced by
their MLE e.g. for $\boldsymbol{\beta}$.

## Functional point of view

For the models used with **libKriging**, both the trend functions and
the covariance kernel have an impact. While a GP model for
$\zeta(\mathbf{x})$ relates to a covariance kernel and to the
corresponding Reproducing Kernel Hilbert Space (RKHS), a Kriging model
as described in [](SecKrigingModels) relates to a *semi-RKHS*
{cite:t}`BerlinetThomasagnant_RKHS`.  This space $\mathcal{H}$ is a
semi-Hilbert space of functions in which the trend functions $f_k$
generate a finite-dimensional linear subspace $\mathcal{F}$ called the
*nullspace* which contains so-called *unpenalized* functions i.e.,
functions with (semi) norm zero.

When the covariance parameters are known, Kriging provides as the
*Kriging mean* the function $h \in \mathcal{H}$ which minimises the
Penalized Sum of Squares (PSS) criterion

$$
  \label{eq:PSS}
  \texttt{PSS} := \frac{1}{\tau^2} \,
  \sum_{i=1}^n \{y_i - h(\mathbf{x}_i)\}^2 + \| h \|_{\mathcal{H}}^2.
$$

In the case where no nugget is used (corresponding to $\tau^2 \to 0$),
the discrete sum in the $\texttt{PSS}$ criterion is actually zero at the
optimum so that $h$ interpolates the data and has minimal norm
$\|.\|_{\mathcal{H}}$ amongst the functions $h \in \mathcal{H}$ that
interpolates the data. We may regard Kriging as using a prior on a
functional space, with an implied non-informative prior for the trend
part. At the right-hand side of the equation above, the first term can be
regarded as $-2 \log L$ where $L$ is the likelihood while the square
norm can *formally* be regarded as $-2 \log \pi(h)$ where
$\pi(h)$ is a prior density, although this is not tenable from a
theoretical point of view. By minimizing $\texttt{PSS}$, we get the
function $h$ with maximum posterior density which is also the
posterior mean.

The Kriging framework is similar to the splines framework, but as
opposed to the later one, the trend functions are chosen quite
arbitrarily and may also belong to the RKHS of the kernel. This will
indeed be the case when $d=1$ and a constant trend is used with one of
the kernels available in **libKriging**: the constant trend function
is therefore unpenalized, which makes the Kriging smoothing and the
Kriging prediction behave well w.r.t. a translation of the
observations $\mathbf{y} \to \mathbf{y} + \text{Cst}$: the predicted
values are then translated similarly. The function $h \in \mathcal{H}$
minimizing the criterion $\texttt{PSS}$ above can be written in a
non-unique way as

$$
h(\mathbf{x}) = \sum_{i=1}^n \alpha_i \, C(\mathbf{x}_i, \, \mathbf{x})
+ \sum_{k=1}^p \beta_k f_k(\mathbf{x}),
$$

and Kriging indeeds find suitable vectors $\boldsymbol{\alpha}$ and
$\boldsymbol{\beta}$. The representation of $h$ can be made unique by
imposing orthogonality constraints, see [](SecBending).  See
{cite:t}`Wahba_Improper` and {cite:t}`OHagan_CurveFit` for the use of
an improper prior on the coefficients of the trend functions.

**Note** Allowing for a non-informative trend has an important
  implication in terms of implementation since *Universal Kriging*
  equations must be used. By contrast, an informative trend can be
  coped with by using only *Simple Kriging* equations and sum of
  kernels. Indeed the informative trend corresponds to a kernel of the
  form $\mathbf{f}(\mathbf{x})^\top \mathbf{A}\mathbf{f}(\mathbf{x})$
  where $\mathbf{A}$ is a $p \times p$ positive definite matrix. The
  informative approach is most often retained in the Machine Learning
  community.
