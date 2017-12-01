#!/usr/bin/Rscript

# Test binomial DGP and STAN model

# Initial setup ----------------------------------------------------------------
library(testthat)
library(rstan)

rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# Parameters and data generation -----------------------------------------------
p = 0.333
n <- 1000
k <- 10

# Compile the stan model
model <- stan_model(file = "binomial.stan")

# Generate sample data
data_r <- rbinom(n = n, size = k, prob = p) #R method

dgp <- stan("binomial_dgp.stan", data = list(N = n, theta = p))
data_stan 
binomial_rng
sim_data <- sampling(model, data = list(N = n, ), fixed_param =TRUE)


  
# Estimate the parameters and test ---------------------------------------------
model_data = list(N = n, y = data)
sim_data <- sampling(model, data = list(N = n, ))