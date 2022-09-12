# `logLikelihoodFun.NoiseKriging`

Compute Log-Likelihood of NoiseKriging Model


## Description

Compute Log-Likelihood of NoiseKriging Model


## Usage

```r
list(list("logLikelihoodFun"), list("NoiseKriging"))(object, theta_sigma2, grad = FALSE, ...)
```


## Arguments

Argument      |Description
------------- |----------------
`object`     |     An S3 NoiseKriging object.
`theta_sigma2`     |     A numeric vector of (positive) range parameters at which the log-likelihood will be evaluated.
`grad`     |     Logical. Should the function return the gradient?
`...`     |     Not used.


## Value

The log-Likelihood computed for given
  $\boldsymbol{theta_sigma2}$ .


## Author

Yann Richet yann.richet@irsn.fr


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(5))
y <- f(X) + 0.01*rnorm(nrow(X))
r <- NoiseKriging(y, rep(0.01^2,5), X, kernel = "gauss")
print(r)
sigma2 = as.list(r)$sigma2
ll <- function(theta) logLikelihoodFun(r, cbind(theta,sigma2))$logLikelihood
t <- seq(from = 0.001, to = 2, length.out = 101)
plot(t, ll(t), type = 'l')
abline(v = as.list(r)$theta, col = "blue")
```


