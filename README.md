<!-- README.md is generated from README.Rmd. Please edit that file -->
[![ORCiD](https://img.shields.io/badge/ORCiD-0000--0002--3410--3732-green.svg)](http://orcid.org/0000-0002-3410-3732) [![Licence](https://img.shields.io/github/license/mashape/apistatus.svg)](http://choosealicense.com/licenses/mit/)

[![Last-changedate](https://img.shields.io/badge/last%20change-2017--11--30-brightgreen.svg)](https://github.com/potterzot/napstan/commits/master)

napstan (Stan models tested in R and python)
--------------------------------------------

`napstan` is a collection of [Stan](http://mc-stan.org/) models that have been tested to approximate the 'true' parameters. It is intended as a source known working models from which to base models for research, and also as a learning tool to understand how to build bayesian models in Stan.

There are currently two sets of Stan programs. Models that estimate parameters are named after their distribution, like `binomial.stan`. Models that generate sample data from a distribution are named with `_dgp.stan` after the distribution name, for example `binomial_dgp.stan`.

Installing
----------

This is not a true `R` package, so there is no installation, but you can clone this repository to have a copy of these files. You can test the models by running

    make test

in the repository directory, and look at the tests in `tests/testthat` to get a sense of how each model is verified against synthetic data.
