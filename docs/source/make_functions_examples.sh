#!/bin/bash

# previously geenrate functions content using https://docs.ropensci.org/r2readthedocs/
# R> remotes::install_github("ropenscilabs/r2readthedocs")
# R> r2readthedocs::r2readthedocs("../rlibkriging")
# cp -r ../rlibkriging/docs/functions/*.md docs/source/functions/.

# Rscript -e "install.packages('../libKriging/bindings/R/rlibkriging_0.7-0_R_x86_64-pc-linux-gnu.tar.gz',repos=NULL)"
# cd docs/source
for f in `ls functions`; do
    echo $f
    
    echo "library(rlibkriging)" > /tmp/$f.R
    echo "png('functions/examples/$f.png')"        >> /tmp/$f.R
    cat functions/$f | sed '1,/Examples/d' | sed '1,/```r/d'  | sed '/```/,$d' >> /tmp/$f.R
    echo "w<-dev.off()"            >> /tmp/$f.R

    Rscript /tmp/$f.R > functions/examples/$f.Rout
done