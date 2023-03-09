(logLikelihood.NuggetKriging)=
# `NuggetKriging::logLikelihood`


## Description

Get logLikelihood of NuggetKriging Model


## Usage

* Python
    ```python
    # k = NuggetKriging(...)
    k.logLikelihood()
    ```
* R
    ```rlibKriging
    k$logLikelihood()
    ```
* Matlab/Octave
    ```octave
    % k = NuggetKriging(...)
    k.logLikelihood()
    ```
	
## Details
 
See [`logLikelihoodFun.NuggetKriging`](logLikelihoodFun.NuggetKriging)
for more details on the corresponding profile log-likelihood function.

## Value

The value of the maximized profile log-likelihood
$\ell_{\texttt{prof}}(\widehat{\boldsymbol{\theta}},\,\widehat{\alpha})$
where $\alpha:= \sigma^2 / (\sigma^2 + \nu^2)$ is the ratio of the
variances $\sigma^2$ for the GP and $\sigma^2 + \nu^2$ for the GP $+$
nugget. This is also the value $\ell(\widehat{\boldsymbol{\theta}},\,
\widehat{\alpha},\, \widehat{\sigma}^2,\, \widehat{\boldsymbol{\beta}})$
or $\ell(\widehat{\boldsymbol{\theta}},\,
\widehat{\sigma}^2,\, \widehat{\tau}^2, \, \widehat{\boldsymbol{\beta}})$
of the maximized log-likelihood.


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X) + 0.1 * rnorm(nrow(X))

k <- NuggetKriging(y, X, kernel = "matern3_2", objective="LL")
print(k)

k$logLikelihood()
```

### Results
```{literalinclude} ../functions/examples/logLikelihood.NuggetKriging.md.Rout
:language: bash
```
![](../functions/examples/logLikelihood.NuggetKriging.md.png)


## Reference

* Code: <https://github.com/libKriging/libKriging/blob/master/src/lib/NuggetKriging.cpp#L94>
