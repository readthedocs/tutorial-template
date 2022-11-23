# `NuggetKriging::copy`


## Description

Duplicate a `NuggetKriging` Model


## Usage

* Python
    ```python
    # k = NuggetKriging(...)
    k2 = k.copy()
    ```
* R
    ```r
    # k = NuggetKriging(...)
    k2 = k$copy()
    ```
* Matlab/Octave
    ```octave
    % k = NuggetKriging(...)
    k2 = k.copy()
    ```


## Value

The copy of object.


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X) + 0.1 * rnorm(nrow(X))

k <- NuggetKriging(y, X, kernel = "matern3_2")
k
k$copy()
```


### Results
```{literalinclude} ../functions/examples/copy.NuggetKriging.md.Rout
:language: bash
```
![](../functions/examples/copy.NuggetKriging.md.png)


