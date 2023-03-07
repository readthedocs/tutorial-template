# Trend and kernel in Kriging models

## Trend functions

The possible trend functions in **libKriging** are as follow, by increasing
level of complexity.

* The **constant trend** involves $p = 1$ coefficient and
  $\mathbf{f}(\mathbf{x})^\top\boldsymbol{\beta} = \beta$.
  
* The **linear trend** involves $p = d +1$ coefficients
  :: math
    \mathbf{f}(\mathbf{x})^\top \boldsymbol{\beta} = \beta_0 + \sum_{i=1}^d \beta_i \, x_i.


* The **interactive trend** involves $1 + d + d (d-1) /2$
  coefficients
  $$
    \mathbf{f}(\mathbf{x})^\top \boldsymbol{\beta} = \beta_0  +
    \sum_{i=1}^d \sum_{j=1}^{i-1} \beta_{ji} \, x_j x_i. 
  $$
  
* The **quadratic trend** involves $p = 1 + d + d(d+1) /2$
  coefficients
  $$
    \mathbf{f}(\mathbf{x})^\top \boldsymbol{\beta} = \beta_0  +
    \sum_{i=1}^d \sum_{j=1}^i \beta_{ji} \, x_j x_i. 
  $$

Starting from the constant trend, the other forms come by
adding the $d$ linear terms $x_i$, adding the $d \times (d-1) / 2$
interaction terms $x_i x_j$ with $j <i$, and finally adding the
squared input terms $x_i^2$.

For instance with $d=3$ inputs the four possible trends are in order
of complexity
$$
\begin{aligned}
  \textsf{constant} \qquad
  & \mathbf{f}(\mathbf{x})^\top
  = [1] \\
  \textsf{linear} \qquad
  & \mathbf{f}(\mathbf{x})^\top
  = [1, \: x_1, \: x_2,\: \:x_3] \\
  \textsf{interaction} \qquad
  & \mathbf{f}(\mathbf{x})^\top
  = [1, \: x_1, \: x_2,\: x_1x_2, \:x_3,\: x_1x_3,\: x_2x_3] \\
  \textsf{quadratic} \qquad
  & \mathbf{f}(\mathbf{x})^\top
  = [1, \: x_1, \: x_1^2, \: x_2,\: x_1x_2, \: x_2^2, \: x_3,\: x_1x_3,\: x_2x_3, \:x_3^2] \\
\end{aligned}
$$
Mind that the coefficients relate to a specific order of the inputs.

**Caution** The number of coefficients required in the interactive and quadratic
trend increases quadratically with the dimension. For $d = 10$ the
quadratic trend involves $66$ coefficients.

## The tensor product kernel

The zero-mean GP $\zeta(\mathbf{x})$ is characterized by its covariance
kernel $C(\mathbf{x}, \mathbf{x}') := \mathbb{E}[\zeta(\mathbf{x}),\, \zeta(\mathbf{x}')]$.
**libKriging** uses a specific form of covariance kernel $C(\mathbf{x},\,\mathbf{x}')$ on
the input space $\mathbb{R}^d$ which can be called
*tensor-product*. With $\mathbf{h} := \mathbf{x} - \mathbf{x}'$ the kernel
value expresses as
$$
  C(\mathbf{x}, \, \mathbf{x}'; \boldsymbol{\theta}, \, \sigma^2) =
  C(\mathbf{h}; \boldsymbol{\theta}, \, \sigma^2) =
  \sigma^2 \, \prod_{\ell = 1}^d \kappa(h_\ell / \theta_\ell)  
$$
where $\kappa(h)$ is a stationary correlation kernel on $\mathbb{R}$
and $\boldsymbol{\theta}$ is a vector of $d$ parameters $\theta_\ell> 0$
called *correlation ranges*.

A further constraint used in **libKriging** is that $\kappa(h)$ takes only
positive values: $\gamma(h) >0$ for all $h$.  With
$\lambda(h) := - \log \gamma(h)$ the derivative w.r.t. the correlation
range $\theta_\ell$ can be computed as
$$ 
  \partial_{\theta_\ell} C(\mathbf{h};\,\boldsymbol{\theta}) = 
  \theta_\ell^{-2} \, \lambda'(h_{\ell} / \theta_\ell) \,
  C(\mathbf{h};\,\boldsymbol{\theta}).
$$ 

### Available 1D correlation kernels

The 1D correlation kernels available are listed in Table
\ref{TabKern}.  Remind that in this setting the smoothness of the
paths of the GP $\zeta(\mathbf{x})$ is controlled by the smoothness of the
kernel $C(\mathbf{h})$ at $\mathbf{h} = \mathbf{0}$ hence by the smoothness of the
correlation kernel $\kappa(h)$ for $h=0$.  Note that the 1D
exponential kernel is not differentiable at $h = 0$ and the
corresponding paths are continuous but nowhere differentiable. The
kernels are given in the table by order of increasing smoothness.

**Note** The Gaussian kernel is a radial kernel in the sense that it
depends on $\mathbf{h}$ only through its square norm $\sum_\ell
h_\ell^2 / \theta_\ell^2$.

| kernel  | Name  | Expression  |
|:--|:--|:--|
| `"exp"` |  Exponential |  $\kappa(h) = \exp(-|h|)$  |
| `"matern3_2"` | Matérn whith shape $3/2$ | $\kappa(h) = [1 + z] \exp\{-z\}$, $z := \sqrt{3} \, |h|$ |
| `"matern5_2"` | Matérn whith shape $5/2$  | $\kappa(h) = [1 + z + z^2/3] \exp\{-z\}$, $z := \sqrt{5} \, |h|$  |
| `"gauss"` | Gaussian  | $\kappa(h) = \exp\{-h^2/2\}$ |

