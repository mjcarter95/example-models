data {
  int<lower=1> N;
  array[N] int<lower=0> y;
}
parameters {
  real<lower=0> alpha;
  real<lower=0> beta;
}
model {
  alpha ~ cauchy(0, 10);
  beta ~ cauchy(0, 10);
  for (i in 1 : N) {
    y[i] ~ neg_binomial(alpha, beta);
  }
}

