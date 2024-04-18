data {
  int<lower=0> N;
  vector[N] income;
  array[N] int<lower=0, upper=1> vote;
}
parameters {
  vector[2] beta;
}
model {
  vote ~ bernoulli_logit(beta[1] + beta[2] * income);
}

