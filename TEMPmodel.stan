
data {
  int Y[50]; // valores observados
}
parameters {
  real<lower=0, upper=1> theta; // probabilidad
}
model {
  for(i in 1:50) {
    Y[i] ~ bernoulli(theta); // verosimilitud
  }
  theta ~ beta(2,5); // inicial para theta
}

