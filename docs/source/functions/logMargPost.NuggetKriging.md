# `NuggetKriging::logMargPost`

## Description

Get the Maximized Log-Marginal Posterior Density of a `NuggetKriging`
Model


## Usage

* Python
    ```python
    # k = NuggetKriging(...)
    k.logMargPost()
    ```
* R
    ```r
    # k = NuggetKriging(...)
    k$logMargPost()
    ```
* Matlab/Octave
    ```octave
    % k = NuggetKriging(...)
    k.logMargPost()
    ```

## Details

Using the [*jointly robust*](SecJointlyrobust) prior
$\pi_{\texttt{JR}}(\boldsymbol{\theta},\, \alpha, \,\sigma^2, \,
\boldsymbol{\beta})$ the marginal or integrated posterior is the
function of $\boldsymbol{\theta}$ and $\alpha$ obtained from the
posterior density by marginalizing out the GP variance $\sigma^2$ and
the vector $\boldsymbol{\beta}$ of trend coefficients.  See
[`logMargPostFun.NuggetKriging`](logMargPostFun.NuggetKriging) for the
log-marginal posterior density. By maximizing this function
w.r.t. $\boldsymbol{\theta}$ and $\alpha$ we get estimated correlation
ranges which are warranted to be postitive and finite $0 < \theta_k <
\infty$. The estimated variance ratio is such that $0 < \alpha < 1$.

## Value

The maximal value of the log-marginal posterior density, corresponding
to the estimated value of the vector $[\boldsymbol{\theta},\,\alpha]$
where $\boldsymbol{\theta}$ is the vector of correlation ranges and
$\alpha := \sigma^2/ (\sigma^2 + \tau^2)$ is the ratio of variance 
$\texttt{GP} / (\texttt{GP} + \texttt{nugget})$.


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X) + 0.1 * rnorm(nrow(X))

k <- NuggetKriging(y, X, kernel = "matern3_2", objective="LMP")
print(k)

k$logMargPost()
```

### Results
```{literalinclude} ../functions/examples/logMargPost.NuggetKriging.md.Rout
:language: bash
```
![](../functions/examples/logMargPost.NuggetKriging.md.png)


## Reference

* Code: <https://github.com/libKriging/libKriging/blob/master/src/lib/NuggetKriging.cpp#L494>
* The [RobustGaSP R package](https://CRAN.R-project.org/package=RobustGaSP)
