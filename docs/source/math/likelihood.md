(SecMLE)=
# Maximum likelihood

## General form of the likelihood

The general form of the likelihood is

$$
  L(\boldsymbol{\psi}, \, \boldsymbol{\beta}; \, \mathbf{y})
  = \frac{1}{\left[2 \pi\right]^{n/2}} \,
  \frac{1}{|\mathbf{C}|^{1/2}} \,
  \exp\left\{
    -\frac{1}{2} 
    \left[\mathbf{y} - \mathbf{F}\boldsymbol{\beta} \right]^\top \mathbf{C}^{-1}
    \left[\mathbf{y} - \mathbf{F}\boldsymbol{\beta} \right]
    \right\}
$$

where $\boldsymbol{\psi}$ is the vector of covariance parameters which
depend on the specific Kriging model used, see the section
[Parameters](SecParam). The notation $|\mathbf{C}|$ is for the
determinant of the matrix $\mathbf{C}$. 

(SecMLProf)=
## Profile likelihood

In the ML framework it turns out that at least the ML estimate
$\widehat{\boldsymbol{\beta}}$ of the trend coefficient vector can be
computed by GLS as exposed in Section [](SecGLS). Moreover the GLS
step can provide an estimate of the variance for the non-trend part
component i.e., the difference between the response and the trend
part. See :cite:t:`RoustantEtAl_DiceKriging` .

This allows the maximization of a *profile likelihood* function
$L_{\texttt{prof}}$ depending on a smaller number of parameters. In
practice the log-likelihood $\ell := \log L$ and the log-profile
likelihood $\ell_{\texttt{prof}} := \log L_{\texttt{prof}}$ are
used. The profile log-likelihood functions are detailed and summarized
in the [Table below](TabProflik).

Remind that if we replace $\boldsymbol{\beta}$ by its estimate
$\widehat{\boldsymbol{\beta}}$ in the sum of squares used in the
log-likelihood, we get a quadratic form of $\mathbf{y}$

$$
 \left[\mathbf{y} - \mathbf{F}\widehat{\boldsymbol{\beta}} \right]^\top \mathbf{C}^{-1}
 \left[\mathbf{y} - \mathbf{F}\widehat{\boldsymbol{\beta}} \right] = 
  \mathbf{y}^\top \mathbf{B} \mathbf{y}
$$
where $\mathbf{B}$ is the [Bending Energy Matrix](SecBending) (BEM).

### `"Kriging"`

In the `"Kriging"` case where
$\mathbf{C} = \sigma^2 \, \mathbf{R}(\boldsymbol{\theta})$, both the ML estimates
$\widehat{\boldsymbol{\beta}}$ and $\widehat{\boldsymbol{\sigma}}^2$ are provided by
GLS. So these parameters are "concentrated out of the likelihood"
and we can use the profile likelihood function depending on
$\boldsymbol{\theta}$ only
$L_{\texttt{prof}}(\boldsymbol{\theta}) := L(\boldsymbol{\theta}, \,
\widehat{\sigma}^2,\, \widehat{\boldsymbol{\beta}})$ where both
$\widehat{\sigma}^2$ and $\widehat{\boldsymbol{\beta}}$ depend on
$\boldsymbol{\theta}$.


### `"NuggetKriging"`

In the `"NuggetKriging"` case, beside the vector $\boldsymbol{\theta}$ of
correlation ranges and instead of the couple of parameters
$[\sigma^2, \, \tau^2]$ or $[\sigma^2, \, \alpha]$ we can use the couple
$[\nu^2,\, \alpha]$ defined by

$$
\nu^2:= \sigma^2 + \tau^2, \quad \alpha := \sigma^2 / \nu^2
$$

and which can be named the total variance and the variance ratio.
The covariance matrix used in the
likelihood is then

$$
\mathbf{C} = \sigma^2 \mathbf{R}(\boldsymbol{\theta}) + \tau^2 \mathbf{I}
= \nu^2 \left\{\alpha \mathbf{R}(\boldsymbol{\theta}) + (1 - \alpha) \mathbf{I}_n \right\}
= \nu^2 \mathbf{R}_\alpha(\boldsymbol{\theta}),
$$

where $\mathbf{R}_\alpha$ is a correlation matrix. As for the Kriging
case the ML estimate $\widehat{\nu}^2$ can be obtained by GLS as
$\widehat{\nu}^2 = S^2/n$. Therefore we can use a profile likelihood
function depending on the correlation ranges $\boldsymbol{\theta}$ and
the variance ratio $\alpha$, namely
$L_{\texttt{prof}}(\boldsymbol{\theta},\,\alpha) :=
L(\boldsymbol{\theta}, \, \widehat{\nu}^2,\,
\widehat{\boldsymbol{\beta}})$.

### `"NoiseKriging"`

The covariance matrix to be used in the likelihood is

$$
\mathbf{C} = \sigma^2 \mathbf{R}(\boldsymbol{\theta}) + \text{diag}([\tau^2_i]) 
$$

where the noise variances $\tau_i^2$ are known.  In this case the
parameter $\sigma^2$ can no longer be concentrated out and the profile
likelihood to be maximized is a function of $\boldsymbol{\theta}$ and
$\sigma^2$ with only the trend parameter being concentrated out
$L_{\texttt{prof}}(\boldsymbol{\theta},\,\sigma^2) := L(\boldsymbol{\theta}, \,
\widehat{\boldsymbol{\beta}})$.

(TabProflik)=
### Table 
 
The following table gives the profile log-likelihood for the different
forms of Kriging models. The sum of squares $S^2$ is given by $S^2 =
\mathbf{e}^\top \mathring{\mathbf{C}}^{-1} \mathbf{e}$ where
$\mathbf{e}:= \mathbf{y} - \mathbf{F}\widehat{\boldsymbol{\beta}}$ is
the estimated non-trend component and $\mathring{\mathbf{C}}$ is the
correlation matrix (equal to $\mathbf{R}$ or $\mathbf{R}_\alpha$).

|   |   |
|:--|:--|
| `"Kriging"` |  $-2 \ell_{\texttt{prof}}(\boldsymbol{\theta}) = \log \lvert\mathbf{R}\rvert + n \log S^2$  |
|`"NuggetKriging"` | $-2 \ell_{\texttt{prof}}(\boldsymbol{\theta}, \, \alpha) = \log \lvert\mathbf{R}_\alpha\rvert + n \log S^2$  |
|`"NoiseKriging`" | $-2 \ell_{\texttt{prof}}(\boldsymbol{\theta}, \, \sigma^2) = \log \lvert\mathbf{C}\rvert + \mathbf{e}^\top \mathbf{C}^{-1}\mathbf{e}$  |

Note that $\widehat{\boldsymbol{\beta}}$ and $\mathbf{e}$ depend
on the covariance parameters as do the correlation or covariance
matrix. The profile log-likelihood are given up to additive constants. The 
sum of squares $S^2$ can be expressed as $S^2 =
\mathbf{y}^\top \mathring{\mathbf{B}} \mathbf{y}$ where $\mathring{\mathbf{B}} := \sigma^2 \mathbf{B}$
is a scaled version ot the  [Bending Energy matrix](SecBending) $\mathbf{B}$.

### Derivatives w.r.t. the parameters

In the three cases, the symbolic derivatives of the log-profile
likelihood w.r.t. the parameters can be obtained by chain rule hence
be used in the optimization routine.





















