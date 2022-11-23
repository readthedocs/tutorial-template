# `NoiseKriging::copy`


## Description

Duplicate a `NoiseKriging` Model


## Usage

* Python
    ```python
    # k = NoiseKriging(...)
    k2 = k.copy()
    ```
* R
    ```r
    # k = NoiseKriging(...)
    k2 = k$copy()
    ```
* Matlab/Octave
    ```octave
    % k = NoiseKriging(...)
    k2 = k.copy()
    ```


## Value

The copy of object.


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X) + X/10 * rnorm(nrow(X)) # add noise dep. on X

k <- NoiseKriging(y, noise=(X/10)^2, X, kernel = "matern3_2")
k
k$copy()
```

### Results
```{literalinclude} ../functions/examples/copy.NoiseKriging.md.Rout
:language: bash
```
![](../functions/examples/copy.NoiseKriging.md.png)
