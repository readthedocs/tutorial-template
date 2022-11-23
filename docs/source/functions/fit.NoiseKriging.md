# `NoiseKriging::fit`


## Description

Fit `NoiseKriging` object on given data.


## Usage

* Python
    ```python
    # k = NoiseKriging(kernel=...)
    k.fit(y, noise, X, 
          regmodel = "constant",
          normalize = False,
          optim = "BFGS",
          objective = "LL",
          parameters = None)
    ```
* R
    ```r
    # k = NoiseKriging(kernel=...)
    k$fit(y, noise, X, 
          regmodel = "constant",
          normalize = FALSE,
          optim = "BFGS",
          objective = "LL",
          parameters = NULL)
    ```
* Matlab/Octave
    ```octave
    % k = NoiseKriging(kernel=...)
    k.fit(y, noise, X, 
          regmodel = "constant",
          normalize = false,
          optim = "BFGS",
          objective = "LL",
          parameters = [])
    ```


## Arguments

Argument      |Description
------------- |----------------
`y`     |     Numeric vector of response values.
`noise`     |     Numeric vector of response variances.
`X`     |     Numeric matrix of input design.
`regmodel`     |     Universal NoiseKriging linear trend.
`normalize`     |     Logical. If `TRUE` both the input matrix `X` and the response `y` in normalized to take values in the interval $[0, 1]$ .
`optim`     |     Character giving the Optimization method used to fit hyper-parameters. Possible values are: `"BFGS"` and `"none"` , the later simply keeping the values given in `parameters` . The method `"BFGS"` uses the gradient of the objective.
`objective`     |     Character giving the objective function to optimize. Possible values are: `"LL"` for the Log-Likelihood.
`parameters`     |     Initial values for the hyper-parameters. When provided this must be named list with elements `"sigma2"`  and `"theta"` containing the initial value(s) for the variance and for the range parameters. If `theta` is a matrix with more than one row, each row is used as a starting point for optimization.
`kernel`     |     Character defining the covariance model: `"exp"` , `"gauss"` , `"matern3_2"` , `"matern5_2"` .


## Details

The hyper-parameters (variance and vector of correlation ranges)
 are estimated thanks to the optimization of a criterion given by
 `objective` , using the method given in `optim` .


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X) + X/10 * rnorm(nrow(X)) # add noise dep. on X

k <- NoiseKriging("matern3_2")
print("before fit")
print(k)

k$fit(y,noise=(X/10)^2,X)
print("after fit")
print(k)
```

### Results
```{literalinclude} ../functions/exmaples/fit.NoiseKriging.md.Rout
:language: bash
```
![](../functions/exmaples/fit.NoiseKriging.md.png)



