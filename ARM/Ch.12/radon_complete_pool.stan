data {
  int<lower=1> N;
  vector[N] x;
  vector[N] y;
  real<lower=0, upper=1> phi;
}
parameters {
  vector[2] beta;
  real<lower=0> sigma;
}
model {
  #sigma ~ cauchy(0, 2.5);
  target += cauchy_lpdf(sigma | 0, 2.5);
  #y ~ normal(beta[1] + beta[2] * x, sigma);
  target += phi * normal_lpdf(y | beta[1] + beta[2] * x, sigma);
}
