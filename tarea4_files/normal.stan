// Ejercicio 6 logaritmos de los valores originales con una distribución normal

data {
  int<lower=0> N;          // Número de observaciones
  vector<lower=0>[N] y;    // Vector de tamaño N de observaciones/datos positivos
}

parameters {
  real mu;                 // Media de la distribución normal en la escala logarítmica
  real<lower=0> sigma;     // Desviación estándar de la distribución normal en la escala logarítmica
}

model {
  // Priors no informativos para mu y sigma
  mu ~ normal(0, 10);
  sigma ~ cauchy(0, 5);

  // Likelihood de los logaritmos de los datos
  for (n in 1:N) {
    log(y[n]) ~ normal(mu, sigma);
  }
}

generated quantities {
  real theta = exp(mu);           // θ en la escala original
  real inv_theta = 1 / theta;     // 1/θ
  real log_theta = mu;            // log(θ) es simplemente mu en este caso
}
