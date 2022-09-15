# `NuggetKriging::update`


## Description

Update a `NuggetKriging` model object with new points


## Usage

* Python
    ```python
    # k = NuggetKriging(...)
    k.update(newy, newX)
    ```
* R
    ```r
    # k = NuggetKriging(...)
    k$update(newy, newX)
    ```
* Matlab/Octave
    ```octave
    % k = NuggetKriging(...)
    k.update(newy, newX)
    ```


## Arguments

Argument      |Description
------------- |----------------
`newy`     |     Numeric vector of new responses (output).
`newX`     |     Numeric matrix of new input points.


## Examples

```r
f <- function(x) 1- 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x)*x^5 + 0.7)
plot(f)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X) + 0.1 * rnorm(nrow(X))
points(X, y, col = "blue")

k <- NuggetKriging(y, X, "matern3_2")

x <- sort(c(X,seq(from = 0, to = 1, length.out = 101))) # include design points to see interpolation
p <- k$predict(x)
lines(x, p$mean, col = "blue")
polygon(c(x, rev(x)), c(p$mean - 2 * p$stdev, rev(p$mean + 2 * p$stdev)), border = NA, col = rgb(0, 0, 1, 0.2))

newX <- as.matrix(runif(3))
newy <- f(newX) + 0.1 * rnorm(nrow(newX))
points(newX, newy, col = "red")

## change the content of the object 'k'
k$update(newy, newX)

x <- sort(c(X,newX,seq(from = 0, to = 1, length.out = 101))) # include design points to see interpolation
p2 <- k$predict(x)
lines(x, p2$mean, col = "red")
polygon(c(x, rev(x)), c(p2$mean - 2 * p2$stdev, rev(p2$mean + 2 * p2$stdev)), border = NA, col = rgb(1, 0, 0, 0.2))
```

### Results
```{literalinclude} ../examples/update.NuggetKriging.md.Rout
:language: bash
```
![](../examples/update.NuggetKriging.md.png)
