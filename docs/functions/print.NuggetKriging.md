# `print.NuggetKriging`

Print a `NuggetKriging` object


## Description

Print the content of a `NuggetKriging` object.


## Usage

```r
list(list("print"), list("NuggetKriging"))(x, ...)
```


## Arguments

Argument      |Description
------------- |----------------
`x`     |     A (S3) `NuggetKriging` Object.
`...`     |     Ignored.


## Author

Yann Richet yann.richet@irsn.fr


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(5))
y <- f(X) + 0.01*rnorm(nrow(X))
r <- NuggetKriging(y, X, "gauss")
print(r)
## same thing
r
```


