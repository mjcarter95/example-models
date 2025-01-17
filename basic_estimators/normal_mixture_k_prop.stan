data {
  int<lower=1> K;
  int<lower=1> N;
  array[N] real y;
}
parameters {
  simplex[K] theta;
  simplex[K] mu_prop;
  real mu_loc;
  real<lower=0> mu_scale;
  array[K] real<lower=0> sigma;
}
transformed parameters {
  ordered[K] mu;
  mu = mu_loc + mu_scale * cumulative_sum(mu_prop);
}
model {
  // prior
  mu_loc ~ cauchy(0, 5);
  mu_scale ~ cauchy(0, 5);
  sigma ~ cauchy(0, 5);
  
  // likelihood
  {
    array[K] real ps;
    vector[K] log_theta;
    log_theta = log(theta);
    
    for (n in 1 : N) {
      for (k in 1 : K) {
        ps[k] = log_theta[k] + normal_lpdf(y[n] | mu[k], sigma[k]);
      }
      target += log_sum_exp(ps);
    }
  }
}

