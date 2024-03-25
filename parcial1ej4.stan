data {
  int<lower=0> N;
  vector[N] Y;
  vector[N] X1;
  vector[N] X2;
  vector[N] X3;
  real X1_P;
  real X2_P;
  real X3_P;
}

parameters {
  real beta_0;
  real beta_1;
  real beta_2;
  real beta_3;
  real<lower=0> sigma;
}

transformed parameters {
  vector[N] Y_media;
  Y_media = beta_0 + beta_1 * X1 + beta_2 * X2 + beta_3 * X3;
}

model {
  Y ~ normal(Y_media, sigma);
  beta_0 ~ normal(0, 1);
  beta_1 ~ normal(0, 1);
  beta_2 ~ normal(0, 1);
  beta_3 ~ normal(0, 1);
  sigma ~ normal(0, 1);
}

generated quantities {
  real pred;
  {  
    array[2000] real sim_pred;
    
    for(k in 1:2000){
      sim_pred[k] = beta_0 + beta_1 * X1_P + beta_2 * X2_P + beta_3 * X3_P;

    }
    pred = mean(sim_pred);
  }
}
