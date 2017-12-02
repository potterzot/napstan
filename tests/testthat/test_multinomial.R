#!/usr/bin/Rscript

# Test bernoulli DGP and STAN model

# Initial setup ----------------------------------------------------------------
library(testthat)
suppressMessages(library(rstan))

rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# Parameters and data generation -----------------------------------------------
alpha <- c(.2, .3, .5)
n <- 1000

# Recover the parameters -------------------------------------------------------
test_that("Bernoulli model estimates true parameter", {
  # Generate sample data
  data_r <- t(rmultinom(n = n, size = 100, prob = alpha)) #R method
  
  # Estimate the parameters and test ---------------------------------------------
  model_data = list(N = n, k = length(alpha), alpha = c(1/3, 1/3, 1/3), y = data_r)
  multinomial_fit <- stan(file = "../../multinomial.stan", data = model_data, 
                          chains = 4, iter = 1000,
                          save_dso = FALSE,
                          warmup=500)
  p_hat <- extract(multinomial_fit)$theta
  
  sse <- sum((apply(p_hat, 2, mean) - alpha)^2)
  expect_lt(sse, 0.001)
  
})

test_that("Multinomial dgp gives correct data", {
  model <- stan_model("../../multinomial_dgp.stan", save_dso = FALSE)
  stan_sample <- sampling(model, 
                          data = list(N = n, k = length(alpha), theta = alpha),
                          save_dso = FALSE,
                          algorithm = "Fixed_param", iter = 100)
  data_stan <- extract(stan_sample)$y
  expect_lt(sum((apply(data_stan, 3, mean)/1000 - alpha)^2), 0.001)
})