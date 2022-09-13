# `print.Kriging`

Print a `Kriging` object


## Description

Print the content of a `Kriging` object.


## Usage

```r
list(list("print"), list("Kriging"))(x, ...)
```


## Arguments

Argument      |Description
------------- |----------------
`x`     |     A (S3) `Kriging` Object.
`...`     |     Ignored.


## Author

Yann Richet yann.richet@irsn.fr


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(5))
y <- f(X)
r <- Kriging(y, X, "gauss")
print(r)
## same thing
r
```


