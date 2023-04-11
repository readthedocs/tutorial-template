# `NoiseKriging::predict`


## Description

Predict from a `NoiseKriging` Model Object


## Usage

* Python
    ```python
    # k = NoiseKriging(...)
    k.predict(x, stdev = True, cov = False, deriv = False)
    ```
* R
    ```r
    # k = NoiseKriging(...)
    k$predict(x, stdev = TRUE, cov = FALSE, deriv = FALSE)
    ```
* Matlab/Octave
    ```octave
    % k = NoiseKriging(...)
    k.predict(x, stdev = true, cov = false, deriv = false)
    ```

## Arguments

Argument      |Description
------------- |----------------
`x`     |     Input points where the prediction must be computed.
`stdev`     |     `Logical` . If `TRUE` the standard deviation is returned.
`cov`     |     `Logical` . If `TRUE` the covariance matrix of the predictions is returned.
`deriv`     |     `Logical` . If `TRUE` the derivatives of mean and sd of the predictions are returned.


## Details

Given $n^\star$ "new" input points $\mathbf{x}^\star_{j}$, the method
compute the expectation, the standard deviation and (optionally) the
covariance of the estimated values of the "trend $+$ GP" stochastic
process $\mu(\mathbf{x}_j^\star) + \zeta(\mathbf{x}_j^\star)$ at the
"new" observations. The estimation is based on the distribution
conditional on the $n$ noisy observations $y_i$ made at the input
points $\mathbf{x}_i$ as used when fitting the model. The $n^\star$
input vectors (with length $d$) are given as the rows of a
$\mathbf{X}^\star$ corresponding to `x`.

The computation of these quantities is often called *Universal
Kriging* see [here](SecPredAndSim) for more details.


## Value

A list containing the element `mean` and possibly `stdev` and
`cov`. 

- The expectation in ` mean` is the estimate of the vector
   $\textsf{E}[\boldsymbol{\mu}^\star + \boldsymbol{\zeta}^\star \,
   \vert \,\mathbf{y}]$ with length $n^\star$ where 
   $\boldsymbol{\mu}^\star$ and $\boldsymbol{\zeta}^\star$ are for "new"
   points and $\mathbf{y}$ corresponds to the observations. Similarly
   the conditional standard deviation in `stdev` is a vector with
   length $n^\star$ and the conditional covariance in `cov` is a
   $n^\star \times n^\star$ matrix.
   
- The (optional) derivatives are two $n^\star \times d$ matrices
   `pred_mean_deriv` and ` pred_sdtdev_deriv` with their row $j$
   containing the vector of derivatives w.r.t. to the new input point
   $\mathbf{x}^\star$ evaluated at $\mathbf{x}^\star =
   \mathbf{x}^\star_j$. So the row $j$ of `pred_mean_deriv` contains
   the derivative $\partial_{\mathbf{x}^\star}
   \mathbb{E}[y(\mathbf{x}^\star) \, \vert \,\mathbf{y}]$.  evaluated
   at $\mathbf{x}^\star = \mathbf{x}^\star_j$.

Note that for a `NoiseKriging` object the prediction is actually a
*smoothing*. The so-called *Kriging mean* function $\mathbf{x}^\star
\mapsto \mathbb{E}[y(\mathbf{x}^\star) \, \vert \, \mathbf{y}]$ is a
smooth function. Depending on the given noise variances $\sigma^2_i$
given in the [fit step](fit.NoiseKriging), the prediction at
$\mathbf{x}^\star \approx \mathbf{x}_i$ will be more or less close to
the observed value $y_i$.  As opposed to the
[`NuggetKriging`](NuggetKriging) model case, duplicated inputs can be
used in the design.


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
plot(f)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X) + X/10 * rnorm(nrow(X))
points(X, y, col = "blue", pch = 16)

k <- NoiseKriging(y, (X/10)^2, X, "matern3_2")

x <-seq(from = 0, to = 1, length.out = 101)
p <- k$predict(x)

lines(x, p$mean, col = "blue")
polygon(c(x, rev(x)), c(p$mean - 2 * p$stdev, rev(p$mean + 2 * p$stdev)),
border = NA, col = rgb(0, 0, 1, 0.2))
```

### Results
```{literalinclude} ../functions/examples/predict.NoiseKriging.md.Rout
:language: bash
```
![](../functions/examples/predict.NoiseKriging.md.png)


## Reference

* Code: <https://github.com/libKriging/libKriging/blob/master/src/lib/NoiseKriging.cpp#L1326>
