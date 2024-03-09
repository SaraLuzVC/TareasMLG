// Gamma

data {
  int<lower=0> N;         // Número de observaciones
  vector<lower=0>[N] y;   // Vector de tamaño N de observaciones/datos positivos
}

parameters {
  real<lower=0> alpha;    // Parámetro de forma de la distribución gamma
  real<lower=0> beta;     // Parámetro de tasa de la distribución gamma
}

model {
  // Priors no informativos para alpha y beta
  alpha ~ normal(0, 10);
  beta ~ normal(0, 10);

  // Likelihood de los datos
  for (n in 1:N) {
    y[n] ~ gamma(alpha, 1 / beta); // Stan utiliza la parametrización inversa de la tasa para la gamma
  }
}

generated quantities {
  real theta = alpha / beta;         // θ para la distribución gamma
  real inv_theta = beta / alpha;     // 1/θ
  real log_theta = log(theta);       // log(θ)
}
