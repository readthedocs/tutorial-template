# `NuggetKriging::predict`


## Description

Predict from a `NuggetKriging` object.


## Usage

* Python
    ```python
    # k = NuggetKriging(...)
    k.predict(x, stdev = True, cov = False, deriv = False)
    ```
* R
    ```r
    # k = NuggetKriging(...)
    k$predict(x, stdev = TRUE, cov = FALSE, deriv = FALSE)
    ```
* Matlab/Octave
    ```octave
    % k = NuggetKriging(...)
    k.predict(x, stdev = true, cov = false, deriv = false)
    ```

## Arguments

Argument      |Description
------------- |----------------
`x`     |     Input points where the prediction must be computed.
`stdev`     |     `Logical` . If `TRUE` the standard deviation is returned.
`cov`     |     `Logical` . If `TRUE` the covariance matrix of the predictions is returned.
`deriv`     |     `Logical` . If `TRUE` the derivatives of mean and sd of the predictions are returned.


## Details

Given "new" input points, the method compute the expectation,
 variance and (optionnally) the covariance of the corresponding
 stochastic process, conditional on the values at the input points
 used when fitting the model.


## Value

A list containing the element `mean` and possibly
  `stdev` and `cov` .


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
plot(f)
set.seed(123)
X <- as.matrix(runif(5))
y <- f(X) + 0.1*rnorm(nrow(X))
points(X, y, col = "blue", pch = 16)
r <- NuggetKriging(y, rep(0.1^2,nrow(X)), X, "gauss")
x <-seq(from = 0, to = 1, length.out = 101)
p_x <- predict(r, x)
lines(x, p_x$mean, col = "blue")
lines(x, p_x$mean - 2 * p_x$stdev, col = "blue")
lines(x, p_x$mean + 2 * p_x$stdev, col = "blue")
```

### Results
```{literalinclude} ../examples/predict.NuggetKriging.md.Rout
:language: bash
```
![](../examples/predict.NuggetKriging.md.png)


## Reference

* Code: <https://github.com/libKriging/libKriging/blob/master/src/lib/NuggetKriging.cpp#L1326>
