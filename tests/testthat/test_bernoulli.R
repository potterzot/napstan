#!/usr/bin/Rscript

# Test bernoulli DGP and STAN model

# Initial setup ----------------------------------------------------------------
library(testthat)
suppressMessages(library(rstan))

rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# Parameters and data generation -----------------------------------------------
p <- 0.333
n <- 1000

# Recover the parameters -------------------------------------------------------
test_that("Bernoulli model estimates true parameter", {
  # Generate sample data
  data_r <- rbinom(n = n, size = 1, prob = p) #R method
  
  # Estimate the parameters and test ---------------------------------------------
  model_data = list(N = n, y = data_r)
  bernoulli_fit <- stan(file = "../../bernoulli.stan", data = model_data, 
                    chains = 4, iter = 10000,
                    save_dso = FALSE,
                    warmup=2000)
  p_hat <- extract(bernoulli_fit)$theta
  
  sse <- sum((p_hat - p)^2)/(n-1)
  expect_lt(sse, 0.01)
  
})

test_that("Bernoulli dgp gives correct data", {
  model <- stan_model("../../bernoulli_dgp.stan", save_dso = FALSE)
  stan_sample <- sampling(model, 
                          data = list(N = n, theta = p),
                          save_dso = FALSE,
                          algorithm = "Fixed_param", iter = 10000)
  data_stan <- extract(stan_sample)$y
  expect_lt(mean(data_stan) - p, 0.001)
})



