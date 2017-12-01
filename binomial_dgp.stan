data{ 
  int<lower=0> N;
  int<lower=0> k;
  real<lower=0, upper=1> theta; 
}
model { 
}
generated quantities {
  int<lower=0,upper=k> y[N];
  for (i in 1:N)
    y[i] = binomial_rng(k, theta);
}

