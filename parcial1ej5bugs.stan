data {
  int<lower=0> n;          // Number of observations
  int<lower=0> y[n];       // Observed successes
  int<lower=0> ne[n];      // Number of trials for each observation
  real x[n];               // Predictor variable
  int<lower=0> m;          // Number of predictions for yf2
  real xf[m];              // Predictor variable for yf2 predictions
  int<lower=0> nef[m];     // Number of trials for each prediction in yf2
}

parameters {
  real beta[2];            // Regression coefficients
}

transformed parameters {
  real p[n];               // Probability of success for each observation
  real pf[m];              // Probability of success for each prediction in yf2

  for (i in 1:n) {
    p[i] = inv_logit(beta[1] + beta[2] * x[i]);
  }

  for (i in 1:m) {
    pf[i] = inv_logit(beta[1] + beta[2] * xf[i]);
  }
}

model {
  for (i in 1:n) {
    y[i] ~ binomial(ne[i], p[i]);
  }

  for (j in 1:2) {
    beta[j] ~ normal(0, 0.001);
  }
}

generated quantities {
  int yf1[n];              // Generated predictions for yf1
  int yf2[m];              // Generated predictions for yf2

  for (i in 1:n) {
    yf1[i] = binomial_rng(ne[i], p[i]);
  }

  for (i in 1:m) {
    yf2[i] = binomial_rng(nef[i], pf[i]);
  }
}
