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


## Value

The logLikelihood computed for fitted
  $\theta,\sigma^2$.


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
