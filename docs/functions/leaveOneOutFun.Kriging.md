# `leaveOneOutFun.Kriging`

Leave-One-Out Method for the S3 class `"Kriging"`


## Description

Compute Leave-One-Out (LOO) error for an object with S3 class
 `"Kriging"` representing a kriging model.


## Usage

```r
list(list("leaveOneOutFun"), list("Kriging"))(object, theta, grad = FALSE, ...)
```


## Arguments

Argument      |Description
------------- |----------------
`object`     |     A `Kriging` object.
`theta`     |     A numeric vector of range parameters at which the LOO will be evaluated.
`grad`     |     Logical. Should the gradient (w.r.t. `theta` ) be returned?
`...`     |     Not used.


## Details

The returned value is the sum of squares $\sum_{i=1}^n [y_i -$$\hat{y}_{i,(-i)}]^2$ where $\hat{y}_{i,(-i)}$ is the
 prediction of $y_i$ based on the the observations $y_j$ 
 with $j \neq i$ .


## Value

The leave-One-Out value computed for the given vector
  $\boldsymbol{\theta}$ of correlation ranges.


## Author

Yann Richet yann.richet@irsn.fr


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(5))
y <- f(X)
r <- Kriging(y, X, kernel = "gauss", objective = "LOO")
print(r)
loo <-  function(theta) leaveOneOutFun(r,theta)$leaveOneOut
t <-  seq(from = 0.0001, to = 2, length.out = 101)
plot(t, loo(t), type = "l")
abline(v = as.list(r)$theta, col = "blue")
```


