data {
  int<lower=1> N;
  int<lower=1> J; // number of counties
  array[N] int<lower=1, upper=J> county;
  vector[N] u;
  vector[N] x;
  vector[N] y;
  real<lower=0, upper=1> phi;
}
parameters {
  vector[2] beta;
  vector[J] eta;
  real mu_b;
  real<lower=0> sigma;
  real<lower=0> sigma_b;
}
transformed parameters {
  vector[J] b;
  vector[N] y_hat;
  
  b = mu_b + sigma_b * eta;
  
  for (i in 1 : N) {
    y_hat[i] = b[county[i]] + x[i] * beta[1] + u[i] * beta[2];
  }
}
model {
  mu_b ~ normal(0, 1);
  target += phi * normal_lpdf(mu_b | 0, 1);
  
  eta ~ normal(0, 1);
  target += phi * normal_lpdf(eta | 0, 1);
  
  beta ~ normal(0, 100);
  target += phi * normal_lpdf(beta | 0, 1);
  
  sigma ~ cauchy(0, 2.5);
  target += cauchy_lpdf(sigma | 0, 2.5);
  
  sigma_b ~ cauchy(0, 2.5);
  target += cauchy_lpdf(sigma_b | 0, 2.5);
  
  y ~ normal(y_hat, sigma);
  target += phi * normal_lpdf(y | y_hat, sigma);
}

