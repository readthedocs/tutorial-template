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
  $theta$.


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X) + 1:10/20 * rnorm(nrow(X))

k <- NoiseKriging(y, 1:10/20^2, X, kernel = "matern3_2", objective="LL")
print(k)

k$logLikelihood()
```

### Results
```{literalinclude} ../examples/logLikelihood.NoiseKriging.md.Rout
:language: bash
```
![](../examples/logLikelihood.NoiseKriging.md.png)


## Reference

* Code: <https://github.com/libKriging/libKriging/blob/master/src/lib/NoiseKriging.cpp#L94>
