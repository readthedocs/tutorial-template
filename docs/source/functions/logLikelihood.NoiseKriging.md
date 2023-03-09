(logLikelihood.NoiseKriging)=
# `NoiseKriging::logLikelihood`


## Description

Get logLikelihood of NoiseKriging Model


## Usage

* Python
    ```python
    # k = NoiseKriging(...)
    k.logLikelihood()
    ```
* R
    ```r
    # k = NoiseKriging(...)
    k$logLikelihood()
    ```
* Matlab/Octave
    ```octave
    % k = NoiseKriging(...)
    k.logLikelihood()
    ```
	
## Details
 
See [`logLikelihoodFun.NoiseKriging`](logLikelihoodFun.NoiseKriging)
for more details on the corresponding profile log-likelihood function.


## Value

The value of the maximized profile log-likelihood
$\ell_{\texttt{prof}}(\widehat{\boldsymbol{\theta}},\,\widehat{\sigma}^2)$.
This is also the value $\ell(\widehat{\boldsymbol{\theta}},\,
\widehat{\sigma}^2,\, \widehat{\boldsymbol{\beta}})$ of the log
-likelihood.



## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X) + X/10 * rnorm(nrow(X))

k <- NoiseKriging(y, (X/10)^2, X, kernel = "matern3_2", objective="LL")
print(k)

k$logLikelihood()
```

### Results
```{literalinclude} ../functions/examples/logLikelihood.NoiseKriging.md.Rout
:language: bash
```
![](../functions/examples/logLikelihood.NoiseKriging.md.png)


## Reference

* Code: <https://github.com/libKriging/libKriging/blob/master/src/lib/NoiseKriging.cpp#L94>
