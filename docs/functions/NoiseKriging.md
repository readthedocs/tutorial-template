# `NoiseKriging`

Create a `NoiseKriging` Object using libKriging


## Description

Create an object with S3 class `"NoiseKriging"` using
 the libKriging library.


## Usage

```r
NoiseKriging(
  y,
  noise,
  X,
  kernel,
  regmodel = c("constant", "linear", "interactive"),
  normalize = FALSE,
  optim = c("BFGS", "none"),
  objective = c("LL", "LMP"),
  parameters = NULL
)
```


## Arguments

Argument      |Description
------------- |----------------
`y`     |     Numeric vector of response values.
`noise`     |     Numeric vector of response variances.
`X`     |     Numeric matrix of input design.
`kernel`     |     Character defining the covariance model: `"gauss"` , `"exp"` , ... See XXX.
`regmodel`     |     Universal NoiseKriging linear trend.
`normalize`     |     Logical. If `TRUE` both the input matrix `X` and the response `y` in normalized to take values in the interval $[0, 1]$ .
`optim`     |     Character giving the Optimization method used to fit hyper-parameters. Possible values are: `"BFGS"` , `"Newton"` and `"none"` , the later simply keeping the values given in `parameters` . The method `"BFGS"` uses the gradient of the objective. The method `"Newton"` uses both the gradient and the Hessian of the objective.
`objective`     |     Character giving the objective function to optimize. Possible values are: `"LL"` for the Log-Likelihood, `"LOO"` for the Leave-One-Out sum of squares and `"LMP"` for the Log-Marginal Posterior.
`parameters`     |     Initial values for the hyper-parameters. When provided this must be named list with elements `"sigma2"`  and `"theta"` containing the initial value(s) for the variance and for the range parameters. If `theta` is a matrix with more than one row, each row is used as a starting point for optimization.


## Details

The hyper-parameters (variance and vector of correlation ranges)
 are estimated thanks to the optimization of a criterion given by
 `objective` , using the method given in `optim` .


## Value

An object with S3 class `"NoiseKriging"` . Should be used
 with its `predict` , `simulate` , `update` 
 methods.


## Author

Yann Richet yann.richet@irsn.fr


## Examples

```r
X <- as.matrix(c(0.0, 0.25, 0.5, 0.75, 1.0))
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
y <- f(X) + 0.01*rnorm(nrow(X))
## fit and print
(k_R <- NoiseKriging(y, rep(0.01^2,nrow(X)), X, kernel = "gauss"))

x <- as.matrix(seq(from = 0, to = 1, length.out = 100))
p <- predict(k_R, x = x, stdev = TRUE, cov = FALSE)
plot(f)
points(X, y)
lines(x, p$mean, col = "blue")
polygon(c(x, rev(x)), c(p$mean - 2 * p$stdev, rev(p$mean + 2 * p$stdev)),
border = NA, col = rgb(0, 0, 1, 0.2))
s <- simulate(k_R, nsim = 10, seed = 123, x = x)
plot(f, main = "True function and conditional simulations")
points(X, y, pch = 16)
matlines(x, s, col = rgb(0, 0, 1, 0.2), type = "l", lty = 1)
```


