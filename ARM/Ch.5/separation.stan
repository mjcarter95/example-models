data {
  int<lower=0> N;
  array[N] int<lower=0, upper=1> y;
  vector[N] x;
}
parameters {
  vector[2] beta;
}
model {
  y ~ bernoulli_logit(beta[1] + beta[2] * x);
}

