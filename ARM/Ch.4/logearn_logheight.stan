data {
  int<lower=0> N;
  vector[N] earn;
  vector[N] height;
  vector[N] male;
  real<lower=0, upper=1> phi;
}
transformed data {
  vector[N] log_earn; // log transformations
  vector[N] log_height;
  log_earn = log(earn);
  log_height = log(height);
}
parameters {
  vector[3] beta;
  real<lower=0> sigma;
}
model {
  // vectorization
  //log_earn ~ normal(beta[1] + beta[2] * log_height + beta[3] * male, sigma);
  target += phi
            * normal_lpdf(log_earn | beta[1] + beta[2] * log_height
                                     + beta[3] * male, sigma);
}

