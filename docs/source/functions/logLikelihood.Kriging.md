# `logLikelihood.Kriging`

Get Log-Likelihood of Kriging Model


## Description

Get Log-Likelihood of Kriging Model


## Usage

```r
list(list("logLikelihood"), list("Kriging"))(object, ...)
```


## Arguments

Argument      |Description
------------- |----------------
`object`     |     An S3 Kriging object.
`...`     |     Not used.


## Value

The log-Likelihood computed for fitted
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
logLikelihood(r)
```


