# `Kriging::leaveOneOutFun`

## Description

Compute Leave-One-Out (LOO) error for an object
 `"Kriging"` representing a kriging model.


## Usage

* Python
    ```python
    # k = Kriging(...)
    k.logMargPostFun(theta, grad = FALSE)
    ```
* R
    ```r
    # k = Kriging(...)
    k$logMargPostFun(theta, grad = FALSE)
    ```
* Matlab/Octave
    ```octave
    % k = Kriging(...)
    k.logMargPostFun(theta, grad = FALSE)
    ```


## Arguments

Argument      |Description
------------- |----------------
`theta`     |     A numeric vector of range parameters at which the LOO will be evaluated.
`grad`     |     Logical. Should the gradient (w.r.t. `theta` ) be returned?


## Details

The returned value is the sum of squares $\sum_{i=1}^n [y_i -$$\hat{y}_{i,(-i)}]^2$ where $\hat{y}_{i,(-i)}$ is the
 prediction of $y_i$ based on the the observations $y_j$ 
 with $j \neq i$ .


## Value

The leave-One-Out value computed for the given vector
  $theta$ of correlation ranges.


## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(5))
y <- f(X)
r <- Kriging(y, X, kernel = "gauss", objective = "LOO", optim="BFGS")
print(r)
loo <-  function(theta) r$leaveOneOutFun(theta)$leaveOneOut
t <-  seq(from = 0.0001, to = 10, length.out = 101)
plot(t, loo(t), type = "l")
abline(v = as.list(r)$theta, col = "blue")
```

### Results
```{literalinclude} ../examples/leaveOneOutFun.Kriging.md.Rout
:language: bash
```
![](../examples/leaveOneOutFun.Kriging.md.png)




