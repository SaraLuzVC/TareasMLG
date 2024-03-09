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

// The input data is a vector 'y' of length 'N'.
data {
    int<lower=1> k;               // Número de observaciones
    int y[k];                     // Número de éxitos (muertos)
    int n[k];                     // Número total de ensayos (expuestos)
    real w[k];                    // Variable predictora (dosis)
  }
  
  parameters {
    real alpha;                   // Intercepto
    real beta;                    // Coeficiente de la variable predictora
  }
  
  model {
    for (i in 1:k) {
      y[i] ~ bernoulli(Phi(alpha + beta * (w[i] - mean(w))));
    }
    
    alpha ~ normal(0, 1);      // Distribución previa para alpha
    beta ~ normal(0, 1);        // Distribución previa para beta
  }


