data {
  int<lower=0> N; 
  vector[N] party;
  vector[N] score1;
  vector[N] x;
  real phi<lower=0, upper=1>;
}
transformed data {
  vector[N] inter;

  inter = party .* x;
}
parameters {
  vector[4] beta;
  real<lower=0> sigma;
} 
model {
  // score1 ~ normal(beta[1] + beta[2] * party + beta[3] * x + beta[4] * inter,sigma);
  target += phi * normal_lpdf(score1 | beta[1] + beta[2] * party + beta[3] * x + beta[4] * inter, sigma)
}
