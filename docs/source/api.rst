API
=====

libKriging may be used through:

* direct C++ access
* Python wrapper
* R wrapper
* Octave wrapper
* Matlab wrapper

All these syntax are almost identical, just diverging through basic language elements:
   
   ======    =====    =============
   Python    R        Matlab/Octave
   ======    =====    =============
   `a = b`   `a <- b` `a = b`
   `True`    `TRUE`   `true`
   `False`   `FALSE`  `false`
   `None`    `NULL`   `[]`
   `a.b()`   `a$b()`  `a.b()`
   ======    =====    =============


Contructors
-----------

.. toctree::
   :maxdepth: 1

   functions/Kriging.md
   functions/NuggetKriging.md
   functions/NoiseKriging.md


Fit objective
---------

.. toctree::
   :maxdepth: 1

   functions/logLikelihood.Kriging.md
   functions/logLikelihoodFun.Kriging.md
   functions/leaveOneOut.Kriging.md
   functions/leaveOneOutFun.Kriging.md
   functions/logMargPost.Kriging.md
   functions/logMargPostFun.Kriging.md
   functions/logLikelihood.NuggetKriging.md
   functions/logLikelihoodFun.NuggetKriging.md
   functions/logMargPost.NuggetKriging.md
   functions/logMargPostFun.NuggetKriging.md
   functions/logLikelihood.NoiseKriging.md
   functions/logLikelihoodFun.NoiseKriging.md


Regression
---------

.. toctree::
   :maxdepth: 1

   functions/predict.Kriging.md
   functions/simulate.Kriging.md
   functions/update.Kriging.md
   functions/copy.Kriging.md
   functions/predict.NuggetKriging.md
   functions/simulate.NuggetKriging.md
   functions/update.NuggetKriging.md
   functions/copy.NuggetKriging.md
   functions/predict.NoiseKriging.md
   functions/simulate.NoiseKriging.md
   functions/update.NoiseKriging.md
   functions/copy.NoiseKriging.md