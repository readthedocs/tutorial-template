# `update.NuggetKriging`

Update a `NuggetKriging` Object with New Points


## Description

Update a `NuggetKriging` model object with new points


## Usage

```r
list(list("update"), list("NuggetKriging"))(object, newy, newX, ...)
```


## Arguments

Argument      |Description
------------- |----------------
`object`     |     S3 NuggetKriging object.
`newy`     |     Numeric vector of new responses (output).
`newX`     |     Numeric matrix of new input points.
`...`     |     Ignored.


## Author

Yann Richet yann.richet@irsn.fr


## Examples

```r
f <- function(x) 1- 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x)*x^5 + 0.7)
plot(f)
set.seed(123)
X <- as.matrix(runif(5))
y <- f(X) + 0.01*rnorm(nrow(X))
points(X, y, col = "blue")
KrigObj <- NuggetKriging(y, X, "gauss")
x <- seq(from = 0, to = 1, length.out = 101)
p_x <- predict(KrigObj, x)
lines(x, p_x$mean, col = "blue")
lines(x, p_x$mean - 2 * p_x$stdev, col = "blue")
lines(x, p_x$mean + 2 * p_x$stdev, col = "blue")
newX <- as.matrix(runif(3))
newy <- f(newX) + 0.01*rnorm(nrow(newX))
points(newX, newy, col = "red")

## change the content of the object 'KrigObj'
update(KrigObj, newy, newX)
x <- seq(from = 0, to = 1, length.out = 101)
p2_x <- predict(KrigObj, x)
lines(x, p2_x$mean, col = "red")
lines(x, p2_x$mean - 2 * p2_x$stdev, col = "red")
lines(x, p2_x$mean + 2 * p2_x$stdev, col = "red")
```


