data {
  int<lower=0> N;      // Numero de datos (menos 1, training set)
  vector<lower=0>[N] rt_obs;    // R(t), tiempos de reacción observados
  vector<lower=0>[N] t;         // días sin dormir
  array[N] int subject;     // i-ésima persona
  int<lower=0> N2;          // observacion 18 o test
  vector<lower=0>[N] t2;    // datos de la persona 18
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
  vector[N2] rt_sim; // store post-pred samples
  real alpha2;
  real beta2;
  alpha2 = normal_rng(0, 250);
  beta2 = normal_rng(0, 250);
  
  for (i in 1:N2)
    rt_sim[i] = normal_rng(alpha2 + beta2 * t2[i], sigma);
}
