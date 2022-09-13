# `simulate.Kriging`

Simulation from a `Kriging` Object


## Description

Simulation from a `Kriging` model object.


## Usage

```r
list(list("simulate"), list("Kriging"))(object, nsim = 1, seed = 123, x, ...)
```


## Arguments

Argument      |Description
------------- |----------------
`object`     |     S3 Kriging object.
`nsim`     |     Number of simulations to perform.
`seed`     |     Random seed used.
`x`     |     Points in model input space where to simulate.
`...`     |     Ignored.


## Details

This method draws paths of the stochastic process at new input
 points conditional on the values at the input points used in the
 fit.


## Value

a matrix with `length(x)` rows and `nsim` 
 columns containing the simulated paths at the inputs points
 given in `x` .


## Note

The names of the formal arguments differ from those of the
  `simulate` methods for the S4 classes `"km"` and
  `"KM"` . The formal `x` corresponds to
  `newdata` . These names are chosen Python and
  Octave interfaces to libKriging .


## Author

Yann Richet yann.richet@irsn.fr


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
plot(f)
set.seed(123)
X <- as.matrix(runif(5))
y <- f(X)
points(X, y, col = "blue")
r <- Kriging(y, X, kernel = "gauss")
x <- seq(from = 0, to = 1, length.out = 101)
s_x <- simulate(r, nsim = 3, x = x)
lines(x, s_x[ , 1], col = "blue")
lines(x, s_x[ , 2], col = "blue")
lines(x, s_x[ , 3], col = "blue")
```


