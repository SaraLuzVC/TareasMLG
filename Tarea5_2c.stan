data {
  int<lower=0> N;      // Numero de datos
  vector<lower=0>[N] rt_obs;    // R(t), tiempos de reacción observados
  vector<lower=0>[N] t;         // días sin dormir
}

parameters {
  vector[N] alpha;  
  vector[N] beta; 
  real<lower=0> sigma; 
}

model {
  for (i in 1:N){
    rt_obs[i] ~ normal(alpha[i] + beta[i] * t[i], sigma); //modelo dado
  }
  alpha ~ normal(0, 250);  // distribucion dada
  beta ~ normal(0, 250);   // distribucion dada
  sigma ~ normal(57,25); // propuesta tomando en cuenta los datos pero tratando de que sea poco informativa
}

generated quantities {
  vector[N] rt_sim;
  for (i in 1:N){
    rt_sim[i] = normal_rng(alpha[i] + beta[i] * t[i], sigma);
  }
}
