# `NuggetKriging::logMargPostFun`

## Description

Compute the Log-Marginal Posterior Density of a `NuggetKriging` Model
for a given Vector $\boldsymbol{\theta}$ of Correlation
Ranges and a given Ratio $\sigma^2 / (\sigma^2 + \tau^2)$ of Variances
$\texttt{GP} / (\texttt{GP}+ \texttt{nugget})$


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
`theta_alpha`     |     Numeric vector of correlation range and variance over nugget + variance parameters at which the function is to be evaluated.
`grad`     |     Logical. Should the function return the gradient (w.r.t `theta_alpha`)?

## Details 

The log-marginal posterior density relates to the [*jointly robust*
prior](SecJointlyrobust) $\pi_{\texttt{JR}}(\boldsymbol{\theta},\, \alpha,\,\sigma^2, \,
\boldsymbol{\beta}) \propto \pi(\boldsymbol{\theta},\,\alpha) \, \sigma^{-2}$. The
marginal (or integrated) posterior is the function
$\boldsymbol{\theta}$ and $\alpha$ obtained by marginalizing out the GP variance
$\sigma^2$ and the vector $\boldsymbol{\beta}$ of trend
coefficients. Due to the form of the prior, the marginalization can be
done on the likelihood $p_{\texttt{marg}}(\boldsymbol{\theta}\,\vert
\,\mathbf{y}) \propto \pi(\boldsymbol{\theta}) \times
L_{\texttt{marg}}(\boldsymbol{\theta};\,\mathbf{y})$.

## Value

The value of the log-marginal posterior density $\log
p_{\texttt{marg}}(\boldsymbol{\theta},\,\alpha \,|\, \mathbf{y})$
where $\boldsymbol{\theta}$ is the vector of correlation ranges and
$\alpha = \sigma^2 / (\sigma^2 + \tau^2)$ is the ratio of variances
$\texttt{GP}/ (\texttt{GP} + \texttt{nugget})$.  By maximizing this
function we should get the estimates of $\boldsymbol{\theta}$ and
$\alpha$ obtained when using `objective = "LMP"` in the
[`fit.NuggetKriging`](fit.NuggetKriging) method.


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X) + 0.1 * rnorm(nrow(X))

k <- NuggetKriging(y, X, "matern3_2", objective="LMP")
print(k)

# theta0 = k$theta()
# lmp_alpha <- function(alpha) k$logMargPostFun(cbind(theta0,alpha))$logMargPost
# a <- seq(from = 0.9, to = 1.0, length.out = 101)
# plot(a, Vectorize(lmp_alpha)(a), type = "l",xlim=c(0.9,1))
# abline(v = k$sigma2()/(k$sigma2()+k$nugget()), col = "blue")
# 
# alpha0 = k$sigma2()/(k$sigma2()+k$nugget())
# lmp_theta <- function(theta) k$logMargPostFun(cbind(theta,alpha0))$logMargPost
# t <- seq(from = 0.001, to = 2, length.out = 101)
# plot(t, Vectorize(lmp_theta)(t), type = 'l')
# abline(v = k$theta(), col = "blue")

lmp <- function(theta_alpha) k$logMargPostFun(theta_alpha)$logMargPost
t <- seq(from = 0.4, to = 0.6, length.out = 51)
a <- seq(from = 0.9, to = 1, length.out = 51)
contour(t,a,matrix(ncol=length(t),lmp(expand.grid(t,a))),nlevels=50,xlab="theta",ylab="sigma2/(sigma2+nugget)")
points(k$theta(),k$sigma2()/(k$sigma2()+k$nugget()),col='blue')
```

### Results
```{literalinclude} ../functions/examples/logMargPostFun.NuggetKriging.md.Rout
:language: bash
```
![](../functions/examples/logMargPostFun.NuggetKriging.md.png)


