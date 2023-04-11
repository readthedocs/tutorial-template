# `Kriging::fit`


## Description

Fit a `Kriging` Object using Given Observations


## Usage

* Python
    ```python
    # k = Kriging(kernel=...)
    k.fit(y, X, 
          regmodel = "constant",
          normalize = False,
          optim = "BFGS",
          objective = "LL",
          parameters = None)
    ```
* R
    ```r
    # k = Kriging(kernel=...)
    k$fit(y, X, 
          regmodel = "constant",
          normalize = FALSE,
          optim = "BFGS",
          objective = "LL",
          parameters = NULL)
    ```
* Matlab/Octave
    ```octave
    % k = Kriging(kernel=...)
    k.fit(y, X, 
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
`X`     |     Numeric matrix of input design.
`regmodel`     |     Universal Kriging linear trend.
`normalize`     |     Logical. If `TRUE` both the input matrix `X` and the response `y` in normalized to take values in the interval $[0, 1]$ .
`optim`     |     Character giving the Optimization method used to fit hyper-parameters. Possible values are: `"BFGS"` , `"Newton"` and `"none"` , the later simply keeping the values given in `parameters` . The method `"BFGS"` uses the gradient of the objective. The method `"Newton"` uses both the gradient and the Hessian of the objective.
`objective`     |     Character giving the objective function to optimize. Possible values are: `"LL"` for the Log-Likelihood, `"LOO"` for the Leave-One-Out sum of squares and `"LMP"` for the Log-Marginal Posterior.
`parameters`     |     Initial values for the hyper-parameters. When provided this must be named list with elements `"sigma2"`  and `"theta"` containing the initial value(s) for the variance and for the range parameters. If `theta` is a matrix with more than one row, each row is used as a starting point for optimization.


## Details

The hyper-parameters (variance and vector of correlation ranges)
 are estimated thanks to the optimization of a criterion given by
 `objective` , using the method given in `optim` .


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X)

k <- Kriging("matern3_2")
print("before fit")
print(k)

k$fit(y,X)
print("after fit")
print(k)
```


### Results
```{literalinclude} ../functions/examples/fit.Kriging.md.Rout
:language: bash
```
![](../functions/examples/fit.Kriging.md.png)


