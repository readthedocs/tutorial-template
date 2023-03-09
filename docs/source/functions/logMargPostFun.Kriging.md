# `Kriging::logMargPostFun`

## Description

Compute the log-marginal posterior of a kriging model, using the
 prior XXXY.


## Usage

* Python
    ```python
    # k = Kriging(...)
    k.logMargPostFun(theta, grad = FALSE)
    ```
* R
    ```r
    # k = Kriging(...)
    k$logMargPostFun(theta, grad = FALSE)
    ```
* Matlab/Octave
    ```octave
    % k = Kriging(...)
    k.logMargPostFun(theta, grad = FALSE)
    ```


## Arguments

Argument      |Description
------------- |----------------
`theta`     |     Numeric vector of correlation range parameters at which the function is to be evaluated.
`grad`     |     Logical. Should the function return the gradient (w.r.t theta)?


## Details 

Using the *jointly robust* prior
$\pi_{\texttt{JR}}(\boldsymbol{\theta},\, \sigma^2, \,
\boldsymbol{\beta})$ the marginal or integrated posterior is the
function $\boldsymbol{\theta}$ obtained by marginalizing out the GP
variance $\sigma^2$ and the vector $\boldsymbol{\beta}$ of trend
coefficients.


## Value

A function which compute the log-marginal posterior density $\log
p(\boldsymbol{\theta} \,|\, \mathbf{y})$.


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X)

k <- Kriging(y, X, "matern3_2", objective="LMP")
print(k)

lmp <- function(theta) k$logMargPostFun(theta)$logMargPost

t <- seq(from = 0.01, to = 2, length.out = 101)
plot(t, lmp(t), type = "l")
abline(v = k$theta(), col = "blue")
```

### Results
```{literalinclude} ../functions/examples/logMargPostFun.Kriging.md.Rout
:language: bash
```
![](../functions/examples/logMargPostFun.Kriging.md.png)


