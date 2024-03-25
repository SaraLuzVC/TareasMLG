data {
  int<lower=0> N;         // Number of observations
  vector<lower=0>[N] x;               // Time of exposure
  array[N] int y;      // Number of deaths
  array[N] int n;      // Number of miners
  array[1] int new_n;     // New number of miners for prediction
  real<lower=0> new_x;    // New time of exposure for prediction
}

parameters {
  real beta0;               // Intercept
  real beta1;               // Slope
}

transformed parameters {
  vector[N] p_logit_res;
  real pf;
 // for (i in 1:N) {
    p_logit_res= inv_logit(beta0 + beta1 * x); //Liga logistica
 // }
   pf = inv_logit(beta0 + beta1 * new_x);
}

model {
  // Likelihood
  for (i in 1:N) {
    y[i] ~ binomial(n[i], p_logit_res[i]);
  }

  // Priors
  beta0 ~ normal(0, 0.0001);
  beta1 ~ normal(0, 0.0001);
}

// generated quantities {
//   array[N] int new_y;       // Predicted number of deaths for new data;
//   real pred;
//     new_y = binomial_rng(new_n, pf);;
//     pred = mean(new_y);
// 
// }

