data {
  int<lower=0> N;
  vector<lower=0, upper=200>[N] kid_score;
  vector<lower=0, upper=1>[N] mom_hs;
  real<lower=0, upper=1> phi;
}
parameters {
  vector[2] beta;
  real<lower=0> sigma;
}
model {
  //sigma ~ cauchy(0, 2.5);
  target += cauchy_lpdf(sigma | 0, 2.5);
  kid_score ~ normal(beta[1] + beta[2] * mom_hs, sigma);
  target += phi * normal_lpdf(kid_score | beta[1] + beta[2] * mom_hs, sigma);
}

