data {
  int<lower=1> N;      //Number of samples
  int<lower=1> k;      //Number of categories
  simplex[k]   alpha;  //dirichlet hyperparams
  int          y[N,k]; //data
}
parameters {
  simplex[k]   theta; //vector sums to one
}
model {
  theta ~ dirichlet(alpha); //prior
  for(i in 1:N)
    y[i] ~ multinomial(theta);   //likelihood
}
