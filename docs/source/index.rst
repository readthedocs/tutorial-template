libKriging
==========

libKriging is a C++ library for Kriging/Gaussian process regression.

Main features of libKriging are:

* Standard implementation of most common kriging:
    * ordinary/universal kriging
    * nugget (homoskedastic) or noise (heteroskedastic)
    * optimization of hyper-parameters (range, nugget, variance, ...) based on log-likelihood, leave-one-out, log-marginal-posterior
    * (pre-)normalization of conditional data
* Port from and comparison/testing with some standard kriging libraries:
    * https://CRAN.R-project.org/package=DiceKriging
    * https://CRAN.R-project.org/package=RobustGaSP
    * https://github.com/stk-kriging
* Compatibility with commons OS/arch:
    * Windows
    * Linux
    * OSX (intel & ARM)
* (Almost) full wrapper availables for:
    * Python: https://pypi.org/project/pylibkriging/
    * R: https://github.com/libKriging/rlibkriging
    * Octave
    * Matlab

Check out the :doc:`usage` section for further information, and how to :ref:`install` the project.

.. note::

   This project is under active development.

Contents
--------

.. toctree::
   :maxdepth: 1

   install
   usage
   api
   math
   references.rst

