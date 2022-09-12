# `logMargPostFun.NuggetKriging`

Compute Log-Marginal-Posterior of NuggetKriging Model


## Description

Compute the log-marginal posterior of a kriging model, using the
 prior XXXY.


## Usage

```r
list(list("logMargPostFun"), list("NuggetKriging"))(object, theta_alpha, grad = FALSE, ...)
```


## Arguments

Argument      |Description
------------- |----------------
`object`     |     S3 NuggetKriging object.
`theta_alpha`     |     Numeric vector of correlation range and variance parameters at which the function is to be evaluated.
`grad`     |     Logical. Should the function return the gradient (w.r.t theta_alpha)?
`...`     |     Not used.


## Value

The value of the log-marginal posterior computed for the
 given vector theta_alpha.


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
y <- f(X) + 0.01*rnorm(nrow(X))
r <- NuggetKriging(y, X, "gauss")
print(r)
alpha = as.list(r)$sigma2/(as.list(r)$nugget+as.list(r)$sigma2)
lmp <- function(theta) logMargPostFun(r, cbind(theta,alpha))$logMargPost
t <- seq(from = 0.0001, to = 2, length.out = 101)
plot(t, lmp(t), type = "l")
abline(v = as.list(r)$theta, col = "blue")
```


