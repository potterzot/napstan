#!/usr/bin/Rscript
# Test a pooled (OLS) model.

# Initial setup ----------------------------------------------------------------
library(testthat)
suppressMessages(library(rstan))

rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# Parameters and data generation -----------------------------------------------
set.seed(5834)
n <- 1000
k <- 3
beta <- rnorm(n = k, mean = 1, sd = 1)
x <- data.frame(
  x1 = rep(1, n),
  x2 = rnorm(n = n, mean = 5, sd = 2),
  x3 = rbinom(n = n, size = 5, p = .25)
)
y_hat <- rowSums(beta * x) + rnorm(n)

# Recover the parameters -------------------------------------------------------
S_hat = diag(1) * sqrt(var(y_hat))
model_data <- list(
  N = n,
  k = k,
  x = as.matrix(x),
  y = y_hat,
  S = S_hat
)

lm <- stan("../../pooled.stan",  data = model_data, 
           chains = 4, iter = 10000, seed = 2341,
           save_dso = FALSE,
           warmup = 2000)
stan_params <- extract(lm)$beta



