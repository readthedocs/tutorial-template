# Trend estimation

(SecGLS)= 
## Generalized Least Squares

Using $n$ given observations $y_i$, we can estimate the trend at the
inputs $\mathbf{x}_i$. For that aim we must find an estimate
$\widehat{\boldsymbol{\beta}}$ of the unknown vector
$\boldsymbol{\beta}$.  When no nugget or noise is used, the GP part
comes as the difference $\widehat{\boldsymbol{\zeta}} = \mathbf{y} -
\mathbf{F}\widehat{\boldsymbol{\beta}}$. When instead a nugget or a
noise is present a further step is needed to separate the smooth GP
part from the nugget or noise in $\mathbf{y} -
\mathbf{F}\widehat{\boldsymbol{\beta}}$.

If the covariance parameters are known, the estimate
$\widehat{\boldsymbol{\beta}}$ can be obtained by using General Least
Squares (GLS); this estimate is also the Maximum Likelihood estimate.
The computations related to GLS can rely on the Cholesky and the QR
decompositions of matrices as now detailed.

### The `"Kriging"` case

In the `"Kriging"` case, we have $\mathbf{C} = \sigma^2 \mathbf{R}$ where
$\mathbf{R}$ is the correlation matrix depending on $\boldsymbol{\theta}$. If the
correlation matrix $\mathbf{R}$ is known, then the ML estimate of
$\boldsymbol{\beta}$ and its covariance are given by

$$
  \widehat{\boldsymbol{\beta}} = \left[\mathbf{F}^\top \mathbf{R}^{-1} 
  \mathbf{F}\right]^{-1}
  \mathbf{F}^\top \mathbf{R}^{-1}\mathbf{y}, \qquad
  \textsf{Cov}(\widehat{\boldsymbol{\beta}}) = \sigma^2 [\mathbf{F}^\top 
  \mathbf{R}^{-1}\mathbf{F}]^{-1}.
$$

Moreover the ML estimate $\widehat{\sigma}^2$ is available as well.

In practice we can use the Cholesky decomposition
$\mathbf{R} = \mathbf{L}\mathbf{L}^\top$ where $\mathbf{L}$ is a $n \times n$ lower
triangular matrix with positive diagonal elements.  By
left-multiplying the relation $\mathbf{y} = \mathbf{F}\boldsymbol{\beta} + \boldsymbol{\zeta}$
by $\mathbf{L}^{-1}$, we get

$$
  \LInv{\mathbf{y}} = \LInv{\mathbf{F}}\boldsymbol{\beta} + 
  \LInv{\boldsymbol{\zeta}}
$$

where \LInvNm{} symbols indicate a left multiplication by $\mathbf{L}^{-1}$
e.g., $\LInv{\mathbf{y}}=\mathbf{L}^{-1}\mathbf{y}$.  We get a standard linear
regression with i.i.d. Gaussian errors $\LInv{\zeta}_i$ having zero
mean and variance $\sigma^2$. So the ML estimates
$\widehat{\boldsymbol{\beta}}$ and $\widehat{\sigma}^2$ come by Ordinary Least
Squares. Using
$\widehat{\boldsymbol{\zeta}} = \mathbf{y} - \mathbf{F}\widehat{\boldsymbol{\beta}}$ and
$\LInvHat{\boldsymbol{\zeta}} := \mathbf{L}^{-1}\widehat{\boldsymbol{\zeta}}$ we have

$$
  \widehat{\sigma}^2_{\texttt{ML}} = \frac{1}{n} \,S^2, \quad\text{with}\quad
  S^2 := \LInvHatT{\boldsymbol{\zeta}}\LInvHat{\boldsymbol{\zeta}}
  = \widehat{\boldsymbol{\zeta}}^\top\mathbf{R}^{-1}\widehat{\boldsymbol{\zeta}}.
$$

Note that $\widehat{\sigma}^2_{\texttt{ML}}$ is a biased estimate of
$\sigma^2$. An alternative unbiased estimate can be obtained by using
$n-p$ instead of $n$ as the denominator: this is the so-called
*Restricted Maximum Likelihood* (REML) estimate.

The computations rely on the so-called "thin" or "economical" QR
decomposition of the transformed trend matrix $\LInv{\mathbf{F}}$

$$ 
  \LInv{\mathbf{F}} = \mathbf{Q}_{\LInv{\mathbf{F}}} \mathbf{R}_{\LInv{\mathbf{F}}} 
$$

where $\mathbf{Q}_{\LInv{\mathbf{F}}}$ is
$n \times p$ and $\mathbf{R}_{\LInv{\mathbf{F}}}$ is a $p \times p$ upper
triangular matrix. The estimate comes by solving the triangular system
$\mathbf{R}_{\LInv{\mathbf{F}}}\boldsymbol{\beta} = \mathbf{Q}_{\LInv{\mathbf{F}}}^\top
\LInv{\mathbf{y}}$, and the covariance of the estimate is
$\Cov(\widehat{\boldsymbol{\beta}}) = \mathbf{R}_{\LInv{\mathbf{F}}}^{-1}
\mathbf{R}_{\LInv{\mathbf{F}}}^{-\top}$

Following a popular linear regression trick, one can further use the
QR decomposition of the matrix $\LInv{\mathbf{F}}_+$ obtained by adding a
new column $\LInv{\mathbf{y}}$ to $\LInv{\mathbf{F}}$ 

$$
\LInv{\mathbf{F}}_+ := \left[ \LInv{\mathbf{F}} \, \vert \, \LInv{\mathbf{y}} \right]
= \mathbf{Q}_{\LInv{\mathbf{F}}_+}\mathbf{R}_{\LInv{\mathbf{F}}_+}.  
$$

Then the $p+1$ column of $\mathbf{Q}_{\LInv{\mathbf{F}}_+}$ contains the vector
of residuals $\LInvHat{\boldsymbol{\zeta}} = \LInv{\mathbf{y}} - \LInv{\mathbf{F}}
\widehat{\boldsymbol{\beta}}$ in its first $p$ elements and the residual sum
of squares is given by the square of the element
$R_{\LInv{\mathbf{F}}_+}[p + 1, p +1]$. See \cite{Lange_Numerical}.


### `"NuggetKriging"` and `"NoiseKriging"`

When a nugget or noise term is used, the estimate of $\boldsymbol{\beta}$ can
be obtained as above provided that the covariance matrix is that of
the non-trend component hence includes the nugget or noise variance in
its diagonal. In the `NuggetKriging` case the GLS will provide an
estimate of the variance $\nu^2 = \sigma^2 + \tau^2$ but the ML
estimate of $\sigma^2$ can only be obtained by using a numerical
optimization providing the ML estimate of $\alpha$ from which the
estimate of $\sigma^2$ is found.

(SecBending)= 
## The Bending Energy Matrix

Since $\widehat{\boldsymbol{\beta}}$ is a linear function of
$\mathbf{y}$ we have

$$
  [\mathbf{y} - \mathbf{F}\widehat{\boldsymbol{\beta}}]^\top \mathbf{C}^{-1}
  [\mathbf{y} - \mathbf{F}\widehat{\boldsymbol{\beta}}] =
  \mathbf{y}^\top \mathbf{B} \mathbf{y}
$$

where the $n \times n$ matrix $\mathbf{B}$ called the *Bending Energy
  Matrix* (BEM) is given by
  
$$
  \mathbf{B} = \mathbf{C}^{-1} - \mathbf{C}^{-1}\mathbf{F} \left[\mathbf{F} \mathbf{C}^{-1} \mathbf{F}^\top \right]^{-1}
  \mathbf{F}^\top\mathbf{C}^{-1}.
$$

The $n \times n$ matrix $\mathbf{B}$ is such that
$\mathbf{B}\mathbf{F} = \mathbf{0}$ which means that the columns of
$\mathbf{F}$ are eigenvectors of $\mathbf{B}$ with eigenvalue $0$. If
$\mathbf{C}$ is positive definite and $\mathbf{F}$ has full column rank
as assumed, then $\mathbf{B}$ has rank $n- p$.

In the special case where no trend is used i.e., $p=0$ the bending
energy matrix can consistently be defined as $\mathbf{B} := \mathbf{C}^{-1}$,
the trend matrix $\mathbf{F}$ then being a matrix with zero columns and the
vector $\boldsymbol{\beta}$ being of length zero.

The BEM matrix is closely related to smoothing since the trend
and GP component of $\mathbf{y}$ are given by

$$
  \mathbf{y} =
  \underset{\text{trend}}
  {\underbrace{\widehat{\boldsymbol{\mu}}}} +
  \underset{\text{GP}}
  {\underbrace{\widehat{\boldsymbol{\zeta}}}}
  = [\mathbf{I}_n - \mathbf{C}\mathbf{B}] \, \mathbf{y} + \mathbf{C}\mathbf{B} \, \mathbf{y}.
$$

The matrix $\mathbf{I}_n - \mathbf{C}\mathbf{B}$ is the matrix of the orthogonal
projection on the linear space spanned by the columns of $\mathbf{F}$ in
$\mathbb{R}^n$ equipped with the inner product
$\langle\mathbf{z},\,\mathbf{z}'\rangle_{\mathbf{C}^{-1}} := \mathbf{z}^\top \mathbf{C}^{-1}\mathbf{z}'$.

**Note**   The BEM does not depend on the specific basis used to define the
  linear space of trend functions. It also depends on the kernel only
  through the *reduced kernel* related to the trend linear
  space :cite:t:`Pronzato_Sens`. So the eigen-decomposition of the BEM
  provides useful insights into the model used such as the so-called
  *Principal Kriging Functions*

The BEM $\mathbf{B}$ can be related to the matrices $\mathbf{C}$ and $\mathbf{F}$ by
a block inversion

$$
  \begin{bmatrix}
    \mathbf{C} & \mathbf{F}\\
    \mathbf{F}^\top & \mathbf{0}
  \end{bmatrix}^{-1}
  =
  \begin{bmatrix}
    \mathbf{B} & \mathbf{U}\\
    \mathbf{U}^\top & \mathbf{V}
  \end{bmatrix}
  \qquad \text{with }
  \left\{
    \begin{aligned}
      \mathbf{V} &:= - [\mathbf{F}^\top\mathbf{C}^{-1}\mathbf{F}]^{-1}\\
      \mathbf{U} &:= - \mathbf{C}^{-1}\mathbf{F}\mathbf{V}
    \end{aligned}
  \right.
$$

where the inverse exists provided that $\mathbf{F}$ has full column rank,
the kernel being assumed to be definite positive.

The relation can be derived by using the so-called *kernel shift*
functions $\mathbf{x} \mapsto C(\mathbf{x}, \, \mathbf{x}_i)$ to
represent the GP component of $y(\mathbf{x})$ in the Kriging mean
function

$$
h(\mathbf{x}) =
\underset{\text{GP}}
{\underbrace{\sum_{i=1}^n \alpha_i \, C(\mathbf{x}_i, \, \mathbf{x})}}
+
\underset{\text{trend}}
{\underbrace{\sum_{k=1}^p \beta_k f_k(\mathbf{x})}}.
$$

In the case where the model has no nugget or noise, using the $n$
observations $y_i$ we can find the $n + p$ unknown coefficients
$\alpha_i$ and $\beta_k$ by imposing the orthogonality constraints
$\mathbf{F}^\top\boldsymbol{\alpha} = \mathbf{0}_p$, leading to the
linear system

$$
  \begin{bmatrix}
    \mathbf{C} & \mathbf{F}\\
    \mathbf{F}^\top & \mathbf{0}
  \end{bmatrix}
  \begin{bmatrix}
    \boldsymbol{\alpha}\\
    \boldsymbol{\beta}
  \end{bmatrix} = 
  \begin{bmatrix}
    \mathbf{y}\\
    \mathbf{0}
  \end{bmatrix}.
$$

It turns out that the trend part of the solution is then identical
to the GLS estimate $\widehat{\boldsymbol{\beta}}$.

If $\New{n}$ inputs are given in $\New{\mathbf{X}}$, then with
$\New{\mathbf{C}} = \mathbf{C}(\New{\mathbf{X}}, \, \mathbf{X})$ and
$\New{\mathbf{F}} =\mathbf{F}(\New{\mathbf{X}})$ the prediction writes
in blocks form as

$$
  \New{\widehat{\mathbf{y}}} =
  \begin{bmatrix}
    \New{\mathbf{C}} & \New{\mathbf{F}}
  \end{bmatrix}
  \begin{bmatrix}
    \widehat{\boldsymbol{\alpha}} \\
    \widehat{\boldsymbol{\beta}}
  \end{bmatrix} =
  \begin{bmatrix}
    \New{\mathbf{C}} & \New{\mathbf{F}}
  \end{bmatrix}
  \begin{bmatrix}
    \mathbf{B} & \mathbf{U}\\
    \mathbf{U}^\top & \mathbf{V}
  \end{bmatrix}
  \begin{bmatrix}
    \mathbf{y} \\
    \mathbf{0}
  \end{bmatrix}.
$$

