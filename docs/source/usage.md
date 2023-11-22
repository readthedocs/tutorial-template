# Usage


libKriging may be used through:

* direct C++ access
* Python wrapper
* R wrapper
* Octave wrapper
* Matlab wrapper

The basic usage is almost the same whatever lang.:

```python   
# input design
X = ... 
# output results
y = ... 

# load/import/... libKriging
...
# build & fit Kriging model
k = Kriging(y, X, "gauss") 
# display model
print(k)

# setup another (dense) input sample 
x = ... 

# use kriging model to predict at x
p = k.predict(x, ...) 

# and/or use kriging model to simulate at x
s = k.simulate(nsim = 10, seed = 123, x)
```

Basic demo
----------

Sample the objective function

$$
f: x \rightarrow 1 - \frac 1 2 \left( {\frac {sin(12  x)} {1 + x} + 2 cos(7 x) x ^ 5 + 0.7} \right)
$$

at $X = \{0.0, 0.25, 0.5, 0.75, 1.0\}$, then predict and simulate in $[0,1]$. 

[This code, for Python, R or Matlab/Octave](pyrm-demo_basic.md) should return for both Python: [![Python](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/libKriging/readthedocs/blob/master/examples/py-demo.ipynb), R: [![R](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/libKriging/readthedocs/blob/master/examples/r-demo.ipynb) or Matlab/Octave :

<img src="img/demo_basic-predict.png" alt="predict" width="100px"/>
<img src="img/demo_basic-simulate.png" alt="simulate" width="100px"/>


SciKit-Learn wrapping
----------

Implement SciKit-Learn BaseEstimator to plot gpr noisy targets (SciKit-Learn example: [![plot gpr noisy targets](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/libKriging/readthedocs/blob/master/examples/plot_gpr_noisy_targets.ipynb) ), using libKriging:

```python
from sklearn.base import BaseEstimator
import pylibkriging as lk
import numpy as np

class KrigingEstimator(BaseEstimator):
  def __init__(self, kernel="matern3_2", regmodel = "constant", normalize = False, optim = "BFGS", objective = "LL", noise = None, parameters = None):
    self.kernel = kernel
    self.regmodel = regmodel
    self.normalize = normalize
    self.optim = optim
    self.objective = objective
    self.noise = noise
    self.parameters = parameters
    if self.parameters is None:
      self.parameters = {}
    if self.noise is None:
      self.kriging = lk.Kriging(self.kernel)
    elif type(self.noise) is float: # homoskedastic user-defined "noise"
      self.kriging = lk.NoiseKriging(self.kernel)
    else:
      raise Exception("noise type not supported:", type(self.noise))

  def fit(self, X, y):
    if self.noise is None:
      self.kriging.fit(y, X, self.regmodel, self.normalize, self.optim, self.objective, self.parameters)
    elif type(self.noise) is float: # homoskedastic user-defined "noise"
      self.kriging.fit(y, np.repeat(self.noise, y.size), X, self.regmodel, self.normalize, self.optim, self.objective, self.parameters)
    else:
      raise Exception("noise type not supported:", type(self.noise))

  def predict(self, X, return_std=False, return_cov=False):
    return self.kriging.predict(X, return_std, return_cov, False)

  def sample_y(self, X, n_samples = 1, random_state = 0):
    return self.kriging.simulate(nsim = n_samples, seed = random_state, x = X)

  def log_marginal_likelihood(self, theta=None, eval_gradient=False):
    if theta is None:
      return self.kriging.logLikeliHood()
    else:
      return self.kriging.logLikeliHoodFun(theta, eval_gradient)
```

More examples
----------

* [![1D demo](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/libKriging/readthedocs/blob/master/examples/demo1D.ipynb)
* [![2D demo](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/libKriging/readthedocs/blob/master/examples/demo2D.ipynb)