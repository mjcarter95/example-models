data {
  int<lower=0> N;
  vector[N] dist;
  array[N] int<lower=0, upper=1> switc;
}
parameters {
  vector[2] beta;
}
model {
  switc ~ bernoulli_logit(beta[1] + beta[2] * dist / 100);
}

