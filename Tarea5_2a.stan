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
  for (i in 1:N){ // MODELO AGREGADO
    media[i] = alpha[i] + beta[i] * t[i]; //modelo dado OJO no se considera por sujeto
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
