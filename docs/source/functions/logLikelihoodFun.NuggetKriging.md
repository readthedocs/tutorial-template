# `NuggetKriging::logLikelihoodFun`


## Description

Compute Log-Likelihood of NuggetKriging Model for given $\theta,\frac{\sigma^2}{\sigma^2+nugget}$



## Usage

* Python
    ```python
    # k = NuggetKriging(...)
    k.logLikelihoodFun(theta_alpha, grad = FALSE)
    ```
* R
    ```r
    # k = NuggetKriging(...)
    k$logLikelihoodFun(theta_alpha, grad = FALSE)
    ```
* Matlab/Octave
    ```octave
    % k = NuggetKriging(...)
    k.logLikelihoodFun(theta_alpha, grad = FALSE)
    ```


## Arguments

Argument      |Description
------------- |----------------
`theta_alpha`     |     A numeric vector of (positive) range parameters and variance over nugget + variance at which the log-likelihood will be evaluated.
`grad`     |     Logical. Should the function return the gradient?


## Value

The log-Likelihood computed for given
  $\theta,\frac{\sigma^2}{\sigma^2+nugget}$ .


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X) + 0.1 * rnorm(nrow(X))

k <- NuggetKriging(y, X, kernel = "matern3_2")
print(k)

# theta0 = k$theta()
# ll_alpha <- function(alpha) k$logLikelihoodFun(cbind(theta0,alpha))$logLikelihood
# a <- seq(from = 0.9, to = 1.0, length.out = 101)
# plot(a, Vectorize(ll_alpha)(a), type = "l",xlim=c(0.9,1))
# abline(v = k$sigma2()/(k$sigma2()+k$nugget()), col = "blue")
# 
# alpha0 = k$sigma2()/(k$sigma2()+k$nugget())
# ll_theta <- function(theta) k$logLikelihoodFun(cbind(theta,alpha0))$logLikelihood
# t <- seq(from = 0.001, to = 2, length.out = 101)
# plot(t, Vectorize(ll_theta)(t), type = 'l')
# abline(v = k$theta(), col = "blue")

ll <- function(theta_alpha) k$logLikelihoodFun(theta_alpha)$logLikelihood
a <- seq(from = 0.9, to = 1.0, length.out = 31)
t <- seq(from = 0.001, to = 2, length.out = 101)
contour(t,a,matrix(ncol=length(a),ll(expand.grid(t,a))),xlab="theta",ylab="sigma2/(sigma2+nugget)")
points(k$theta(),k$sigma2()/(k$sigma2()+k$nugget()),col='blue')
```

### Results
```{literalinclude} ../functions/exmaples/logLikelihoodFun.NuggetKriging.md.Rout
:language: bash
```
![](../functions/exmaples/logLikelihoodFun.NuggetKriging.md.png)
