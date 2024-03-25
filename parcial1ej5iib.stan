data {
  int<lower=0> N; // number of observations
  array[N] int<lower=0> D; // number of disasters each year
}

parameters {
  real<lower=0> lambda1; // rate of disasters before change point
  real<lower=0> lambda2; // rate of disasters after change point
  real<lower=0, upper=N> change_point; // year when the rate changes
}

model {
  // Priors
  lambda1 ~ exponential(.1);
  lambda2 ~ exponential(.1);
  change_point ~ uniform(1, N); // uniform prior for the change point
  
  // Likelihood
  for (n in 1:N) {
    if (n < change_point) {
      D[n] ~ poisson(lambda1);
    } else {
      D[n] ~ poisson(lambda2);
    }
  }
}

generated quantities {
  real rate_change_year;
  rate_change_year = change_point;
}
