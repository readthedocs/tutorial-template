# `Kriging::logMargPost`

## Description

Get the Maximized Log-Marginal Posterior Density of a ` Kriging`  Model


## Usage

* Python
    ```python
    # k = Kriging(...)
    k.logMargPost()
    ```
* R
    ```r
    # k = Kriging(...)
    k$logMargPost()
    ```
* Matlab/Octave
    ```octave
    % k = Kriging(...)
    k.logMargPost()
    ```

## Details

Using the [*jointly robust*](SecJointlyrobust) prior
$\pi_{\texttt{JR}}(\boldsymbol{\theta},\, \sigma^2, \,
\boldsymbol{\beta})$ the marginal or integrated posterior is the
function of $\boldsymbol{\theta}$ obtained from the posterior density
by marginalizing out the GP variance $\sigma^2$ and the vector
$\boldsymbol{\beta}$ of trend coefficients.  See
[`logMargPostFun.Kriging`](logMargPostFun.Kriging) for the
log-marginal posterior density. By maximizing this function
w.r.t. $\boldsymbol{\theta}$ we get estimated correlation ranges which
are warranted to be postitive and finite $0 < \theta_k < \infty$.

## Value

The maximal value of the log-marginal posterior density, corresponding
to the estimated value of the vector $\boldsymbol{\theta}$ of
correlation ranges.

## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X)

k <- Kriging(y, X, kernel = "matern3_2", objective="LMP")
print(k)

k$logMargPost()
```

### Results
```{literalinclude} ../functions/examples/logMargPost.Kriging.md.Rout
:language: bash
```
![](../functions/examples/logMargPost.Kriging.md.png)


## Reference

* Code: <https://github.com/libKriging/libKriging/blob/master/src/lib/Kriging.cpp#L494>
* The [RobustGaSP R package](https://CRAN.R-project.org/package=RobustGaSP)

