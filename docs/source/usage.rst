Usage
=====

.. _usage:

libKriging may be used through:

* direct C++ access
* Python wrapper
* R wrapper
* Octave wrapper
* Matlab wrapper

The basic usage is almost the same whatever lang.:

.. code-block:: python
   :emphasize-lines: 9, 18, 21
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
    p = predict(k, x, ...) 
    
    # and/or use kriging model to simulate at x
    s = simulate(k, nsim = 10, seed = 123, x)


Basic Python/R/Matlab demo
----------

.. include:: pyrm-demo.md
   :parser: myst_parser.sphinx_

