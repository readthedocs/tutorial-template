#!/bin/bash

for f in `ls functions`; do
    echo $f
    
    echo "library(rlibkriging)" > /tmp/$f.R
    echo "png('examples/$f.png')"        >> /tmp/$f.R
    cat functions/$f | sed '1,/Examples/d' | sed '1,/```r/d'  | sed '/```/,/$/d' >> /tmp/$f.R
    echo "w<-dev.off()"            >> /tmp/$f.R

    Rscript /tmp/$f.R > examples/$f.Rout
done