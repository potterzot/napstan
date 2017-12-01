data{ 
  int N; 
  real<lower=0> theta; 
}
parameters { 
  vector[N] y_hat; 
}
model { 
  for(i in 1:N) 
    y_hat[i] ~ binomial(N, theta); 
}

