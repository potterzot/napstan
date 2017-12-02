data {
  int<lower=0> N;     //number of samples
  int<lower=0> k;     //number of categories
  simplex[k]   alpha; //probability of each category
  int<lower=0> y[N];  //outcomes
}
parameters {
  simplex[k] theta;  //theta sums to 1
}
model {
  theta ~ dirichlet(alpha)
  y ~ multinomial(theta)
}