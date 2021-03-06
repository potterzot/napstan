data{
  int<lower=0> N;
  int<lower=0> k;
  int y[N];
}
parameters {
  real<lower=0, upper=1> theta;
}
transformed parameters {
}
model {
  theta ~ beta(1,1);      //Prior
  y ~ binomial(k, theta); //Likelihood
}
generated quantities {
  //vector[N] y_sim;
  //y_sim = binomial_rng(N, theta);
}
