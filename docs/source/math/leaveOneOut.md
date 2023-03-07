(SecLOO)=
# Leave-one-out

For $i=1$, $\dots$, $n$ let $\widehat{y}_{i|-i}$ be the prediction of
$y_i$ based on the vector $\mathbf{y}_{-i}$ obtained by omitting the
observation $i$ in $\mathbf{y}$. The vector of *leave-one-out* (LOO)
predictions is defined by

$$
  \widehat{\mathbf{y}}_{\mathtt{LOO}} =
  [ \widehat{y}_{1|-1}, \dots, \,  \widehat{y}_{n|-n} ]^\top,
$$

and the leave-one-out mean square error criterion is defined by

$$
  \texttt{MSE}_{\texttt{LOO}} :=
  \frac{1}{n} \, \sum_{i=1}^n \{ y_i - \widehat{y}_{i|-i} \}^2 =
  \frac{1}{n}\, \| \mathbf{y} - \widehat{\mathbf{y}}_{\texttt{LOO}} \|^2.
$$

It can be shown that

$$ 
\mathbf{y} - \widehat{\mathbf{y}}_{\texttt{LOO}} =
\mathbf{D}_{\mathbf{B}}^{-1}\mathbf{B}\,\mathbf{y} 
$$ 

where $\mathbf{B}$ is the [Bending Energy Matrix](SecBending) (BEM)
and $\mathbf{D}_{\mathbf{B}}$ is the diagonal matrix with the same
diagonal as $\mathbf{B}$.

By minimizing $\texttt{MSE}_{\texttt{LOO}}$ with respect to the
covariance parameters we get estimates of these. Note that
the LOO MSE does not depend on the trend parameters $\boldsymbol{\beta}$.

