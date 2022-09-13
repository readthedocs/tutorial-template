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

The logMargPost computed for fitted $\theta$.



## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(5))
y <- f(X) + 0.01*rnorm(nrow(X))
r <- NuggetKriging(y, X, kernel = "gauss")
print(r)
logMargPost(r)
```

### Results
```{literalinclude} ../examples/logMargPost.NuggetKriging.md.Rout
:language: bash
```
![](../examples/logMargPost.NuggetKriging.md.png)


## Reference

* Code: <https://github.com/libKriging/libKriging/blob/master/src/lib/NuggetKriging.cpp#L494>
* RobustGaSP R package

