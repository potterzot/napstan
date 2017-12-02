data {
  int<lower=1>  N;
  int<lower=1>  k;
  matrix[N,k]   x;
  vector[N]     y;
  matrix[1,1]   S; //Wishart scale parameter
}
parameters {
  vector[k]     beta;  //does not vary by any cluster
  //matrix[1,1]   sigma; //same
}
transformed parameters {
  vector[N]     y_hat;
  
  for(i in 1:N) 
    y_hat[i] = x[i] * beta;
  
}
model {
  //Priors
  
  // Can be a student_t(1, 0, 2.5), i.e. cauchy, as described here:
  // https://github.com/stan-dev/stan/wiki/Prior-Choice-Recommendations
  //beta ~ student_t(1, 0, 2.5);
  beta ~ normal(0,1);
  
  // Often recommended to be inverse-wishart, but issues. Instead, wishart with
  // df = number of group-level varying coefficients + 2
  // S  = identity matrix * value that is large relative to scale of problem.
  // See Chung et al. 2015, doi: 0.3102/1076998615570945.
  //sigma ~ wishart(0+2, S);
  
  //Likelihood
  y ~ normal(y_hat, 1);
}
