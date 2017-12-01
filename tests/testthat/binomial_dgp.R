#!/usr/bin/Rscript

# Data generating process for a binomial ---------------------------------------

# Compile the stan model
model <- stan_model(file = "binomial_dgp.stan")

dgp <- stan("binomial_dgp.stan", data = list(K = k, theta = p))
sim_data <- sampling(model, data = list(k = k, ), fixed_param =TRUE)


