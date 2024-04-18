transformed data {
  real<lower=0, upper=1> theta;
  array[2] real mu;
  array[2] real<lower=0> sigma;
  
  mu[1] = 0.0;
  sigma[1] = 0.5;
  mu[2] = 4.0;
  sigma[2] = 3.0;
  theta = 0.25;
}
parameters {
  real y;
}
model {
  target += log_sum_exp(log(theta) + normal_lpdf(y | mu[1], sigma[1]),
                        log(1.0 - theta) + normal_lpdf(y | mu[2], sigma[2]));
}

