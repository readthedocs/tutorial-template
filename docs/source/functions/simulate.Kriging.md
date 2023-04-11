# `Kriging::simulate`


## Description

Simulate from a `Kriging` Model Object.


## Usage

* Python
    ```python
    # k = Kriging(...)
    k.predict(nsim = 1, seed = 123, x)
    ```
* R
    ```r
    # k = Kriging(...)
    k$predict(nsim = 1, seed = 123, x)
    ```
* Matlab/Octave
    ```octave
    % k = Kriging(...)
    k.predict(nsim = 1, seed = 123, x)
    ```


## Arguments

Argument      |Description
------------- |----------------
`nsim`     |     Number of simulations to perform.
`seed`     |     Random seed used.
`x`     |     Points in model input space where to simulate.


## Details

This method draws $n_{\texttt{sim}}$ paths of the stochastic process
$y(\mathbf{x})$ at the $n^\star$ given new input points
$\mathbf{x}^\star_j$ conditional on the values $y(\mathbf{x}_i)$ at
the input points used in the fit.

## Value

A matrix with `length(x)` rows and `nsim` columns containing the
simulated paths at the inputs points given in `x`.


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
plot(f)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X)
points(X, y, col = "blue")

k <- Kriging(y, X, kernel = "matern3_2")

x <- seq(from = 0, to = 1, length.out = 101)
s <- k$simulate(nsim = 3, x = x)

lines(x, s[ , 1], col = "blue")
lines(x, s[ , 2], col = "blue")
lines(x, s[ , 3], col = "blue")
```

### Results
```{literalinclude} ../functions/examples/simulate.Kriging.md.Rout
:language: bash
```
![](../functions/examples/simulate.Kriging.md.png)


## Reference

* Code: <https://github.com/libKriging/libKriging/blob/master/src/lib/Kriging.cpp#L1501>


