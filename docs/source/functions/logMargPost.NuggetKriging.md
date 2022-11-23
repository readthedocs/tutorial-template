# `NuggetKriging::logMargPost`

## Description

Get Log-Marginal Posterior of NuggetKriging Model


## Usage

* Python
    ```python
    # k = NuggetKriging(...)
    k.logMargPost()
    ```
* R
    ```r
    # k = NuggetKriging(...)
    k$logMargPost()
    ```
* Matlab/Octave
    ```octave
    % k = NuggetKriging(...)
    k.logMargPost()
    ```


## Value

The logMargPost computed for fitted $\theta,\frac{\sigma^2}{\sigma^2+nugget}$.



## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X) + 0.1 * rnorm(nrow(X))

k <- NuggetKriging(y, X, kernel = "matern3_2", objective="LMP")
print(k)

k$logMargPost()
```

### Results
```{literalinclude} ../functions/examples/logMargPost.NuggetKriging.md.Rout
:language: bash
```
![](../functions/examples/logMargPost.NuggetKriging.md.png)


## Reference

* Code: <https://github.com/libKriging/libKriging/blob/master/src/lib/NuggetKriging.cpp#L494>
* RobustGaSP R package

