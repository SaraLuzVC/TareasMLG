data {
  int<lower=0> N;           // Number of observations
  array[N] int y;       // Observed values
  vector<lower=0>[N] x;               // Predictor variable
}

parameters {
  real beta0;               // Intercept
  real beta1;               // Slope
  real<lower=1, upper=N> tau; // Change point
}

transformed parameters {
  vector[N] mu;              // Expected values
  for (i in 1:N) {
    mu[i] = exp(beta0 + beta1 * step(tau - i)); // Link function with indicator variable
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
  tau ~ uniform(1, N);
}

generated quantities {
  array[N] int yf1;           // Generated predictions for yf1
  for (i in 1:N) {
    yf1[i] = poisson_rng(mu[i]);
  }
}
