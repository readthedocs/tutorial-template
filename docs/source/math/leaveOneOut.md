(SecLOO)=
# Leave-one-out

Consider $n$ observations $y_i$ from a Kriging model corresponding to
the "`Kriging`" case with no nugget or noise.  For $i=1$, $\dots$, $n$
let $\widehat{y}_{i|-i}$ be the prediction of $y_i$ based on the
vector $\mathbf{y}_{-i}$ obtained by omitting the observation $i$ in
$\mathbf{y}$. The vector of *leave-one-out* (LOO) predictions is
defined by

$$
  \widehat{\mathbf{y}}_{\mathtt{LOO}} :=
  [ \widehat{y}_{1|-1}, \dots, \,  \widehat{y}_{n|-n} ]^\top,
$$

and the leave-one-out Sum of Square Errors criterion is defined by

$$
  \texttt{SSE}_{\texttt{LOO}} :=
  \sum_{i=1}^n \{ y_i - \widehat{y}_{i|-i} \}^2 =
  \| \mathbf{y} - \widehat{\mathbf{y}}_{\texttt{LOO}} \|^2.
$$

It can be shown that

$$ 
\mathbf{y} - \widehat{\mathbf{y}}_{\texttt{LOO}} =
\mathbf{D}_{\mathbf{B}}^{-1}\mathbf{B}\,\mathbf{y} 
$$ 

where $\mathbf{B}$ is the [Bending Energy Matrix](SecBending) (BEM)
and $\mathbf{D}_{\mathbf{B}}$ is the diagonal matrix with the same
diagonal as $\mathbf{B}$.

By minimizing $\texttt{SSE}_{\texttt{LOO}}$ with respect to the
covariance parameters $\theta_\ell$ we get estimates of these. Note
that similarly to the profile likelihood, the LOO MSE does not depend
on the vector $\boldsymbol{\beta}$ of trend parameters.

An estimate of the GP variance $\sigma^2$ is given by

$$
   \widehat{\sigma}^2_{\texttt{LOO}} = 
   \frac{1}{n} \, \mathbf{y}^\top \mathring{\mathbf{B}} 
   \mathbf{D}_{\mathring{\mathbf{B}}}^{-1} 
   \mathring{\mathbf{B}} \mathbf{y}
$$

where $\mathring{\mathbf{B}}:= \sigma^2 \mathbf{B}$ does not depend on
$\sigma^2$ and $\mathbf{D}_{\mathring{\mathbf{B}}}$ is the diagonal
matrix having the same diagonal as $\mathring{\mathbf{B}}$.

The LOO estimation can be preferable to the maximum-likelihood
estimation when the covariance kernel is mispecified, see
{cite:t}`Bachoc_ParametricCov` who provides many details on the
criterion $\texttt{SSE}_{\texttt{LOO}}$, including its derivatives.
