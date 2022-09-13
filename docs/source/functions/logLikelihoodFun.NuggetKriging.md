# `NuggetKriging::logLikelihoodFun`


## Description

Compute Log-Likelihood of NuggetKriging Model for given $\theta,\over{\sigma^2}{\sigma^2+nugget}$



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
  $\theta,\over{\sigma^2}{\sigma^2+nugget}$ .


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(5))
y <- f(X) + 0.1*rnorm(nrow(X))
r <- NuggetKriging(y, X, kernel = "gauss")
print(r)
alpha = as.list(r)$sigma2/(as.list(r)$sigma2+as.list(r)$nugget)
ll <- function(theta) r$logLikelihoodFun(cbind(theta,alpha))$logLikelihood
t <- seq(from = 0.001, to = 2, length.out = 101)
plot(t, ll(t), type = 'l')
abline(v = as.list(r)$theta, col = "blue")
```

### Results
```{literalinclude} ../examples/logLikelihoodFun.NuggetKriging.md.Rout
:language: bash
```
![](../examples/logLikelihoodFun.NuggetKriging.md.png)
