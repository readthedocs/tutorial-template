# `logMargPost.NuggetKriging`

Get logMargPost of NuggetKriging Model


## Description

Get logMargPost of NuggetKriging Model


## Usage

```r
list(list("logMargPost"), list("NuggetKriging"))(object, ...)
```


## Arguments

Argument      |Description
------------- |----------------
`object`     |     An S3 NuggetKriging object.
`...`     |     Not used.


## Value

The logMargPost computed for fitted
  $\boldsymbol{theta}$ .


## Author

Yann Richet yann.richet@irsn.fr


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(5))
y <- f(X)
r <- Kriging(y, X, kernel = "gauss")
print(r)
logMargPost(r)
```


