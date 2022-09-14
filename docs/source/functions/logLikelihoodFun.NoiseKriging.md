# `NoiseKriging::logLikelihoodFun`


## Description

Compute Log-Likelihood of NoiseKriging Model for given $\theta,\sigma^2$



## Usage

* Python
    ```python
    # k = NoiseKriging(...)
    k.logLikelihoodFun(theta_sigma2)
    ```
* R
    ```r
    # k = NoiseKriging(...)
    k$logLikelihoodFun(theta_sigma2)
    ```
* Matlab/Octave
    ```octave
    % k = NoiseKriging(...)
    k.logLikelihoodFun(theta_sigma2)
    ```


## Arguments

Argument      |Description
------------- |----------------
`theta_sigma2`     |     A numeric vector of (positive) range parameters and variance at which the log-likelihood will be evaluated.
`grad`     |     Logical. Should the function return the gradient?


## Value

The log-Likelihood computed for given
  $\theta,\sigma^2$ .


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X) + 1:10/20  *rnorm(nrow(X))

k <- NoiseKriging(y, 1:10/20^2, X, kernel = "matern3_2")
print(k)

# sigma2 = k$sigma2()
# ll <- function(theta) k$logLikelihoodFun(cbind(theta,sigma2))$logLikelihood
# t <- seq(from = 0.001, to = 2, length.out = 101)
# plot(t, ll(t), type = 'l')
# abline(v = k$theta(), col = "blue")

ll <- function(theta_sigma2) k$logLikelihoodFun(theta_sigma2)$logLikelihood
t <- seq(from = 0.001, to = 1, length.out = 31)
contour(t,0.5*t,matrix(ncol=length(t),ll(expand.grid(t,0.5*t))),xlab="theta",ylab="sigma2")
points(k$theta(),k$sigma2(),col='blue')
```

### Results
```{literalinclude} ../examples/logLikelihoodFun.NoiseKriging.md.Rout
:language: bash
```
![](../examples/logLikelihoodFun.NoiseKriging.md.png)
