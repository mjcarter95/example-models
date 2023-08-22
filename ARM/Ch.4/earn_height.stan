data {
  int<lower=0> N;
  vector[N] earn;
  vector[N] height;
  real<lower=0, upper=1> phi;
}
parameters {
  vector[2] beta;
  real<lower=0> sigma;
}
model {
  #earn ~ normal(beta[1] + beta[2] * height, sigma);
  target+= phi * normal_lpdf(earn | beta[1] + beta[2] * height, sigma);
  
}
