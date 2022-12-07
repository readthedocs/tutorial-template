# `Kriging::logMargPost`

## Description

Get Log-Marginal Posterior of Kriging Model


## Usage

* Python
    ```python
    # k = Kriging(...)
    k.logMargPost()
    ```
* R
    ```r
    # k = Kriging(...)
    k$logMargPost()
    ```
* Matlab/Octave
    ```octave
    % k = Kriging(...)
    k.logMargPost()
    ```


## Value

The logMargPost computed for fitted $\theta$ the prior



## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X)

k <- Kriging(y, X, kernel = "matern3_2", objective="LMP")
print(k)

k$logMargPost()
```

### Results
```{literalinclude} ../functions/examples/logMargPost.Kriging.md.Rout
:language: bash
```
![](../functions/examples/logMargPost.Kriging.md.png)


## Reference

* Code: <https://github.com/libKriging/libKriging/blob/master/src/lib/Kriging.cpp#L494>
* RobustGaSP R package

