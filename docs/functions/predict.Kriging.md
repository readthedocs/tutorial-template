# `predict.Kriging`

Prediction Method  for a `Kriging` Object


## Description

Predict from a `Kriging` object.


## Usage

```r
list(list("predict"), list("Kriging"))(object, x, stdev = TRUE, cov = FALSE, deriv = FALSE, ...)
```


## Arguments

Argument      |Description
------------- |----------------
`object`     |     S3 Kriging object.
`x`     |     Input points where the prediction must be computed.
`stdev`     |     `Logical` . If `TRUE` the standard deviation is returned.
`cov`     |     `Logical` . If `TRUE` the covariance matrix of the predictions is returned.
`deriv`     |     `Logical` . If `TRUE` the derivatives of mean and sd of the predictions are returned.
`...`     |     Ignored.


## Details

Given "new" input points, the method compute the expectation,
 variance and (optionnally) the covariance of the corresponding
 stochastic process, conditional on the values at the input points
 used when fitting the model.


## Value

A list containing the element `mean` and possibly
  `stdev` and `cov` .


## Note

The names of the formal arguments differ from those of the
  `predict` methods for the S4 classes `"km"` and
  `"KM"` . The formal `x` corresponds to
  `newdata` , `stdev` corresponds to `se.compute` 
 and `cov` to `cov.compute` . These names are chosen
  Python and Octave interfaces to libKriging .


## Author

Yann Richet yann.richet@irsn.fr


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
plot(f)
set.seed(123)
X <- as.matrix(runif(5))
y <- f(X)
points(X, y, col = "blue", pch = 16)
r <- Kriging(y, X, "gauss")
x <-seq(from = 0, to = 1, length.out = 101)
p_x <- predict(r, x)
lines(x, p_x$mean, col = "blue")
lines(x, p_x$mean - 2 * p_x$stdev, col = "blue")
lines(x, p_x$mean + 2 * p_x$stdev, col = "blue")
```


