data {
  int<lower=0> N;
  array[N] int<lower=0> n;
  array[N] int<lower=0> r;
  vector[N] x;
}
transformed data {
  vector[N] centered_x;
  real mean_x;
  mean_x = mean(x);
  centered_x = x - mean_x;
}
parameters {
  real alpha_star;
  real beta;
}
transformed parameters {
  vector[N] m;
  m = alpha_star + beta * centered_x;
}
model {
  alpha_star ~ normal(0.0, 1.0E4);
  beta ~ normal(0.0, 1.0E4);
  r ~ binomial_logit(n, m);
}
generated quantities {
  real alpha;
  array[N] real p;
  array[N] real llike;
  array[N] real rhat;
  for (i in 1 : N) {
    p[i] = inv_logit(m[i]);
    llike[i] = r[i] * log(p[i]) + (n[i] - r[i]) * log(1 - p[i]);
    rhat[i] = p[i] * n[i]; // fitted values
  }
  alpha = alpha_star - beta * mean_x;
}

