data {
  int<lower=1> N;
  int<lower=1> k;
  simplex[k]   theta;
}
model {}
generated quantities {
  int<lower=0> y[N,k];
  
  for(i in 1:N)
    //for(j in 1:k)
    y[i] = multinomial_rng(theta, k);
}
