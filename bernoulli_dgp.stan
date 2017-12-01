data {
  int<lower=0> N;
  real<lower=0,upper=1> theta;
}
model {}
generated quantities {
  int<lower=0,upper=1> y[N];
  for(i in 1:N)
    y[i] = bernoulli_rng(theta); 
}
