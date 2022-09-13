# `Kriging::leaveOneOut`


## Description

Get Leave-One-Out of a Kriging Model


## Usage

* Python
    ```python
    # k = Kriging(...)
    k.leaveOneOut()
    ```
* R
    ```r
    # k = Kriging(...)
    k$leaveOneOut()
    ```
* Matlab/Octave
    ```octave
    % k = Kriging(...)
    k.leaveOneOut()
    ```


## Value

The leaveOneOut computed for fitted range: $\theta$.


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(5))
y <- f(X)
r <- Kriging(y, X, kernel = "gauss")
print(r)
r$leaveOneOut()
```

### Results
```{literalinclude} ../examples/leaveOneOut.Kriging.md.Rout
:language: bash
```
![](../examples/leaveOneOut.Kriging.md.png)


## Reference

* Code: <https://github.com/libKriging/libKriging/blob/master/src/lib/Kriging.cpp#L350>
