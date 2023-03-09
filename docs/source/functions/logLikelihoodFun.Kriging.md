(logLikelihoodFun.Kriging)=
# `Kriging::logLikelihoodFun`


## Description

Compute Log-Likelihood of Kriging Model for given vector $\boldsymbol{\theta}$
of correlation ranges

## Usage

* Python
    ```python
    # k = Kriging(...)
    k.logLikelihoodFun(theta)
    ```
* R
    ```r
    # k = Kriging(...)
    k$logLikelihoodFun(theta)
    ```
* Matlab/Octave
    ```octave
    % k = Kriging(...)
    k.logLikelihoodFun(theta)
    ```


## Arguments

Argument      |Description
------------- |----------------
`theta`     |     A numeric vector of (positive) range parameters at which the profile log-likelihood will be evaluated.
`grad`     |     Logical. Should the function return the gradient?
`hess`     |     Logical. Should the function return Hessian?


## Details

The profile log-likelihood $\ell_{\texttt{prof}}(\boldsymbol{\theta})$
is obtained from the log-likelihood function
$\ell(\boldsymbol{\theta},\, \sigma^2, \, \boldsymbol{\beta})$ by
replacing the GP variance $\sigma^2$ and the vector
$\boldsymbol{\beta}$ of trend coefficients by their ML estimates
$\widehat{\sigma}^2$ and $\widehat{\boldsymbol{\beta}}$ which are
obtained by Generalized Least Squares. See [here](SecMLProf) for more
details.


## Value

A function which computes the profile log-likelihood for a given vector
$\boldsymbol{\theta}$ of correlation ranges.

## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X)

k <- Kriging(y, X, kernel = "matern3_2")
print(k)

ll <- function(theta) k$logLikelihoodFun(theta)$logLikelihood

t <- seq(from = 0.001, to = 2, length.out = 101)
plot(t, ll(t), type = 'l')
abline(v = k$theta(), col = "blue")
```

### Results
```{literalinclude} ../functions/examples/logLikelihoodFun.Kriging.md.Rout
:language: bash
```
![](../functions/examples/logLikelihoodFun.Kriging.md.png)
