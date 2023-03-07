# Trend and kernel in Kriging models

## Trend functions

The possible trend functions in **libKriging** are as follow, by increasing
level of complexity.

* The **constant trend** involves $p = 1$ coefficient and
  $\mathbf{f}(\mathbf{x})^\top\boldsymbol{\beta} = \beta$.
  
* The **linear trend** involves $p = d +1$ coefficients

  $$
    \mathbf{f}(\mathbf{x})^\top \boldsymbol{\beta} = \beta_0 + \sum_{i=1}^d \beta_i \, x_i.
  $$

* The **interactive trend** involves $1 + d + d (d-1) /2$
  coefficients

  $$
    \mathbf{f}(\mathbf{x})^\top \boldsymbol{\beta} = \beta_0  +
    \sum_{i=1}^d \sum_{j=1}^{i-1} \beta_{ji} \, x_j x_i. 
  $$
  
* The **quadratic trend** involves $p = 1 + d + d(d+1) /2$
  coefficients
  
  $$
    \mathbf{f}(\mathbf{x})^\top \boldsymbol{\beta} = \beta_0  +
    \sum_{i=1}^d \sum_{j=1}^i \beta_{ji} \, x_j x_i. 
  $$

Starting from the constant trend, the other forms come by
adding the $d$ linear terms $x_i$, adding the $d \times (d-1) / 2$
interaction terms $x_i x_j$ with $j <i$, and finally adding the
squared input terms $x_i^2$.

For instance with $d=3$ inputs the four possible trends are in order
of complexity

$$
\begin{aligned}
  \textsf{constant} \qquad
  & \mathbf{f}(\mathbf{x})^\top
  = [1] \\
  \textsf{linear} \qquad
  & \mathbf{f}(\mathbf{x})^\top
  = [1, \: x_1, \: x_2,\: \:x_3] \\
  \textsf{interaction} \qquad
  & \mathbf{f}(\mathbf{x})^\top
  = [1, \: x_1, \: x_2,\: x_1x_2, \:x_3,\: x_1x_3,\: x_2x_3] \\
  \textsf{quadratic} \qquad
  & \mathbf{f}(\mathbf{x})^\top
  = [1, \: x_1, \: x_1^2, \: x_2,\: x_1x_2, \: x_2^2, \: x_3,\: x_1x_3,\: x_2x_3, \:x_3^2] \\
\end{aligned}
$$

Mind that the coefficients relate to a specific order of the inputs.

**Caution** The number of coefficients required in the interactive and quadratic
trend increases quadratically with the dimension. For $d = 10$ the
quadratic trend involves $66$ coefficients.
