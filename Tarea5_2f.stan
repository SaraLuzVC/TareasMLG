data {
  int<lower=0> N;      // Numero de datos
  vector<lower=0>[N] rt_obs;    // R(t), tiempos de reacción observados
  vector<lower=0>[N] t;         // días sin dormir
  array[N] int subject;     // i-ésima persona
}

parameters {
  vector[18] alpha;  
  vector[18] beta; 
  real<lower=0> sigma; 
}

transformed parameters {
  vector[N] media;
  for (i in 1:N){
    media[i] = alpha[subject[i]] + beta[subject[i]] * t[i]; //modelo dado
  }
}


model {
  for (i in 1:N){
    rt_obs[i] ~ normal(media[i], sigma); //modelo dado
  }
  alpha ~ normal(0, 250);  // distribucion dada
  beta ~ normal(0, 250);   // distribucion dada
  sigma ~ normal(57,25); // propuesta tomando en cuenta los datos pero tratando de que sea poco informativa
}

generated quantities {
vector[N] rt_sim; // store post-pred samples
  for (i in 1:N)
    rt_sim[i] = normal_rng(alpha[subject[i]] + beta[subject[i]] * t[i], sigma);
}
