data {
  int<lower=0> N;           // Number of observations
  array[N] int y;       // Observed values
  vector<lower=0>[N] x;               // Predictor variable
}

parameters {
  real beta0;               // Intercept
  real beta1;               // Slope
}

transformed parameters {
  vector[N] mu;              // Expected values
  for (i in 1:N) {
    mu[i] = exp(beta0 + beta1 * x[i]);  // Link function: Poisson(mu)
  }
}

model {
  // Likelihood
  for (i in 1:N) {
    y[i] ~ poisson(mu[i]);
  }

  // Priors
  beta0 ~ normal(0, 0.0001);
  beta1 ~ normal(0, 0.0001);
}
/*
generated quantities {
  array[N] int yf1;              // Generated predictions for yf1
  real mu_p;
  real mean_y;
  for (i in 1:100) {
    mu_p = exp(beta0 + beta1 * x[i]);
    yf1[i] = poisson_rng(mu_p);
  }
  mean_y = mean(yf1);
}
*/

generated quantities {
    array[N] real mu_samples; // Samples of mu for all years
    for (i in 1:N) {
        mu_samples[i] = mu[i];
    }
}

