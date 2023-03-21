# The tensor product kernel

## General form

The zero-mean smooth GP $\zeta(\mathbf{x})$ is characterized by its
covariance kernel $C_\zeta(\mathbf{x}, \mathbf{x}') :=
\mathbb{E}[\zeta(\mathbf{x}),\, \zeta(\mathbf{x}')]$.  **libKriging**
uses a specific form of covariance kernel
$C_\zeta(\mathbf{x},\,\mathbf{x}')$ on the input space $\mathbb{R}^d$ which
can be called *tensor-product*. With $\mathbf{h} := \mathbf{x} -
\mathbf{x}'$ the kernel value expresses as

$$
  C_\zeta(\mathbf{x}, \, \mathbf{x}'; \boldsymbol{\theta}, \, \sigma^2) =
  C_\zeta(\mathbf{h}; \boldsymbol{\theta}, \, \sigma^2) =
  \sigma^2 \, \prod_{\ell = 1}^d \kappa(h_\ell / \theta_\ell)  
$$

where $\kappa(h)$ is a stationary correlation kernel on $\mathbb{R}$
and $\boldsymbol{\theta}$ is a vector of $d$ parameters $\theta_\ell>
0$ called *correlation ranges*. See {cite:t}`Stein_Kriging` for a
description of the tensor product.

A further constraint used in **libKriging** is that $\kappa(h)$ takes only
positive values: $\gamma(h) >0$ for all $h$.  With
$\lambda(h) := - \log \gamma(h)$ the derivative w.r.t. the correlation
range $\theta_\ell$ can be computed as

$$ 
  \partial_{\theta_\ell} C_\zeta(\mathbf{h};\,\boldsymbol{\theta}) = 
  \theta_\ell^{-2} \, \lambda'(h_{\ell} / \theta_\ell) \,
  C_\zeta(\mathbf{h};\,\boldsymbol{\theta}).
$$ 


## Available 1D correlation kernels

The 1D correlation kernels available are listed in the Table below.
Remind that in this setting the smoothness of the paths of the GP
$\zeta(\mathbf{x})$ is controlled by the smoothness of the kernel
$C_\zeta(\mathbf{h})$ at $\mathbf{h} = \mathbf{0}$ hence by the smoothness
of the correlation kernel $\kappa(h)$ for $h=0$.  Note that the 1D
exponential kernel is not differentiable at $h = 0$ and the
corresponding paths are continuous but nowhere differentiable. The
kernels are given in the table by order of increasing smoothness.

**Note** The Gaussian kernel is a radial kernel in the sense that it
depends on $\mathbf{h}$ only through its square norm $\sum_\ell
h_\ell^2 / \theta_\ell^2$.

| kernel  | Name  | Expression  |
|:--|:--|:--|
| `"exp"` |  Exponential |  $\kappa(h) = \exp\{-\lvert h \rvert \}$  |
| `"matern3_2"` | Matérn whith shape $3/2$ | $\kappa(h) = [1 + z] \exp\{-z\}$, $z := \sqrt{3} \, \lvert h \rvert$ |
| `"matern5_2"` | Matérn whith shape $5/2$  | $\kappa(h) = [1 + z + z^2/3] \exp\{-z\}$, $z := \sqrt{5} \, \lvert h \rvert$  |
| `"gauss"` | Gaussian  | $\kappa(h) = \exp\{-h^2/2\}$ |

