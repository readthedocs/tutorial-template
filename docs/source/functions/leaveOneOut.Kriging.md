# `Kriging::leaveOneOut`


## Description

Get the Minimized Leave-One-Out Sum of Squares of a `Kriging` Model


## Usage

* Python
    ```python
    # k = Kriging(...)
    k.leaveOneOut()
    ```
* R
    ```r
    # k = Kriging(...)
    k$leaveOneOut()
    ```
* Matlab/Octave
    ```octave
    % k = Kriging(...)
    k.leaveOneOut()
    ```


## Value

The *minimized* Leave-One-Out (LOO) sum of squares
$\texttt{SSE}_{\texttt{LOO}}$, corresponding to the estimated value
$\widehat{\theta}$ of the vector of correlation ranges. See
[`leaveOneOutFun.Kriging`](leaveOneOutFun.Kriging) for more details.



## Examples

```r
f <- function(x) 1 - 1 / 2 * (sin(12 * x) / (1 + x) + 2 * cos(7 * x) * x^5 + 0.7)
set.seed(123)
X <- as.matrix(runif(10))
y <- f(X)

k <- Kriging(y, X, kernel = "matern3_2", objective="LOO")
print(k)

k$leaveOneOut()
```

### Results
```{literalinclude} ../functions/examples/leaveOneOut.Kriging.md.Rout
:language: bash
```
![](../functions/examples/leaveOneOut.Kriging.md.png)


## Reference

* Code: <https://github.com/libKriging/libKriging/blob/master/src/lib/Kriging.cpp#L350>
