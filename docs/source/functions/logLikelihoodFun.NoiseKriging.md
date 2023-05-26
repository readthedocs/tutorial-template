# `NoiseKriging::logLikelihoodFun`


## Description

Compute the Profile Log-Likelihood of a ` NoiseKriging` Model for a
given Vector $\boldsymbol{\theta}$ of Correlation Ranges and a given
GP Variance $\sigma^2$


## Usage

* Python
    ```python
    # k = NoiseKriging(...)
    k.logLikelihoodFun(theta_sigma2, grad)
    ```
* R
    ```r
    # k = NoiseKriging(...)
    k$logLikelihoodFun(theta_sigma2, grad)
    ```
* Matlab/Octave
    ```octave
    % k = NoiseKriging(...)
    k.logLikelihoodFun(theta_sigma2, grad)
    ```


## Arguments

Argument      |Description
------------- |----------------
`theta_sigma2` |  A numeric vector of (positive) range parameters and variance at which the log-likelihood will be evaluated.
`grad`     |     Logical. Should the function return the gradient?


## Details

The profile log-likelihood is obtained from the log-likelihood
function $\ell(\boldsymbol{\theta},\, \sigma^2, \,
\boldsymbol{\beta})$ by replacing the vector $\boldsymbol{\beta}$ of
trend coefficients by its ML estimate $\widehat{\boldsymbol{\beta}}$
which is obtained by Generalized Least Squares. See [here](SecMLProf)
for more details.

## Value

The value of the profile log-likelihood
$\ell_{\texttt{prof}}(\boldsymbol{\theta},\,\sigma^2)$ for the given
vector $\boldsymbol{\theta}$ of correlation ranges and the given GP
variance $\sigma^2$.


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X) + X/10  *rnorm(nrow(X))

k <- NoiseKriging(y, (X/10)^2, X, kernel = "matern3_2")
print(k)

# theta0 = k$theta()
# ll_sigma2 <- function(sigma2) k$logLikelihoodFun(cbind(theta0,sigma2))$logLikelihood
# s2 <- seq(from = 0.001, to = 1, length.out = 101)
# plot(s2, Vectorize(ll_sigma2)(s2), type = 'l')
# abline(v = k$sigma2(), col = "blue")

# sigma20 = k$sigma2()
# ll_theta <- function(theta) k$logLikelihoodFun(cbind(theta,sigma20))$logLikelihood
# t <- seq(from = 0.001, to = 2, length.out = 101)
# plot(t, Vectorize(ll_theta)(t), type = 'l')
# abline(v = k$theta(), col = "blue")

ll <- function(theta_sigma2) k$logLikelihoodFun(theta_sigma2)$logLikelihood
s2 <- seq(from = 0.001, to = 1, length.out = 31)
t <- seq(from = 0.001, to = 2, length.out = 31)
contour(t,s2,matrix(ncol=length(s2),ll(expand.grid(t,s2))),xlab="theta",ylab="sigma2")
points(k$theta(),k$sigma2(),col='blue')
```

### Results
```{literalinclude} ../functions/examples/logLikelihoodFun.NoiseKriging.md.Rout
:language: bash
```
![](../functions/examples/logLikelihoodFun.NoiseKriging.md.png)
