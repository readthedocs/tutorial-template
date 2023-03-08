(SecSteps)=
# Kriging steps

* **Trend estimation** If only the trend parameters $\beta_k$ are
  unknown, these can be estimated by [Generalized Least
  Squares](SecGLS). This step separates the observed response $y_i$
  into a trend and component $\widehat{\mu}(\mathbf{x}_i)$ a non-trend
  component. The non-trend component involves a GP component
  $\widehat{\zeta}(\mathbf{x}_i)$ and, optionally, a nugget or noise
  component $\widehat{\varepsilon}(\mathbf{x}_i)$ or
  $\widehat{\varepsilon}_i$.
  
  
* **Fit** Find estimates of the parameters, including the covariance
  parameters. Several methods are implemented, all relying on the
  *optimization* of a function of the [covariance
  parameters](SecParam) called the *objective*. This objective can
  relates to frequentist estimation methods:
  [Maximum-Likelihood](SecMLE) (ML) and [Leave-One-Out](SecLOO)
  Cross-Validation. It can also be a Bayesian [Marginal Posterior
  Density](SecBayes), in relation with specific priors, in which case
  the estimate will be a Maximum A Posteriori (MAP). Mind that in
  **libKriging** only *point estimates* will be given for the
  correlation parameters.

* **Update** Update a model object by processing $n^\star$ new
  observations.  Once this step is achieved, the predictions will be
  based on the full set of $n + n^\star$ observations. The covariance
  parameters can optionally be updated by using the new observations
  when computing the fitting objective.

* **Predict** Given $n^\star$ "new" inputs $\mathbf{x}^\star_i$
  forming the rows of a matrix $\mathbf{X}^\star$, compute the
  Gaussian distribution of $\mathbf{y}^\star$ conditional on
  $\mathbf{y}$. As long as the covariance parameters are regarded as
  known, the conditional distribution is Gaussian, and is
  characterized by its expectation vector and its covariance
  matrix. These are often called the *Kriging mean* and the *Kriging
  covariance*.

* **Simulate** Given $n^\star$ "new" inputs $\mathbf{x}^\star_i$
  forming the rows of a matrix $\mathbf{X}^\star$, draw a sample of
  $n_{\texttt{sim}}$ vectors $\mathbf{y}^\star$ $k=1$, $\dots$,
  $n_{\texttt{sim}}$ from the distribution of $y(\mathbf{x})$
  conditional on the observations.
  
By "Kriging" one often means the prediction step. The fit step is
generally the most costly one in terms of computation because the fit
objective has to be evaluated repeatedly (say dozens of times) and
each evaluation involves $O(n^3)$ elementary operations.
