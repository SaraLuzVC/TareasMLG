data {
  int<lower=0> N;  // Number of observations
  vector[N] datos_2;  // Monthly utility data
}

parameters {
  real mu;  // Mean parameter
  real<lower=0> sigma;  // Standard deviation parameter
}

model {
  datos_2 ~ normal(mu, sigma);  // Likelihood
  mu ~ normal(150,300);  // Prior for the mean
  sigma ~ normal(10,20);  // Prior for the standard deviation
}
