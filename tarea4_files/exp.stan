//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

data {
  int<lower=0> N;         // Número de observaciones
  vector[N] y;            // Vector de tamaño N de observaciones/datos
}

parameters {
  real<lower=0> theta;    // Parámetro de la distribución exponencial
}

model {
  // Prior distribución para theta
  theta ~ normal(0, 10);  // Distribución previa no informativa para log(theta)

  // Likelihood de los datos
  for (n in 1:N) {
    y[n] ~ exponential(theta);
  }
}

generated quantities {
  real log_theta = log(theta); // Logaritmo de theta
  real inv_theta = 1 / theta;  // Inverso de theta
}

