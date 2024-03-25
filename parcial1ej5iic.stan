data {
  int<lower=0> N;           // Number of observations
  array[N] int y;       // Observed values
}

parameters {
  vector[N] mu; // mean parameter for each iteration
  vector[N] lambda; // rate parameter for each iteration
}

transformed parameters {
  // Initialize mu and lambda in the transformed parameters block
  vector[N] mu_init = rep_vector(1, N);
  vector[N] lambda_init = rep_vector(1, N);
  
  // Update the first element with the desired initial value
  mu_init[1] = 1;
  lambda_init[1] = 1;
}

model {
  real b1 = 1;              // prior for b1
  real b2 = 1;              // prior for b2
  real a1 = 2;              // prior for a1
  real a2 = 2;              // prior for a2
  int k; // Change point
  
  // Use the initialized parameters
  mu ~ gamma(a1 + sum(y[1:k]), b1 + k); 
  lambda ~ gamma(a2 + sum(y) - sum(y[1:k]), N - k);
  
  k ~ categorical_logit(rep_vector(1, N)); // generate k from the discrete distribution L

  for (i in 1:N) {
    y[i] ~ poisson(mu[i] * (1 - (lambda[i] / mu[i]) ^ (1 * (i <= k))));
  }
}
