data{
  int<lower=0> N;
  int y[N];
}
parameters {
  real<lower=0, upper=1> theta;
}
transformed parameters {
}
model {
  theta ~ beta(1,1);
  y ~ bernoulli(theta);
}
generated quantities {
  //vector[N] y_sim;
  //y_sim = binomial_rng(N, theta);
}
