#!/usr/bin/Rscript

# Test binomial DGP and STAN model

# Initial setup ----------------------------------------------------------------
library(testthat)
suppressMessages(library(rstan))

rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# Parameters and data generation -----------------------------------------------
p <- 0.333
n <- 1000
k <- 10

# Recover the parameters -------------------------------------------------------
test_that("Binomial model estimates true parameter", {
  # Generate sample data
  data_r <- rbinom(n = n, size = k, prob = p) #R method
  
  # Estimate the parameters and test
  model_data = list(N = n, k = k, y = data_r)
  binom_fit <- stan(file = "../../binomial.stan", data = model_data, 
                    chains = 4, iter = 10000, seed = 2341,
                    save_dso = FALSE,
                    warmup=2000)
  p_hat <- extract(binom_fit)$theta
  
  sse <- sum((p_hat - p)^2)/(n-1)
  expect_lt(sse, 0.002)
  
})

# Data generating process ------------------------------------------------------
test_that("Binomial data generating process returns correct data", {
  model <- stan_model(file = "../../binomial_dgp.stan")
  stan_sample <- sampling(model, 
                          data = list(N = n, k = k, theta = p), 
                          algorithm = "Fixed_param", iter = 10000)
  data_stan <- extract(stan_sample)$y
  expect_lt(p - mean(data_stan)/k, 0.001)
  
})



