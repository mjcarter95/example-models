data {
  int<lower = 1> K;
  int<lower = 0> N[K];
  int<lower = 0> y[K];
  real<lower=0, upper=1> phi;
}
parameters {
  vector<lower = 0, upper = 1>[K] theta;
}
model {
 // y ~ binomial(N, theta);
  target += binomial_lpmf(y | N, theta);
}
generated quantities {
  int<lower = 0, upper = 1> is_best[K];
  for (k in 1:K)
    is_best[k] = (theta[k] >= best_prob);
}
