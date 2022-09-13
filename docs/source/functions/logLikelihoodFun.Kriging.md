# `logLikelihoodFun.Kriging`

Compute Log-Likelihood of Kriging Model


## Description

Compute Log-Likelihood of Kriging Model


## Usage

```r
list(list("logLikelihoodFun"), list("Kriging"))(object, theta, grad = FALSE, hess = FALSE, ...)
```


## Arguments

Argument      |Description
------------- |----------------
`object`     |     An S3 Kriging object.
`theta`     |     A numeric vector of (positive) range parameters at which the log-likelihood will be evaluated.
`grad`     |     Logical. Should the function return the gradient?
`hess`     |     Logical. Should the function return Hessian?
`...`     |     Not used.


## Value

The log-Likelihood computed for given
  $\boldsymbol{theta}$ .


## Author

Yann Richet yann.richet@irsn.fr


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(5))
y <- f(X)
r <- Kriging(y, X, kernel = "gauss")
print(r)
ll <- function(theta) logLikelihoodFun(r, theta)$logLikelihood
t <- seq(from = 0.0001, to = 2, length.out = 101)
plot(t, ll(t), type = 'l')
abline(v = as.list(r)$theta, col = "blue")
```


