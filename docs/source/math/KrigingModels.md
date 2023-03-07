
(SecKrigingModels)= 
# Kriging models

## Components of Kriging models

**libKriging** makes available several kinds of Kriging models as commonly used
in the field of computer experiments. All models involve a stochastic
process $y(\mathbf{x})$ indexed by a vector $\mathbf{x} \in \mathbb{R}^d$ of $d$
real inputs $x_k$, sometimes called the design vector. The response
variable or output $y$ is assumed to be observed for $n$ values
$\mathbf{x}_i$ of the input vector with corresponding response values $y_i$
for $i=1$, $\dots$, $n$. The response values are considered as
realisations of random variables.

The models involve the following elements or components.

* **Trend** A known vector-valued function
  $\mathbb{R}^d \to \mathbb{R}^p$ with value denoted by
  $\mathbf{f}(\mathbf{x})$. It is used in relation with an unknown vector
  $\boldsymbol{\beta}$ of trend parameters to provide the trend term
  $\mu(\mathbf{x}) = \mathbf{f}(\mathbf{x})^\top \boldsymbol{\beta}$.
  
* **Smooth Gaussian Process (GP)** An unobserved GP
  $\zeta(\mathbf{x})$, at least continuous, with mean zero and known
  covariance kernel $C(\mathbf{x}, \, \mathbf{x}')$.
  
* **Nugget** A White noise GP $\varepsilon(\mathbf{x})$ with
  variance $\tau^2$ hence with covariance kernel
  $\tau^2 \delta(\mathbf{x},\,\mathbf{x}')$ where $\delta$ is the Dirac function
  $\delta(\mathbf{x}, \,\mathbf{x}') := 1_{\{\mathbf{x} = \mathbf{x}'\}}$.
  
* **Noise** A collection of independent random variables
  $\varepsilon_i$ with variances $\tau^2_i$.
  

Note that the words *nugget* and *noise* are sometimes
considered as equivalent. Yet in **libKriging** *nugget* will be used
only when a single path is considered for the stochastic process, in
which case no duplicated value can exist for the vector of inputs.

When a nugget term is used, the process $y(\mathbf{x})$ is discontinuous,
so the prediction at a new value $\New{\mathbf{x}}$ will be identical to
$y(\mathbf{x}_i)$ if it happens that $\New{\mathbf{x}} = \mathbf{x}_i$ for some
$i$. We may say that the prediction is an interpolation, in relation
with this feature. However, in the usual acceptation of this term,
interpolation involves the use of a *smooth* function, say at
least continuous.


**Note**   The so-called *Gaussian-Process Regression* framework
  corresponds to the noisy case. However duplicated designs are
  generally allowed and the noise r.vs are assumed to have either a
  common unknown variance $\tau^2$ or a variance $\tau^2(\mathbf{x})$
  depending on the design according to some specification.

**libKriging** implements the three classes `"Kriging"`,
`"NoiseKriging"` and `"NuggetKriging"` of objects
corresponding to Kriging models. In each class we find the linear
trend, the smooth GP. The difference relates to the presence of a
nugget or noise term.


## Classes of Kriging model objects

To describe the three classes of Kriging models, we assume that $n$
observations are given corresponding to $n$ input vectors $\mathbf{x}_i$.

### Class `"Kriging"`

The `Kriging` class correspond to observations of the form

$$
  \mathbf{y}(\mathbf{x}_i) = \mathbf{f}(\mathbf{x}_i)^\top \boldsymbol{\beta} + \zeta(\mathbf{x}_i), \qquad
  i= 1,\, \dots,\, n.
$$

### Class `"NuggetKriging"`

The `"NuggetKriging"` class corresponds to observations of the form

$$
  \mathbf{y}(\mathbf{x}_i) = \mathbf{f}(\mathbf{x}_i)^\top \boldsymbol{\beta} + \zeta(\mathbf{x}_i)
  + \varepsilon(\mathbf{x}_i), \qquad i= 1,\, \dots,\, n.
$$

The sum $\zeta(\mathbf{x}) + \varepsilon(\mathbf{x})$ defines a GP with
discontinuous paths and covariance kernel
$C(\mathbf{x}, \mathbf{x}') + \tau^2\delta(\mathbf{x},\,\mathbf{x}')$.

### Class `"NoiseKriging"`

The `"NoiseKriging"` class corresponds to observations of the form

$$
  \mathbf{y}_i = \mathbf{f}(\mathbf{x}_i)^\top \boldsymbol{\beta} + \zeta(\mathbf{x}_i) + \varepsilon_i,
  \qquad i= 1,\, \dots,\, n
$$

where the noise r.vs $\varepsilon_i$ are Gaussian with mean zero and
known variances $\tau_i^2$.  Although the response $y_i$ corresponds
to the input $\mathbf{x}_i$ as for the classes `"Kriging"` and
`"NugggetKriging"`, there can be several observations made at the
same input $\mathbf{x}_i$. We may then speak of duplicated inputs.

## Matrix formalism and assumptions

The $n$ input vectors $\mathbf{x}_i$ are conveniently considered as the
(transposed) rows of a matrix.

*  The $n \times d$ design or input matrix $\mathbf{X}$
  having $\mathbf{x}_i^\top$ as its row $i$.
  
* The $n \times p$ trend matrix $\mathbf{F}(\mathbf{X})$ or simply $\mathbf{F}$
  having $\mathbf{f}(\mathbf{x}_i)^\top$ as its row $i$.

* The $n \times n$ covariance matrix
  $\mathbf{C}(\mathbf{X},\, \mathbf{X}) =[C(\mathbf{x}_i,\,\mathbf{x}_j)]_{i,j}$ is sometimes
  called the Gram matrix and is often simply denoted as $\mathbf{C}$.

The observations for a `Kriging` model write in matrix notations
$\mathbf{y} = \mathbf{F} \boldsymbol{\beta} + \boldsymbol{\zeta}$,
while those for `NuggetKriging` and `NoiseKriging` models write as
$\mathbf{y} = \mathbf{F} \boldsymbol{\beta} + \boldsymbol{\zeta} +
\boldsymbol{\varepsilon}$.  Similar notations are used if a sequence
of $\New{n}$ "new" designs $\New{\mathbf{x}}_i$ are considered,
resulting in matrices with $\New{n}$ rows $\New{\mathbf{X}}$ and
$\New{\mathbf{F}}$.


It will be assumed that the matrix $\mathbf{F}$ has rank $p$ (hence that
$n \geqslant p$) and that the Kernel $C(\mathbf{x},\,\mathbf{x}')$ is positive
definite on $\mathbb{R}^d$ meaning that the matrix
$\mathbf{C}(\mathbf{X},\,\mathbf{X})$ is positive definite for every design
corresponding to distinct inputs $\mathbf{x}_i$.

**Note**  :cite:t:`BerlinetThomasagnant_RKHS` define Kriging models as the sum of
  a deterministic trend and a stochastic process with stationary
  increments, as is the case for splines. So the name *Kriging
    model* is understood here in a more restrictive way.

See the [Prediction and simulation](SecPredAndSim) page.
