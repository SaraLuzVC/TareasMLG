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
  real a;
  real<lower=0> b;   
  real c;
  real<lower=0> d;  
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
  alpha ~ normal(a, b);  // distribucion dada
  beta ~ normal(c, d);   // distribucion dada
  a ~ normal(100,100);
  b ~ cauchy(0,5);
  c ~ normal(10,5);
  d ~ cauchy(0,1);
  sigma ~ normal(57,25); // propuesta tomando en cuenta los datos pero tratando de que sea poco informativa

}

generated quantities {
  vector[N2] rt_sim; // store post-pred samples
  real alpha2;
  real beta2;
  alpha2 = normal_rng(a, b);
  beta2 = normal_rng(c, d);

  for (i in 1:N2)
    rt_sim[i] = normal_rng(alpha2 + beta2 * t2[i], sigma);
}
