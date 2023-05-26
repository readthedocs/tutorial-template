# `NoiseKriging::save` & `NoiseKriging::load`


## Description

Save/Load a `NoiseKriging` Model


## Usage

* Python
    ```python
    # k = NoiseKriging(...)
    k.save("k.h5")
    k2 = load("k.h5")
    ```
* R
    ```r
    # k = NoiseKriging(...)
    k$save("k.h5")
    k2 = load("k.h5")
    ```
* Matlab/Octave
    ```octave
    % k = NoiseKriging(...)
    k.save("k.h5")
    k2 = load("k.h5")
    ```


## Value

The loaded object.


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X) + X/10 * rnorm(nrow(X)) # add noise dep. on X

k <- NoiseKriging(y, noise=(X/10)^2, X, kernel = "matern3_2")
k
k$save("k.h5")
load("k.h5")
```

### Results
```{literalinclude} ../functions/examples/saveload.NoiseKriging.md.Rout
:language: bash
```
![](../functions/examples/saveload.NoiseKriging.md.png)


