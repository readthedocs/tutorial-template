# `Kriging::logLikelihood`


## Description

Get the Maximized Log-Likelihood of a `Kriging` Model Object


## Usage

* Python
    ```python
    # k = Kriging(...)
    k.logLikelihood()
    ```
* R
    ```r
    # k = Kriging(...)
    k$logLikelihood()
    ```
* Matlab/Octave
    ```octave
    % k = Kriging(...)
    k.logLikelihood()
    ```
## Details
 
See [`logLikelihoodFun.Kriging`](logLikelihoodFun.Kriging) for more
details on the profile log-likelihood function used in the
maximization.

## Value

The value of the maximized profile log-likelihood
$\ell_{\texttt{prof}}(\widehat{\boldsymbol{\theta}})$. This is also
the value $\ell(\widehat{\boldsymbol{\theta}},\, \widehat{\sigma}^2,\,
\widehat{\boldsymbol{\beta}})$ of the maximized log-likelihood.

## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X)

k <- Kriging(y, X, kernel = "matern3_2", objective="LL")
print(k)

k$logLikelihood()
```

### Results
```{literalinclude} ../functions/examples/logLikelihood.Kriging.md.Rout
:language: bash
```
![](../functions/examples/logLikelihood.Kriging.md.png)


## Reference

* Code: <https://github.com/libKriging/libKriging/blob/master/src/lib/Kriging.cpp#L94>
