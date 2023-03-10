# `NuggetKriging::logLikelihoodFun`


## Description

Compute the Profile Log-Likelihood of a NuggetKriging Model for given
Vector $\boldsymbol{\theta}$ of Correlation Ranges and a given Ratio
of Variances $\texttt{GP} / (\texttt{GP} + \texttt{nugget})$



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

## Details

Consider the log-likelihood function $\ell(\boldsymbol{\theta}, \, \sigma^2, \,
\tau^2, \,\boldsymbol{\beta})$ where $\sigma^2$ and $\tau^2$ are the
variances of the GP and the nugget components. A re-parameterization
can be used with the two variances replaced by $\nu^2 := \sigma^2 +
\tau^2$ and $\alpha := \sigma^2 / (\sigma^2 + \tau^2)$. The profile
log-likelihood is then obtained by replacing the variance $\nu^2 :=
\sigma^2 + \tau^2$ and the vector $\boldsymbol{\beta}$ of trend
coefficients by their ML estimates $\widehat{\nu}^2$ and
$\widehat{\boldsymbol{\beta}}$ which are obtained by Generalized Least
Squares. See [here](SecMLProf) for more details.

## Value

The value of the profile log-likelihood
$\ell_{\texttt{prof}}(\boldsymbol{\theta},\,\alpha)$ for the given
vector $\boldsymbol{\theta}$ of correlation ranges and the given
variance ratio $\alpha := \sigma^2 / (\sigma^2 + \tau^2)$ where
$\sigma^2$ and $\tau^2$ stand for the GP and the nugget variance. The
parameters must be such that $\theta_k >0$ for $k=1$, $\dots$, $d$ and
$0 < \alpha < 1$.


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
```{literalinclude} ../functions/examples/logLikelihoodFun.NuggetKriging.md.Rout
:language: bash
```
![](../functions/examples/logLikelihoodFun.NuggetKriging.md.png)
