# `NuggetKriging::logMargPostFun`

## Description

Compute the log-marginal posterior of a kriging model, using the prior XXXY for given $\theta,\over{\sigma^2}{\sigma^2+nugget}$


## Usage

* Python
    ```python
    # k = Kriging(...)
    k.logMargPostFun(theta_alpha, grad = FALSE)
    ```
* R
    ```r
    # k = Kriging(...)
    k$logMargPostFun(theta_alpha, grad = FALSE)
    ```
* Matlab/Octave
    ```octave
    % k = Kriging(...)
    k.logMargPostFun(theta_alpha, grad = FALSE)
    ```


## Arguments

Argument      |Description
------------- |----------------
`theta_alpha`     |     Numeric vector of correlation range and variance over nugget+ variance parameters at which the function is to be evaluated.
`grad`     |     Logical. Should the function return the gradient (w.r.t theta_alpha)?


## Value

The value of the log-marginal posterior computed for the
 given vector $\theta,\over{\sigma^2}{\sigma^2+nugget}$.


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(5))
y <- f(X) + 0.1*rnorm(nrow(X))
r <- NuggetKriging(y, X, "gauss")
print(r)
alpha = as.list(r)$sigma2/(as.list(r)$nugget+as.list(r)$sigma2)
lmp <- function(theta) r$logMargPostFun(cbind(theta,alpha))$logMargPost
t <- seq(from = 0.0001, to = 2, length.out = 101)
plot(t, lmp(t), type = "l")
abline(v = as.list(r)$theta, col = "blue")
```

### Results
```{literalinclude} ../examples/logMargPostFun.NuggetKriging.md.Rout
:language: bash
```
![](../examples/logMargPostFun.NuggetKriging.md.png)


