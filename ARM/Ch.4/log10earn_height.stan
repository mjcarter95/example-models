data {
  int<lower=0> N;
  vector[N] earn;
  vector[N] height;
  real<lower=0, upper=1> phi;
}
transformed data {           // log 10 transformation
  vector[N] log10_earn;      
  for (i in 1:N) {                       
    log10_earn[i] = log10(earn[i]);
  }
}
parameters {
  vector[2] beta;
  real<lower=0> sigma;
}
model {
  #log10_earn ~ normal(beta[1] + beta[2] * height, sigma);
  target+= phi * normal_lpdf(log10_earn |beta[1] + beta[2] * height, sigma);
}
