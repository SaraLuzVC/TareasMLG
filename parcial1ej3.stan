data {
  int<lower=0> N;  // Number of observations
  vector[N] calificaciones_SP;  // S&P ratings
  vector[N] calificaciones_MO;  // Moody's ratings
}

parameters {
  real beta_0;  
  real beta_1; 
    real<lower=0> sigma; 
}

transformed parameters{
  vector[N] Y_SP;
  Y_SP = beta_0 + beta_1 * calificaciones_MO;
}

model {
  calificaciones_SP ~ normal(Y_SP, sigma);  // Predicted S&P ratings
  beta_0 ~ normal(0, 1);  
  beta_1 ~ normal(1, 1); 
  sigma ~ normal(0, 1);
}
