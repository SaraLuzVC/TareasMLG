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

transformed parameters {
  vector[N] media;
  for (i in 1:N){
    media[i] = alpha[i] + beta[i] * t[i]; //modelo dado
  }
}


model {
  for (i in 1:N){
    rt_obs[i] ~ normal(media[i], sigma); //modelo dado
  }
  alpha ~ normal(0, 250);  // distribucion dada
  beta ~ normal(0, 250);   // distribucion dada
}
