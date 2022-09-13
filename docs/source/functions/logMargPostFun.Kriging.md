# `logMargPostFun.Kriging`

Compute Log-Marginal-Posterior of Kriging Model


## Description

Compute the log-marginal posterior of a kriging model, using the
 prior XXXY.


## Usage

```r
list(list("logMargPostFun"), list("Kriging"))(object, theta, grad = FALSE, ...)
```


## Arguments

Argument      |Description
------------- |----------------
`object`     |     S3 Kriging object.
`theta`     |     Numeric vector of correlation range parameters at which the function is to be evaluated.
`grad`     |     Logical. Should the function return the gradient (w.r.t theta)?
`...`     |     Not used.


## Value

The value of the log-marginal posterior computed for the
 given vector theta.


## Seealso

[`rgasp`](#rgasp) in the RobustGaSP package.


## Author

Yann Richet yann.richet@irsn.fr


## References

XXXY A reference describing the model (prior, ...)


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(5))
y <- f(X)
r <- Kriging(y, X, "gauss")
print(r)
lmp <- function(theta) logMargPostFun(r, theta)$logMargPost
t <- seq(from = 0.0001, to = 2, length.out = 101)
plot(t, lmp(t), type = "l")
abline(v = as.list(r)$theta, col = "blue")
```


