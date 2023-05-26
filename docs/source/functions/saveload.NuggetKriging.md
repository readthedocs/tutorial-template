# `NuggetKriging::save` & `NuggetKriging::load`


## Description

Save/Load a `NuggetKriging` Model


## Usage

* Python
    ```python
    # k = NuggetKriging(...)
    k.save("k.h5")
    k2 = load("k.h5")
    ```
* R
    ```r
    # k = NuggetKriging(...)
    k$save("k.h5")
    k2 = load("k.h5")
    ```
* Matlab/Octave
    ```octave
    % k = NuggetKriging(...)
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
y <- f(X) + 0.1 * rnorm(nrow(X))

k <- NuggetKriging(y, X, kernel = "matern3_2")
k
k$save("k.h5")
load("k.h5")
```

### Results
```{literalinclude} ../functions/examples/saveload.NuggetKriging.md.Rout
:language: bash
```
![](../functions/examples/saveload.NuggetKriging.md.png)


